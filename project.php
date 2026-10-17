<?php
require_once 'includes/config.php';

$project_id = isset($_GET['id']) ? intval($_GET['id']) : 0;
$project = null;
if ($project_id > 0) {
    $res = mysqli_query($conn, "SELECT * FROM projects WHERE id = $project_id AND visibility='active' LIMIT 1");
    $project = $res ? mysqli_fetch_assoc($res) : null;
}

$status_meta = [
    'ongoing'   => ['label' => 'Ongoing',   'icon' => 'fa-spinner',       'color' => '#09A9D9', 'bg' => 'rgba(9,169,217,0.12)'],
    'upcoming'  => ['label' => 'Upcoming',  'icon' => 'fa-calendar-plus', 'color' => '#F59E0B', 'bg' => 'rgba(245,158,11,0.14)'],
    'completed' => ['label' => 'Completed', 'icon' => 'fa-circle-check',  'color' => '#16A34A', 'bg' => 'rgba(22,163,74,0.12)'],
];

if (!$project) {
    http_response_code(404);
    $page_title = 'Project Not Found';
} else {
    $page_title = $project['title'];
    $page_description = mb_substr(trim(preg_replace('/\s+/', ' ', $project['description'] ?: $project['details'] ?: $project['title'])), 0, 155);
    $page_canonical = 'project.php?id=' . (int) $project['id'];
    if (!empty($project['image'])) $page_image = $project['image'];

    // Related: same category first, then other recent projects
    $related = [];
    $cat = mysqli_real_escape_string($conn, (string) $project['category']);
    $rr = mysqli_query($conn, "SELECT id, title, image, status, project_date, category FROM projects
                               WHERE visibility='active' AND id <> " . (int) $project['id'] . "
                               ORDER BY (category = '$cat' AND category <> '') DESC, display_order ASC, project_date DESC, id DESC LIMIT 3");
    if ($rr) { while ($row = mysqli_fetch_assoc($rr)) { $related[] = $row; } }
}
?>
<?php include 'includes/header.php'; ?>

<style>
/* ===== PROJECT DETAIL PAGE ===== */
.pjd-hero {
    background:linear-gradient(135deg,#0D1048 0%,#17165B 55%,#0D1048 100%);
    padding:54px 0 46px; position:relative; overflow:hidden;
}
.pjd-breadcrumb { display:flex; align-items:center; gap:8px; flex-wrap:wrap; font-size:12px; color:rgba(255,255,255,0.5); margin-bottom:16px; }
.pjd-breadcrumb a { color:rgba(255,255,255,0.65); text-decoration:none; }
.pjd-breadcrumb a:hover { color:var(--accent-color); }
.pjd-hero h1 { color:#fff; font-size:34px; font-weight:800; margin:0 0 14px; line-height:1.2; max-width:860px; }
.pjd-meta { display:flex; flex-wrap:wrap; gap:10px; }
.pjd-pill {
    display:inline-flex; align-items:center; gap:6px; padding:5px 13px; border-radius:50px;
    font-size:12px; font-weight:700; background:rgba(255,255,255,0.08); border:1px solid rgba(255,255,255,0.15); color:rgba(255,255,255,0.88);
}
.pjd-pill i { font-size:11px; }

.pjd-section { padding:44px 0 60px; background:#F5F9FC; }
.pjd-layout { display:grid; grid-template-columns:minmax(0,1fr) 320px; gap:26px; align-items:start; }
.pjd-card { background:#fff; border-radius:18px; border:1px solid rgba(23,22,91,0.1); overflow:hidden; margin-bottom:22px; }
.pjd-image { width:100%; max-height:460px; object-fit:cover; display:block; background:#e9eef5; }
.pjd-body { padding:26px 28px 30px; }
.pjd-lead { font-size:15.5px; color:var(--text-dark); line-height:1.75; margin:0 0 18px; font-weight:500; }
.pjd-body h2 { font-size:17px; font-weight:800; color:var(--text-dark); margin:22px 0 10px; display:flex; align-items:center; gap:9px; }
.pjd-body h2 i { color:var(--primary-color); font-size:15px; }
.pjd-text p { font-size:14px; color:var(--text-light); line-height:1.85; margin:0 0 12px; }

.pjd-side .pjd-card { padding:20px; }
.pjd-side h3 { font-size:14px; font-weight:800; color:var(--primary-color); margin:0 0 12px; display:flex; align-items:center; gap:8px; }
.pjd-facts div { display:flex; justify-content:space-between; gap:12px; padding:8px 0; border-bottom:1px solid rgba(23,22,91,0.07); font-size:13px; }
.pjd-facts div:last-child { border-bottom:none; }
.pjd-facts span:first-child { color:var(--text-light); }
.pjd-facts span:last-child { color:var(--text-dark); font-weight:700; text-align:right; }
.pjd-status { display:inline-flex; align-items:center; gap:5px; padding:2px 10px; border-radius:50px; font-size:11.5px; font-weight:700; }
.pjd-rel a { display:flex; gap:11px; align-items:center; padding:9px 0; border-bottom:1px solid rgba(23,22,91,0.07); text-decoration:none; }
.pjd-rel a:last-child { border-bottom:none; }
.pjd-rel-thumb { width:54px; height:44px; border-radius:8px; flex-shrink:0; background:linear-gradient(135deg,var(--primary-color),#0D1048); display:flex; align-items:center; justify-content:center; color:rgba(255,255,255,0.6); overflow:hidden; }
.pjd-rel-thumb img { width:100%; height:100%; object-fit:cover; }
.pjd-rel strong { display:block; font-size:13px; color:var(--text-dark); line-height:1.35; }
.pjd-rel small { font-size:11px; color:var(--text-light); }
.pjd-rel a:hover strong { color:var(--primary-color); }
.pjd-back { display:inline-flex; align-items:center; gap:7px; font-size:13px; font-weight:700; color:var(--primary-color); text-decoration:none; }

.pjd-notfound { padding:80px 0; text-align:center; background:#F5F9FC; }
.pjd-notfound h1 { font-size:26px; color:var(--text-dark); margin:14px 0 8px; }
.pjd-notfound p { color:var(--text-light); margin:0 0 18px; }

@media (max-width:960px) { .pjd-layout { grid-template-columns:1fr; } }
@media (max-width:600px) {
    .pjd-hero h1 { font-size:24px; }
    .pjd-body { padding:20px 16px 24px; }
}
</style>

<?php if (!$project): ?>
<section class="pjd-notfound">
    <div class="container">
        <i class="fas fa-diagram-project" style="font-size:40px;color:var(--primary-color);"></i>
        <h1>Project not found</h1>
        <p>This project isn't available or is no longer listed.</p>
        <a href="our-projects.php" class="pjd-back"><i class="fas fa-arrow-left"></i> Back to all projects</a>
    </div>
</section>
<?php else:
    $sm = $status_meta[$project['status']] ?? $status_meta['ongoing'];
    $paras = array_filter(array_map('trim', preg_split('/\R{2,}/', (string) $project['details'])));
?>
<section class="pjd-hero">
    <div class="container" style="position:relative;z-index:2;">
        <div class="pjd-breadcrumb">
            <a href="index.php"><i class="fas fa-home"></i> Home</a>
            <i class="fas fa-chevron-right" style="font-size:9px;"></i>
            <a href="our-projects.php">Our Projects</a>
            <i class="fas fa-chevron-right" style="font-size:9px;"></i>
            <span><?php echo htmlspecialchars($project['title']); ?></span>
        </div>
        <h1><?php echo htmlspecialchars($project['title']); ?></h1>
        <div class="pjd-meta">
            <span class="pjd-pill" style="background:<?php echo $sm['bg']; ?>;border-color:<?php echo $sm['color']; ?>66;color:#fff;"><i class="fas <?php echo $sm['icon']; ?>" style="color:<?php echo $sm['color']; ?>;"></i> <?php echo $sm['label']; ?></span>
            <?php if (!empty($project['category'])): ?><span class="pjd-pill"><i class="fas fa-tag"></i> <?php echo htmlspecialchars($project['category']); ?></span><?php endif; ?>
            <?php if (!empty($project['project_date'])): ?><span class="pjd-pill"><i class="fas fa-calendar-days"></i> <?php echo date('d M Y', strtotime($project['project_date'])); ?></span><?php endif; ?>
        </div>
    </div>
</section>

<section class="pjd-section">
    <div class="container">
        <div class="pjd-layout">
            <article class="pjd-card">
                <?php if (!empty($project['image'])): ?>
                <img class="pjd-image" src="<?php echo htmlspecialchars($project['image']); ?>" alt="<?php echo htmlspecialchars($project['title']); ?>">
                <?php endif; ?>
                <div class="pjd-body">
                    <?php if (!empty($project['description'])): ?>
                    <p class="pjd-lead"><?php echo nl2br(htmlspecialchars($project['description'])); ?></p>
                    <?php endif; ?>
                    <?php if ($paras): ?>
                    <h2><i class="fas fa-file-lines"></i> Project Details</h2>
                    <div class="pjd-text">
                        <?php foreach ($paras as $para): ?><p><?php echo nl2br(htmlspecialchars($para)); ?></p><?php endforeach; ?>
                    </div>
                    <?php endif; ?>
                    <a href="our-projects.php" class="pjd-back" style="margin-top:14px;"><i class="fas fa-arrow-left"></i> All projects</a>
                </div>
            </article>

            <aside class="pjd-side">
                <div class="pjd-card">
                    <h3><i class="fas fa-circle-info"></i> Project Information</h3>
                    <div class="pjd-facts">
                        <div><span>Status</span><span><span class="pjd-status" style="background:<?php echo $sm['bg']; ?>;color:<?php echo $sm['color']; ?>;"><i class="fas <?php echo $sm['icon']; ?>"></i> <?php echo $sm['label']; ?></span></span></div>
                        <?php if (!empty($project['category'])): ?><div><span>Category</span><span><?php echo htmlspecialchars($project['category']); ?></span></div><?php endif; ?>
                        <?php if (!empty($project['is_foundation'])): ?><div><span>Run by</span><span><a href="foundation.php" style="color:var(--primary-color);"><?php echo htmlspecialchars(getSetting('foundation_name', 'Bahawal Welfare Foundation')); ?></a></span></div><?php endif; ?>
                        <?php if (!empty($project['project_date'])): ?><div><span><?php echo $project['status'] === 'upcoming' ? 'Planned Date' : 'Date'; ?></span><span><?php echo date('d M Y', strtotime($project['project_date'])); ?></span></div><?php endif; ?>
                    </div>
                </div>
                <?php if ($related): ?>
                <div class="pjd-card pjd-rel">
                    <h3><i class="fas fa-layer-group"></i> More Projects</h3>
                    <?php foreach ($related as $r): $rs = $status_meta[$r['status']] ?? $status_meta['ongoing']; ?>
                    <a href="project.php?id=<?php echo (int) $r['id']; ?>">
                        <div class="pjd-rel-thumb"><?php if (!empty($r['image'])): ?><img src="<?php echo htmlspecialchars($r['image']); ?>" alt="" loading="lazy"><?php else: ?><i class="fas fa-diagram-project"></i><?php endif; ?></div>
                        <div><strong><?php echo htmlspecialchars($r['title']); ?></strong><small><?php echo $rs['label']; ?><?php echo !empty($r['category']) ? ' · ' . htmlspecialchars($r['category']) : ''; ?></small></div>
                    </a>
                    <?php endforeach; ?>
                </div>
                <?php endif; ?>
            </aside>
        </div>
    </div>
</section>
<?php endif; ?>

<?php include 'includes/footer.php'; ?>
