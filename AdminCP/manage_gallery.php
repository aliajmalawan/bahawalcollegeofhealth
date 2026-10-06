<?php
session_start([
    'cookie_httponly' => true,
    'cookie_samesite' => 'Lax',
    'cookie_secure' => (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off'),
]);
require_once '../includes/config.php';

if (!isset($_SESSION['admin_logged_in'])) {
    header('Location: login.php');
    exit;
}

require_once __DIR__ . '/includes/csrf.php';
csrf_guard();

$message = '';

// Image compression function
function compressImage($source, $destination, $quality = 75) {
    $info = getimagesize($source);
    $mime = $info['mime'];

    switch ($mime) {
        case 'image/jpeg':
            $image = imagecreatefromjpeg($source);
            break;
        case 'image/png':
            $image = imagecreatefrompng($source);
            break;
        case 'image/gif':
            $image = imagecreatefromgif($source);
            break;
        case 'image/webp':
            $image = imagecreatefromwebp($source);
            break;
        default:
            return false;
    }

    // Save compressed image
    imagejpeg($image, $destination, $quality);
    imagedestroy($image);

    return file_exists($destination);
}

// Compress image to target size (100KB)
function compressToTargetSize($source, $destination, $maxSizeKB = 100) {
    $maxSizeBytes = $maxSizeKB * 1024;

    // If already under size, just copy
    if (filesize($source) <= $maxSizeBytes) {
        copy($source, $destination);
        return true;
    }

    // Start with quality 75 and reduce until file is small enough
    $quality = 75;
    $attempts = 0;
    $maxAttempts = 10;

    while ($attempts < $maxAttempts) {
        compressImage($source, $destination, $quality);

        if (file_exists($destination) && filesize($destination) <= $maxSizeBytes) {
            return true;
        }

        // Reduce quality for next attempt
        $quality -= 10;
        $attempts++;

        if ($quality < 10) {
            $quality = 10;
        }
    }

    // If still too large, use the last compressed version
    return file_exists($destination);
}

// Handle delete
if (isset($_GET['action']) && $_GET['action'] == 'delete' && isset($_GET['id'])) {
    $id = intval($_GET['id']);

    // Delete image file
    $img_query = mysqli_query($conn, "SELECT image_path FROM gallery WHERE id = $id");
    if ($img_row = mysqli_fetch_assoc($img_query)) {
        if (file_exists('../' . $img_row['image_path'])) {
            unlink('../' . $img_row['image_path']);
        }
    }

    if (mysqli_query($conn, "DELETE FROM gallery WHERE id = $id")) {
        $message = "Image deleted successfully!";
    }
}

// Handle category delete
if (isset($_GET['action']) && $_GET['action'] == 'delete_category' && isset($_GET['cat_id'])) {
    $cat_id = intval($_GET['cat_id']);
    $cat_row = mysqli_fetch_assoc(mysqli_query($conn, "SELECT slug FROM gallery_categories WHERE id = $cat_id"));

    if ($cat_row) {
        $in_use = mysqli_fetch_assoc(mysqli_query($conn, "SELECT COUNT(*) as c FROM gallery WHERE category = '" . mysqli_real_escape_string($conn, $cat_row['slug']) . "'"));
        if ($in_use && $in_use['c'] > 0) {
            $message = "Error: Can't delete this category — {$in_use['c']} image(s) are still using it. Move or delete those images first.";
        } elseif (mysqli_query($conn, "DELETE FROM gallery_categories WHERE id = $cat_id")) {
            $message = "Category deleted successfully!";
        }
    }
}

// Handle category add/edit
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['cat_name'])) {
    $cat_name = trim($_POST['cat_name']);
    $cat_icon = trim($_POST['cat_icon']) ?: 'fa-tag';
    $cat_order = intval($_POST['cat_order']);
    $cat_status = $_POST['cat_status'] === 'inactive' ? 'inactive' : 'active';

    if ($cat_name === '') {
        $message = "Category name is required.";
    } elseif (isset($_POST['cat_id']) && !empty($_POST['cat_id'])) {
        // Edit existing category — slug stays fixed so existing images keep their category
        $cid = intval($_POST['cat_id']);
        $q = "UPDATE gallery_categories SET name='" . mysqli_real_escape_string($conn, $cat_name) . "', icon='" . mysqli_real_escape_string($conn, $cat_icon) . "', display_order=$cat_order, status='$cat_status' WHERE id=$cid";
        $message = mysqli_query($conn, $q) ? "Category updated successfully!" : "Error updating category.";
    } else {
        // New category — derive a stable slug from the name
        $slug = strtolower(preg_replace('/[^a-z0-9]+/', '_', strtolower($cat_name)));
        $slug = trim($slug, '_');
        if ($slug === '') {
            $message = "Please enter a valid category name.";
        } else {
            $exists = mysqli_fetch_assoc(mysqli_query($conn, "SELECT id FROM gallery_categories WHERE slug = '" . mysqli_real_escape_string($conn, $slug) . "'"));
            if ($exists) {
                $message = "Error: A category with a similar name already exists.";
            } else {
                $q = "INSERT INTO gallery_categories (slug, name, icon, display_order, status) VALUES ('" . mysqli_real_escape_string($conn, $slug) . "', '" . mysqli_real_escape_string($conn, $cat_name) . "', '" . mysqli_real_escape_string($conn, $cat_icon) . "', $cat_order, '$cat_status')";
                $message = mysqli_query($conn, $q) ? "Category added successfully!" : "Error adding category.";
            }
        }
    }
}

// Fetch category for editing
$edit_category = null;
if (isset($_GET['edit_cat'])) {
    $edit_cat_id = intval($_GET['edit_cat']);
    $edit_category = mysqli_fetch_assoc(mysqli_query($conn, "SELECT * FROM gallery_categories WHERE id = $edit_cat_id"));
}

// Fetch all categories (for the management table + the image form dropdown)
$categories = [];
$cat_result = mysqli_query($conn, "SELECT * FROM gallery_categories ORDER BY display_order ASC, name ASC");
if ($cat_result) {
    while ($row = mysqli_fetch_assoc($cat_result)) {
        $categories[] = $row;
    }
}

// Compress + move a single uploaded file into uploads/gallery/, returns the relative path or false
function processGalleryUpload($tmp_path, $original_name) {
    $upload_dir = '../uploads/gallery/';
    if (!file_exists($upload_dir)) {
        mkdir($upload_dir, 0777, true);
    }

    $file_extension = strtolower(pathinfo($original_name, PATHINFO_EXTENSION));
    $allowed_extensions = ['jpg', 'jpeg', 'png', 'gif', 'webp'];
    if (!in_array($file_extension, $allowed_extensions)) {
        return false;
    }

    $new_filename = time() . '_' . uniqid() . '.jpg'; // Always saved as JPG after compression
    $target_file = $upload_dir . $new_filename;

    if (compressToTargetSize($tmp_path, $target_file, 100)) {
        return 'uploads/gallery/' . $new_filename;
    }
    return false;
}

// Turn "annual_sports-day.jpg" into "Annual Sports Day" for images uploaded without a title
function titleFromFilename($filename) {
    $name = pathinfo($filename, PATHINFO_FILENAME);
    $name = preg_replace('/[_\-]+/', ' ', $name);
    $name = trim(preg_replace('/\s+/', ' ', $name));
    return $name !== '' ? ucwords($name) : 'Untitled';
}

// Handle add/edit
if ($_SERVER['REQUEST_METHOD'] == 'POST' && !isset($_POST['cat_name'])) {
    $title_input = trim($_POST['title'] ?? '');
    $category = mysqli_real_escape_string($conn, $_POST['category']);
    $display_order = intval($_POST['display_order']);
    $status = mysqli_real_escape_string($conn, $_POST['status']);
    $editing_id = (isset($_POST['gallery_id']) && !empty($_POST['gallery_id'])) ? intval($_POST['gallery_id']) : null;

    if ($editing_id) {
        // Editing one existing item — single optional image replace
        $title_sql = $title_input !== '' ? "title='" . mysqli_real_escape_string($conn, $title_input) . "', " : '';

        if (isset($_FILES['image']) && $_FILES['image']['error'] == 0) {
            $image_path = processGalleryUpload($_FILES['image']['tmp_name'], $_FILES['image']['name']);
            if ($image_path) {
                $old_img_row = mysqli_fetch_assoc(mysqli_query($conn, "SELECT image_path FROM gallery WHERE id = $editing_id"));
                if ($old_img_row && file_exists('../' . $old_img_row['image_path'])) {
                    unlink('../' . $old_img_row['image_path']);
                }
                $query = "UPDATE gallery SET {$title_sql}image_path='$image_path', category='$category', display_order=$display_order, status='$status' WHERE id=$editing_id";
                $message = mysqli_query($conn, $query) ? "Image updated successfully!" : "Error saving image.";
            } else {
                $message = "Invalid file format. Only JPG, PNG, GIF, WEBP allowed.";
            }
        } else {
            $query = "UPDATE gallery SET {$title_sql}category='$category', display_order=$display_order, status='$status' WHERE id=$editing_id";
            $message = mysqli_query($conn, $query) ? "Gallery item updated successfully!" : "Error updating gallery item.";
        }
    } else {
        // Adding new image(s) — supports selecting multiple files at once
        $files = $_FILES['images'] ?? null;

        if (!$files || empty($files['name'][0])) {
            $message = "Please select at least one image to upload.";
        } else {
            $count = count($files['name']);
            $saved = 0;
            $failed = 0;

            for ($i = 0; $i < $count; $i++) {
                if ($files['error'][$i] !== UPLOAD_ERR_OK) {
                    $failed++;
                    continue;
                }

                $image_path = processGalleryUpload($files['tmp_name'][$i], $files['name'][$i]);
                if (!$image_path) {
                    $failed++;
                    continue;
                }

                if ($title_input !== '') {
                    $item_title = $count > 1 ? $title_input . ' ' . ($i + 1) : $title_input;
                } else {
                    $item_title = titleFromFilename($files['name'][$i]);
                }
                $item_title = mysqli_real_escape_string($conn, $item_title);

                $query = "INSERT INTO gallery (title, image_path, category, display_order, status) VALUES ('$item_title', '$image_path', '$category', $display_order, '$status')";
                if (mysqli_query($conn, $query)) {
                    $saved++;
                } else {
                    $failed++;
                }
            }

            if ($saved > 0) {
                $message = "$saved image" . ($saved > 1 ? 's' : '') . " uploaded successfully!" . ($failed > 0 ? " ($failed failed — invalid format or upload error.)" : '');
            } else {
                $message = "Error: no images were uploaded. Check the file formats (JPG, PNG, GIF, WEBP only).";
            }
        }
    }
}

// Fetch gallery item for editing
$edit_item = null;
if (isset($_GET['edit'])) {
    $edit_id = intval($_GET['edit']);
    $result = mysqli_query($conn, "SELECT * FROM gallery WHERE id = $edit_id");
    $edit_item = mysqli_fetch_assoc($result);
}

// Fetch all gallery items
$gallery = mysqli_query($conn, "SELECT * FROM gallery ORDER BY display_order ASC, id DESC");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Gallery - Admin Panel</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .gallery-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .gallery-item {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        .gallery-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
        }
        .gallery-item img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        .gallery-item-info {
            padding: 15px;
        }
        .gallery-item-actions {
            padding: 10px 15px;
            background: var(--bg-light);
            display: flex;
            gap: 10px;
        }
    </style>
</head>
<body class="admin-body">
    <?php include 'includes/sidebar.php'; ?>
    <div class="main-content">
    <div class="container" style="padding: 30px 20px;">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
            <h1 style="color: var(--primary-color);"><i class="fas fa-images"></i> Manage Gallery</h1>
        </div>

        <?php if ($message): ?>
            <div style="background: <?php echo strpos($message, 'Error') !== false || strpos($message, 'Invalid') !== false ? '#f8d7da' : '#d4edda'; ?>; color: <?php echo strpos($message, 'Error') !== false || strpos($message, 'Invalid') !== false ? '#721c24' : '#155724'; ?>; padding: 15px; border-radius: 8px; margin-bottom: 20px;">
                <?php echo $message; ?>
            </div>
        <?php endif; ?>

        <!-- Add/Edit Form -->
        <div class="card" style="margin-bottom: 30px;">
            <h2 style="color: var(--primary-color); margin-bottom: 20px;"><?php echo $edit_item ? 'Edit Gallery Item' : 'Add New Image(s)'; ?></h2>
            <form method="POST" enctype="multipart/form-data"><?php echo csrf_field(); ?>
                <?php if ($edit_item): ?>
                    <input type="hidden" name="gallery_id" value="<?php echo $edit_item['id']; ?>">
                <?php endif; ?>

                <div class="form-group">
                    <label for="auto_AdminCP_manage_gallery_php_1">Image Title<?php echo $edit_item ? '' : ' (optional when uploading multiple images)'; ?></label>
                    <input id="auto_AdminCP_manage_gallery_php_1" type="text" name="title" value="<?php echo $edit_item ? htmlspecialchars($edit_item['title']) : ''; ?>" placeholder="e.g., Annual Sports Day 2024">
                    <?php if (!$edit_item): ?>
                        <small style="color: var(--text-light); font-size: 12px;">Left blank: each photo is titled from its filename. Filled in with multiple photos selected: used as "Title 1", "Title 2", etc.</small>
                    <?php endif; ?>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label for="auto_AdminCP_manage_gallery_php_2">Category *</label>
                        <select id="auto_AdminCP_manage_gallery_php_2" name="category" required>
                            <?php foreach ($categories as $c): if ($c['status'] !== 'active' && !($edit_item && $edit_item['category'] === $c['slug'])) continue; ?>
                            <option value="<?php echo htmlspecialchars($c['slug']); ?>" <?php echo ($edit_item && $edit_item['category'] == $c['slug']) ? 'selected' : ''; ?>><?php echo htmlspecialchars($c['name']); ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="auto_AdminCP_manage_gallery_php_3">Display Order</label>
                        <input id="auto_AdminCP_manage_gallery_php_3" type="number" name="display_order" value="<?php echo $edit_item ? $edit_item['display_order'] : '0'; ?>" placeholder="0">
                        <small style="color: var(--text-light); font-size: 12px;">Lower numbers appear first</small>
                    </div>

                    <div class="form-group">
                        <label for="auto_AdminCP_manage_gallery_php_4">Status</label>
                        <select id="auto_AdminCP_manage_gallery_php_4" name="status">
                            <option value="active" <?php echo ($edit_item && $edit_item['status'] == 'active') ? 'selected' : ''; ?>>Active</option>
                            <option value="inactive" <?php echo ($edit_item && $edit_item['status'] == 'inactive') ? 'selected' : ''; ?>>Inactive</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <?php if ($edit_item): ?>
                        <label for="auto_AdminCP_manage_gallery_php_5">Upload Image (optional - leave empty to keep current)</label>
                        <input id="auto_AdminCP_manage_gallery_php_5" type="file" name="image" accept="image/*">
                        <?php if (!empty($edit_item['image_path'])): ?>
                            <div style="margin-top: 15px;">
                                <img src="../<?php echo htmlspecialchars($edit_item['image_path']); ?>" alt="Current Image" style="max-width: 300px; border-radius: 8px; box-shadow: var(--shadow);">
                                <p style="margin-top: 5px; font-size: 13px; color: var(--text-light);">Current image</p>
                            </div>
                        <?php endif; ?>
                    <?php else: ?>
                        <label for="auto_AdminCP_manage_gallery_php_6">Upload Image(s) *</label>
                        <input id="auto_AdminCP_manage_gallery_php_6" type="file" name="images[]" accept="image/*" multiple required>
                        <small style="color: var(--text-light); font-size: 12px; display: block; margin-top: 5px;">Select multiple files to upload them all at once — they'll share the same category, order, and status set above.</small>
                    <?php endif; ?>
                </div>

                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> <?php echo $edit_item ? 'Update Image' : 'Add Image(s)'; ?>
                </button>
                <?php if ($edit_item): ?>
                    <a href="manage_gallery.php" class="btn btn-primary" style="background: var(--text-light); margin-left: 10px;">Cancel</a>
                <?php endif; ?>
            </form>
        </div>

        <!-- Manage Categories -->
        <div class="card" style="margin-bottom: 30px;">
            <h2 style="color: var(--primary-color); margin-bottom: 20px;"><i class="fas fa-tags"></i> <?php echo $edit_category ? 'Edit Category' : 'Gallery Categories'; ?></h2>

            <form method="POST" style="margin-bottom: 24px;"><?php echo csrf_field(); ?>
                <?php if ($edit_category): ?>
                    <input type="hidden" name="cat_id" value="<?php echo $edit_category['id']; ?>">
                <?php endif; ?>
                <div style="display: grid; grid-template-columns: 1.4fr 1fr 0.7fr 0.7fr auto; gap: 16px; align-items: end;">
                    <div class="form-group" style="margin-bottom: 0;">
                        <label for="auto_AdminCP_manage_gallery_php_7">Category Name *</label>
                        <input id="auto_AdminCP_manage_gallery_php_7" type="text" name="cat_name" required value="<?php echo $edit_category ? htmlspecialchars($edit_category['name']) : ''; ?>" placeholder="e.g., Convocation">
                        <?php if ($edit_category): ?>
                            <small style="color: var(--text-light); font-size: 12px;">Slug: <?php echo htmlspecialchars($edit_category['slug']); ?> (fixed)</small>
                        <?php endif; ?>
                    </div>
                    <div class="form-group" style="margin-bottom: 0;">
                        <label for="auto_AdminCP_manage_gallery_php_8">Icon (Font Awesome class)</label>
                        <input id="auto_AdminCP_manage_gallery_php_8" type="text" name="cat_icon" value="<?php echo $edit_category ? htmlspecialchars($edit_category['icon']) : 'fa-tag'; ?>" placeholder="fa-tag">
                    </div>
                    <div class="form-group" style="margin-bottom: 0;">
                        <label for="auto_AdminCP_manage_gallery_php_9">Order</label>
                        <input id="auto_AdminCP_manage_gallery_php_9" type="number" name="cat_order" value="<?php echo $edit_category ? $edit_category['display_order'] : count($categories); ?>">
                    </div>
                    <div class="form-group" style="margin-bottom: 0;">
                        <label for="auto_AdminCP_manage_gallery_php_10">Status</label>
                        <select id="auto_AdminCP_manage_gallery_php_10" name="cat_status">
                            <option value="active" <?php echo (!$edit_category || $edit_category['status'] == 'active') ? 'selected' : ''; ?>>Active</option>
                            <option value="inactive" <?php echo ($edit_category && $edit_category['status'] == 'inactive') ? 'selected' : ''; ?>>Inactive</option>
                        </select>
                    </div>
                    <div>
                        <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> <?php echo $edit_category ? 'Update' : 'Add'; ?></button>
                        <?php if ($edit_category): ?>
                            <a href="manage_gallery.php" class="btn btn-primary" style="background: var(--text-light);">Cancel</a>
                        <?php endif; ?>
                    </div>
                </div>
            </form>

            <div style="overflow-x: auto;">
                <table class="data-table" style="width: 100%; border-collapse: collapse;">
                    <thead>
                        <tr style="text-align: left; border-bottom: 2px solid var(--border-color);">
                            <th style="padding: 10px;">Icon</th>
                            <th style="padding: 10px;">Name</th>
                            <th style="padding: 10px;">Slug</th>
                            <th style="padding: 10px;">Order</th>
                            <th style="padding: 10px;">Status</th>
                            <th style="padding: 10px;">Photos</th>
                            <th style="padding: 10px;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($categories as $c):
                            $photo_count = mysqli_fetch_assoc(mysqli_query($conn, "SELECT COUNT(*) as c FROM gallery WHERE category = '" . mysqli_real_escape_string($conn, $c['slug']) . "'"))['c'];
                        ?>
                        <tr style="border-bottom: 1px solid var(--border-color);">
                            <td style="padding: 10px;"><i class="fas <?php echo htmlspecialchars($c['icon']); ?>" style="color: var(--primary-color);"></i></td>
                            <td style="padding: 10px;"><?php echo htmlspecialchars($c['name']); ?></td>
                            <td style="padding: 10px; color: var(--text-light); font-size: 13px;"><?php echo htmlspecialchars($c['slug']); ?></td>
                            <td style="padding: 10px;"><?php echo $c['display_order']; ?></td>
                            <td style="padding: 10px;"><span style="background: <?php echo $c['status'] == 'active' ? '#16A34A' : '#DC2626'; ?>; color: white; padding: 3px 8px; border-radius: 12px; font-size: 11px;"><?php echo ucfirst($c['status']); ?></span></td>
                            <td style="padding: 10px;"><?php echo $photo_count; ?></td>
                            <td style="padding: 10px;">
                                <a href="?edit_cat=<?php echo $c['id']; ?>" class="btn btn-primary" style="padding: 6px 12px; font-size: 12px;"><i class="fas fa-edit"></i> Edit</a>
                                <a href="?action=delete_category&cat_id=<?php echo $c['id']; ?>" class="btn btn-primary" style="padding: 6px 12px; font-size: 12px; background: #DC2626;" onclick="return confirm('Delete category &quot;<?php echo htmlspecialchars(addslashes($c['name'])); ?>&quot;?')"><i class="fas fa-trash"></i> Delete</a>
                            </td>
                        </tr>
                        <?php endforeach; ?>
                        <?php if (empty($categories)): ?>
                        <tr><td colspan="7" style="padding: 20px; text-align: center; color: var(--text-light);">No categories yet — add one above.</td></tr>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Gallery Grid -->
        <div class="card">
            <h2 style="color: var(--primary-color); margin-bottom: 20px;">All Gallery Images</h2>

            <?php if ($gallery && mysqli_num_rows($gallery) > 0): ?>
                <div class="gallery-grid">
                    <?php
                    $cat_name_by_slug = [];
                    foreach ($categories as $c) { $cat_name_by_slug[$c['slug']] = $c['name']; }
                    while ($item = mysqli_fetch_assoc($gallery)) {
                        echo '<div class="gallery-item">';
                        echo '<img src="../' . htmlspecialchars($item['image_path']) . '" alt="' . htmlspecialchars($item['title']) . '">';
                        echo '<div class="gallery-item-info">';
                        echo '<h4 style="margin: 0 0 5px 0; color: var(--primary-color);">' . htmlspecialchars($item['title']) . '</h4>';
                        echo '<p style="margin: 0; font-size: 13px; color: var(--text-light);"><i class="fas fa-tag"></i> ' . htmlspecialchars($cat_name_by_slug[$item['category']] ?? ucfirst($item['category'])) . '</p>';
                        echo '<p style="margin: 5px 0 0 0; font-size: 13px; color: var(--text-light);"><i class="fas fa-sort"></i> Order: ' . $item['display_order'] . '</p>';
                        echo '<span style="background: ' . ($item['status'] == 'active' ? '#16A34A' : '#DC2626') . '; color: white; padding: 3px 8px; border-radius: 12px; font-size: 11px; display: inline-block; margin-top: 5px;">' . ucfirst($item['status']) . '</span>';
                        echo '</div>';
                        echo '<div class="gallery-item-actions">';
                        echo '<a href="?edit=' . $item['id'] . '" class="btn btn-primary" style="padding: 8px 15px; font-size: 13px; flex: 1; text-align: center;"><i class="fas fa-edit"></i> Edit</a>';
                        echo '<a href="?action=delete&id=' . $item['id'] . '" class="btn btn-primary" style="padding: 8px 15px; font-size: 13px; background: #DC2626; flex: 1; text-align: center;" onclick="return confirm(\'Delete this image?\')"><i class="fas fa-trash"></i> Delete</a>';
                        echo '</div>';
                        echo '</div>';
                    }
                    ?>
                </div>
            <?php else: ?>
                <div style="text-align: center; padding: 60px 20px; color: var(--text-light);">
                    <i class="fas fa-images" style="font-size: 80px; margin-bottom: 20px; opacity: 0.3;"></i>
                    <h3 style="margin-bottom: 10px;">No Images Yet</h3>
                    <p>Upload your first image to get started!</p>
                </div>
            <?php endif; ?>
        </div>
    </div>
    </div>
</body>
</html>
