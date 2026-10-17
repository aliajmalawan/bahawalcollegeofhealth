<?php
require_once 'includes/config.php';
$page_title = 'Bahawal Welfare Foundation';
$page_description = 'About the Bahawal Welfare Foundation — its introduction, objectives, welfare activities, projects and contact details.';

$foundation_name = getSetting('foundation_name', 'Bahawal Welfare Foundation');
$foundation_tagline = getSetting('foundation_tagline', '');
$foundation_established = getSetting('foundation_established', '');
$foundation_purpose = trim(getSetting('foundation_purpose', ''));
$foundation_relationship = trim(getSetting('foundation_relationship', ''));
$foundation_logo = getSetting('foundation_logo', '');

$objectives_raw = getSetting('foundation_objectives_list', '');
$objectives = array_values(array_filter(array_map('trim', explode("\n", $objectives_raw))));

$activities = [];
$ar = mysqli_query($conn, "SELECT * FROM foundation_activities WHERE status='active' ORDER BY display_order ASC, activity_date DESC, id DESC");
if ($ar) {
    while ($row = mysqli_fetch_assoc($ar)) {
        $activities[] = $row;
    }
}
$has_activities = count($activities) > 0;

// Projects tagged "Foundation project" in AdminCP > Our Projects (needs add_foundation_fields.sql)
$fdn_projects = [];
if (dbColumnExists($conn, 'projects', 'is_foundation')) {
    $pr = mysqli_query($conn, "SELECT * FROM projects WHERE visibility='active' AND is_foundation=1 ORDER BY display_order ASC, project_date DESC, id DESC");
    if ($pr) { while ($row = mysqli_fetch_assoc($pr)) { $fdn_projects[] = $row; } }
}

// Photo gallery: images from the gallery category the admin assigned to the Foundation
$fdn_gallery = [];
$fdn_gallery_cat = getSetting('foundation_gallery_category', '');
if ($fdn_gallery_cat !== '') {
    $gr = mysqli_query($conn, "SELECT title, image_path FROM gallery WHERE status='active' AND category='" . mysqli_real_escape_string($conn, $fdn_gallery_cat) . "' ORDER BY display_order ASC, id DESC LIMIT 12");
    if ($gr) { while ($row = mysqli_fetch_assoc($gr)) { $fdn_gallery[] = $row; } }
}

// Contact details — shown only when the college has provided them
$fdn_contact = [
    'person'  => ['icon' => 'fa-user',          'label' => 'Contact Person', 'value' => trim(getSetting('foundation_contact_person', ''))],
    'phone'   => ['icon' => 'fa-phone',         'label' => 'Phone',          'value' => trim(getSetting('foundation_phone', ''))],
    'email'   => ['icon' => 'fa-envelope',      'label' => 'Email',          'value' => trim(getSetting('foundation_email', ''))],
    'address' => ['icon' => 'fa-location-dot',  'label' => 'Address',        'value' => trim(getSetting('foundation_address', ''))],
    'website' => ['icon' => 'fa-globe',         'label' => 'Website',        'value' => trim(getSetting('foundation_website', ''))],
];
if ($fdn_contact['website']['value'] !== '' && !preg_match('#^https?://[^\s]+$#i', $fdn_contact['website']['value'])) $fdn_contact['website']['value'] = '';
if ($fdn_contact['email']['value'] !== '' && !filter_var($fdn_contact['email']['value'], FILTER_VALIDATE_EMAIL)) $fdn_contact['email']['value'] = '';
$fdn_contact = array_filter($fdn_contact, function ($c) { return $c['value'] !== ''; });

$status_labels = ['ongoing' => ['Ongoing', '#09A9D9'], 'upcoming' => ['Upcoming', '#F59E0B'], 'completed' => ['Completed', '#16A34A']];

// Sections with content; empty ones are hidden rather than showing placeholders everywhere
$fdn_sections = array_filter([
    'about'      => $foundation_purpose !== '' ? 'Introduction' : null,
    'objectives' => $objectives ? 'Objectives' : null,
    'activities' => $has_activities ? 'Welfare Activities' : null,
    'projects'   => $fdn_projects ? 'Projects' : null,
    'gallery'    => $fdn_gallery ? 'Gallery' : null,
    'contact'    => $fdn_contact ? 'Contact' : null,
]);
$fdn_has_content = $fdn_sections || $foundation_relationship !== '';
?>
<?php include 'includes/header.php'; ?>

<style>
/* ===== BAHAWAL WELFARE FOUNDATION PAGE ===== */

/* --- Hero --- */
.bwf-hero {
    background: linear-gradient(135deg,#0D1048 0%,#17165B 55%,#0D1048 100%);
    padding: 62px 0 50px;
    position: relative; overflow: hidden;
}
.bwf-hero::after {
    content:'';
    position:absolute; bottom:-1px; left:0; right:0;
    height:40px;
    background:#F5F9FC;
    clip-path:ellipse(55% 100% at 50% 100%);
}
.bwf-breadcrumb {
    display:flex; align-items:center; gap:8px;
    font-size:12px; color:rgba(255,255,255,0.5); margin-bottom:18px;
    position:relative; z-index:1;
}
.bwf-breadcrumb a { color:rgba(255,255,255,0.6); text-decoration:none; }
.bwf-breadcrumb a:hover { color:var(--accent-color); }
.bwf-hero-top { display:flex; align-items:center; gap:16px; position:relative; z-index:1; margin-bottom:16px; }
.bwf-hero-logo { width:56px; height:56px; border-radius:14px; background:rgba(255,255,255,0.1); border:1px solid rgba(255,255,255,0.2); display:flex; align-items:center; justify-content:center; overflow:hidden; flex-shrink:0; }
.bwf-hero-logo img { width:100%; height:100%; object-fit:cover; }
.bwf-hero-logo i { color:#fff; font-size:24px; }
.bwf-hero-badge {
    display:inline-flex; align-items:center; gap:7px;
    background:rgba(9,169,217,0.14); border:1px solid rgba(9,169,217,0.35);
    color:var(--accent-color); padding:6px 18px; border-radius:50px;
    font-size:10.5px; font-weight:700; letter-spacing:2px;
    text-transform:uppercase; margin-bottom:16px;
    position:relative; z-index:1;
}
.bwf-hero h1 {
    font-size:36px; font-weight:800; color:#fff;
    margin:0 0 10px; line-height:1.2;
    position:relative; z-index:1;
}
.bwf-hero p {
    color:rgba(255,255,255,0.72); font-size:15px; margin:0; max-width:620px; line-height:1.7;
    position:relative; z-index:1;
}
.bwf-hero-meta { font-size:12px; color:rgba(255,255,255,0.55); margin-top:10px; position:relative; z-index:1; }

/* --- Sections --- */
.bwf-section { padding:48px 0; background:#F5F9FC; }
.bwf-section.bwf-alt { background:#fff; }
.bwf-sh { margin-bottom:24px; }
.bwf-sh-badge {
    display:inline-flex; align-items:center; gap:7px;
    background:rgba(23,22,91,0.08); border:1px solid rgba(23,22,91,0.22);
    color:var(--primary-color); padding:6px 16px; border-radius:50px;
    font-size:10.5px; font-weight:700; letter-spacing:2px;
    text-transform:uppercase; margin-bottom:12px;
}
.bwf-sh h2 { font-size:24px; font-weight:800; color:var(--text-dark); margin:0; }

.bwf-card {
    background:#fff; border-radius:16px; border:1px solid rgba(23,22,91,0.1);
    padding:24px 26px; font-size:14px; color:var(--text-dark); line-height:1.8;
}
.bwf-alt .bwf-card { background:#F5F9FC; }

/* --- Objectives list --- */
.bwf-obj-grid { display:grid; grid-template-columns:repeat(2,1fr); gap:14px; }
@media (max-width:700px) { .bwf-obj-grid { grid-template-columns:1fr; } }
.bwf-obj-item {
    display:flex; align-items:flex-start; gap:12px;
    background:#fff; border:1px solid rgba(23,22,91,0.1); border-radius:12px;
    padding:14px 16px; font-size:13.5px; color:var(--text-dark); line-height:1.6;
}
.bwf-obj-item i { color:var(--accent-color); font-size:14px; margin-top:2px; flex-shrink:0; }

/* --- Activities timeline --- */
.bwf-activity-grid { display:grid; grid-template-columns:repeat(3,1fr); gap:22px; }
@media (max-width:900px) { .bwf-activity-grid { grid-template-columns:1fr; } }
.bwf-activity-card {
    background:#fff; border-radius:14px; border:1px solid rgba(23,22,91,0.1);
    padding:20px 22px;
}
.bwf-activity-icon { width:42px; height:42px; border-radius:10px; background:rgba(23,22,91,0.08); display:flex; align-items:center; justify-content:center; color:var(--primary-color); font-size:17px; margin-bottom:12px; }
.bwf-activity-card h4 { font-size:14.5px; font-weight:800; color:var(--text-dark); margin:0 0 6px; }
.bwf-activity-date { font-size:11px; color:var(--text-light); margin-bottom:8px; display:flex; align-items:center; gap:5px; }
.bwf-activity-card p { font-size:12.5px; color:var(--text-light); line-height:1.6; margin:0; }

/* --- CMS placeholder --- */
.bwf-placeholder {
    text-align:center; padding:40px 30px;
    background:#fff; border-radius:16px; border:1px dashed rgba(23,22,91,0.25);
}
.bwf-alt .bwf-placeholder { background:#F5F9FC; }
.bwf-placeholder i { font-size:36px; color:var(--border-color); margin-bottom:14px; display:block; }
.bwf-placeholder p { color:var(--text-light); font-size:13.5px; margin:0 auto; max-width:460px; line-height:1.7; }

/* --- Section nav, activity images, projects, gallery, contact --- */
.bwf-nav { background:#fff; border-bottom:1px solid rgba(23,22,91,0.08); padding:13px 0; }
.bwf-nav-inner { display:flex; flex-wrap:wrap; gap:8px; justify-content:center; }
.bwf-nav a { padding:6px 15px; border-radius:50px; border:1px solid rgba(23,22,91,0.18); color:var(--text-dark); font-size:12.5px; font-weight:600; text-decoration:none; }
.bwf-nav a:hover { border-color:var(--primary-color); color:var(--primary-color); }
.bwf-section { scroll-margin-top:16px; }
.bwf-activity-card.bwf-has-img { padding:0; overflow:hidden; }
.bwf-activity-img { width:100%; height:170px; object-fit:cover; display:block; }
.bwf-activity-card.bwf-has-img .bwf-activity-inner { padding:18px 20px 20px; }
.bwf-activity-card p { white-space:pre-line; }
.bwf-proj-grid { display:grid; grid-template-columns:repeat(auto-fill,minmax(280px,1fr)); gap:20px; }
.bwf-proj { background:#fff; border:1px solid rgba(23,22,91,0.1); border-radius:16px; overflow:hidden; display:flex; flex-direction:column; }
.bwf-proj-img { height:160px; background:linear-gradient(135deg,var(--primary-color),#0D1048); display:flex; align-items:center; justify-content:center; color:rgba(255,255,255,0.35); font-size:36px; }
.bwf-proj-img img { width:100%; height:100%; object-fit:cover; }
.bwf-proj-body { padding:16px 18px 18px; display:flex; flex-direction:column; gap:7px; flex:1; }
.bwf-proj-body h4 { margin:0; font-size:15px; font-weight:800; color:var(--text-dark); line-height:1.35; }
.bwf-proj-body h4 a { color:inherit; text-decoration:none; }
.bwf-proj-meta { display:flex; gap:8px; flex-wrap:wrap; align-items:center; font-size:11.5px; color:var(--text-light); }
.bwf-proj-status { font-weight:700; border-radius:50px; padding:2px 9px; font-size:10.5px; text-transform:uppercase; letter-spacing:0.4px; }
.bwf-proj-body p { margin:0; font-size:13px; color:var(--text-light); line-height:1.65; }
.bwf-proj-link { margin-top:auto; padding-top:6px; font-size:13px; font-weight:700; color:var(--primary-color); text-decoration:none; }
.bwf-gallery { display:grid; grid-template-columns:repeat(auto-fill,minmax(200px,1fr)); gap:12px; }
.bwf-gallery a { display:block; border-radius:12px; overflow:hidden; aspect-ratio:4/3; background:#e9eef5; }
.bwf-gallery img { width:100%; height:100%; object-fit:cover; transition:transform 0.35s ease; }
.bwf-gallery a:hover img { transform:scale(1.05); }
.bwf-contact { display:grid; grid-template-columns:repeat(auto-fit,minmax(220px,1fr)); gap:14px; max-width:900px; margin:0 auto; }
.bwf-contact-item { display:flex; gap:12px; align-items:flex-start; background:#fff; border:1px solid rgba(23,22,91,0.1); border-radius:14px; padding:14px 16px; }
.bwf-contact-item i { width:38px; height:38px; border-radius:10px; background:rgba(23,22,91,0.08); color:var(--primary-color); display:flex; align-items:center; justify-content:center; flex-shrink:0; }
.bwf-contact-item small { display:block; font-size:10.5px; font-weight:700; letter-spacing:0.8px; text-transform:uppercase; color:var(--text-light); margin-bottom:2px; }
.bwf-contact-item span, .bwf-contact-item a { font-size:13.5px; font-weight:600; color:var(--text-dark); text-decoration:none; overflow-wrap:anywhere; }
.bwf-contact-item a:hover { color:var(--primary-color); }
@media (max-width:600px) { .bwf-hero h1 { font-size:28px; } .bwf-gallery { grid-template-columns:1fr 1fr; gap:8px; } }
</style>

<!-- HERO -->
<section class="bwf-hero">
    <div class="container" style="position:relative;z-index:2;">
        <div class="bwf-breadcrumb">
            <a href="index.php"><i class="fas fa-home" style="font-size:11px;"></i> Home</a>
            <span><i class="fas fa-chevron-right" style="font-size:9px;"></i></span>
            <span><?php echo htmlspecialchars($foundation_name); ?></span>
        </div>
        <div class="bwf-hero-top">
            <div class="bwf-hero-logo">
                <?php if ($foundation_logo): ?>
                    <img src="<?php echo htmlspecialchars($foundation_logo); ?>" alt="<?php echo htmlspecialchars($foundation_name); ?>">
                <?php else: ?>
                    <i class="fas fa-hand-holding-heart"></i>
                <?php endif; ?>
            </div>
            <div class="bwf-hero-badge" style="margin-bottom:0;">
                <i class="fas fa-heart"></i> Welfare Foundation
            </div>
        </div>
        <h1><?php echo htmlspecialchars($foundation_name); ?></h1>
        <?php if ($foundation_tagline !== ''): ?><p><?php echo htmlspecialchars($foundation_tagline); ?></p><?php endif; ?>
        <?php if ($foundation_established !== ''): ?>
        <div class="bwf-hero-meta"><i class="fas fa-calendar" style="margin-right:6px;"></i>Established <?php echo htmlspecialchars($foundation_established); ?></div>
        <?php endif; ?>
    </div>
</section>

<?php if (!$fdn_has_content): ?>
<!-- Nothing provided yet: one admin-managed placeholder instead of empty sections -->
<section class="bwf-section">
    <div class="container">
        <div class="bwf-placeholder">
            <i class="fas fa-hand-holding-heart"></i>
            <p>Information about <?php echo htmlspecialchars($foundation_name); ?> — its introduction, objectives, welfare activities and projects — will be published here once it has been provided by the college.</p>
        </div>
    </div>
</section>
<?php else: ?>

<?php if (count($fdn_sections) > 1): ?>
<nav class="bwf-nav" aria-label="Foundation sections">
    <div class="container bwf-nav-inner">
        <?php foreach ($fdn_sections as $sid => $label): ?><a href="#<?php echo $sid; ?>"><?php echo $label; ?></a><?php endforeach; ?>
    </div>
</nav>
<?php endif; ?>

<?php $alt = true; ?>

<?php if ($foundation_purpose !== '' || $foundation_relationship !== ''): $alt = !$alt; ?>
<!-- INTRODUCTION (+ relationship with B.C.H.S., when provided) -->
<section class="bwf-section <?php echo $alt ? 'bwf-alt' : ''; ?>" id="about">
    <div class="container">
        <?php if ($foundation_purpose !== ''): ?>
        <div class="bwf-sh">
            <div class="bwf-sh-badge"><i class="fas fa-circle-info" style="font-size:9px;"></i> Introduction</div>
            <h2>About the Foundation</h2>
        </div>
        <div class="bwf-card"><?php echo nl2br(htmlspecialchars($foundation_purpose)); ?></div>
        <?php endif; ?>
        <?php if ($foundation_relationship !== ''): ?>
        <div class="bwf-sh" style="margin-top:<?php echo $foundation_purpose !== '' ? '40px' : '0'; ?>;">
            <div class="bwf-sh-badge"><i class="fas fa-link" style="font-size:9px;"></i> Relationship</div>
            <h2>Relationship with <?php echo htmlspecialchars(getSiteName()); ?></h2>
        </div>
        <div class="bwf-card"><?php echo nl2br(htmlspecialchars($foundation_relationship)); ?></div>
        <?php endif; ?>
    </div>
</section>
<?php endif; ?>

<?php if ($objectives): $alt = !$alt; ?>
<!-- OBJECTIVES -->
<section class="bwf-section <?php echo $alt ? 'bwf-alt' : ''; ?>" id="objectives">
    <div class="container">
        <div class="bwf-sh">
            <div class="bwf-sh-badge"><i class="fas fa-list-check" style="font-size:9px;"></i> Objectives</div>
            <h2>Our Objectives</h2>
        </div>
        <div class="bwf-obj-grid">
            <?php foreach ($objectives as $obj): ?>
            <div class="bwf-obj-item"><i class="fas fa-circle-check"></i> <?php echo htmlspecialchars($obj); ?></div>
            <?php endforeach; ?>
        </div>
    </div>
</section>
<?php endif; ?>

<?php if ($has_activities): $alt = !$alt; ?>
<!-- WELFARE ACTIVITIES -->
<section class="bwf-section <?php echo $alt ? 'bwf-alt' : ''; ?>" id="activities">
    <div class="container">
        <div class="bwf-sh">
            <div class="bwf-sh-badge"><i class="fas fa-hand-holding-heart" style="font-size:9px;"></i> Activities</div>
            <h2>Welfare Activities</h2>
        </div>
        <div class="bwf-activity-grid">
            <?php foreach ($activities as $a): $img = $a['image'] ?? ''; ?>
            <div class="bwf-activity-card<?php echo $img ? ' bwf-has-img' : ''; ?>">
                <?php if ($img): ?><img class="bwf-activity-img" src="<?php echo htmlspecialchars($img); ?>" alt="<?php echo htmlspecialchars($a['title']); ?>" loading="lazy"><div class="bwf-activity-inner"><?php else: ?>
                <div class="bwf-activity-icon"><i class="fas <?php echo htmlspecialchars($a['icon'] ?: 'fa-hand-holding-heart'); ?>"></i></div>
                <?php endif; ?>
                <h4><?php echo htmlspecialchars($a['title']); ?></h4>
                <?php if (!empty($a['activity_date'])): ?>
                <div class="bwf-activity-date"><i class="fas fa-calendar-days"></i> <?php echo date('d M Y', strtotime($a['activity_date'])); ?></div>
                <?php endif; ?>
                <?php if (!empty($a['description'])): ?>
                <p><?php echo htmlspecialchars($a['description']); ?></p>
                <?php endif; ?>
                <?php if ($img): ?></div><?php endif; ?>
            </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>
<?php endif; ?>

<?php if ($fdn_projects): $alt = !$alt; ?>
<!-- PROJECTS (shared with Our Projects) -->
<section class="bwf-section <?php echo $alt ? 'bwf-alt' : ''; ?>" id="projects">
    <div class="container">
        <div class="bwf-sh">
            <div class="bwf-sh-badge"><i class="fas fa-diagram-project" style="font-size:9px;"></i> Projects</div>
            <h2>Foundation Projects</h2>
        </div>
        <div class="bwf-proj-grid">
            <?php foreach ($fdn_projects as $pj):
                $st = $status_labels[$pj['status']] ?? $status_labels['ongoing'];
                $link = trim((string) $pj['details']) !== '' ? 'project.php?id=' . (int) $pj['id'] : '';
            ?>
            <div class="bwf-proj">
                <div class="bwf-proj-img"><?php if (!empty($pj['image'])): ?><img src="<?php echo htmlspecialchars($pj['image']); ?>" alt="<?php echo htmlspecialchars($pj['title']); ?>" loading="lazy"><?php else: ?><i class="fas fa-diagram-project"></i><?php endif; ?></div>
                <div class="bwf-proj-body">
                    <div class="bwf-proj-meta">
                        <span class="bwf-proj-status" style="background:<?php echo $st[1]; ?>1f;color:<?php echo $st[1]; ?>;"><?php echo $st[0]; ?></span>
                        <?php if (!empty($pj['project_date'])): ?><span><i class="fas fa-calendar-days"></i> <?php echo date('d M Y', strtotime($pj['project_date'])); ?></span><?php endif; ?>
                    </div>
                    <h4><?php if ($link): ?><a href="<?php echo $link; ?>"><?php endif; ?><?php echo htmlspecialchars($pj['title']); ?><?php if ($link): ?></a><?php endif; ?></h4>
                    <?php if (!empty($pj['description'])): ?><p><?php echo htmlspecialchars($pj['description']); ?></p><?php endif; ?>
                    <?php if ($link): ?><a class="bwf-proj-link" href="<?php echo $link; ?>">View Details <i class="fas fa-arrow-right"></i></a><?php endif; ?>
                </div>
            </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>
<?php endif; ?>

<?php if ($fdn_gallery): $alt = !$alt; ?>
<!-- GALLERY (from the Gallery module) -->
<section class="bwf-section <?php echo $alt ? 'bwf-alt' : ''; ?>" id="gallery">
    <div class="container">
        <div class="bwf-sh">
            <div class="bwf-sh-badge"><i class="fas fa-images" style="font-size:9px;"></i> Gallery</div>
            <h2>Photo Gallery</h2>
        </div>
        <div class="bwf-gallery">
            <?php foreach ($fdn_gallery as $g): ?>
            <a href="<?php echo htmlspecialchars($g['image_path']); ?>" target="_blank" rel="noopener" title="<?php echo htmlspecialchars($g['title'] ?? ''); ?>">
                <img src="<?php echo htmlspecialchars($g['image_path']); ?>" alt="<?php echo htmlspecialchars($g['title'] ?: $foundation_name); ?>" loading="lazy">
            </a>
            <?php endforeach; ?>
        </div>
        <div style="text-align:center;margin-top:20px;"><a href="gallery.php" style="font-size:13px;font-weight:700;color:var(--primary-color);text-decoration:none;">View full gallery <i class="fas fa-arrow-right"></i></a></div>
    </div>
</section>
<?php endif; ?>

<?php if ($fdn_contact): $alt = !$alt; ?>
<!-- CONTACT -->
<section class="bwf-section <?php echo $alt ? 'bwf-alt' : ''; ?>" id="contact">
    <div class="container">
        <div class="bwf-sh">
            <div class="bwf-sh-badge"><i class="fas fa-address-book" style="font-size:9px;"></i> Contact</div>
            <h2>Contact the Foundation</h2>
        </div>
        <div class="bwf-contact">
            <?php foreach ($fdn_contact as $ck => $c): ?>
            <div class="bwf-contact-item">
                <i class="fas <?php echo $c['icon']; ?>"></i>
                <div>
                    <small><?php echo $c['label']; ?></small>
                    <?php if ($ck === 'phone'): ?><a href="tel:<?php echo htmlspecialchars(preg_replace('/[^0-9+]/', '', $c['value'])); ?>"><?php echo htmlspecialchars($c['value']); ?></a>
                    <?php elseif ($ck === 'email'): ?><a href="mailto:<?php echo htmlspecialchars($c['value']); ?>"><?php echo htmlspecialchars($c['value']); ?></a>
                    <?php elseif ($ck === 'website'): ?><a href="<?php echo htmlspecialchars($c['value']); ?>" target="_blank" rel="noopener"><?php echo htmlspecialchars(preg_replace('#^https?://#i', '', $c['value'])); ?></a>
                    <?php else: ?><span><?php echo nl2br(htmlspecialchars($c['value'])); ?></span><?php endif; ?>
                </div>
            </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>
<?php endif; ?>

<?php endif; ?>

<?php include 'includes/footer.php'; ?>
