<?php
require_once 'includes/config.php';
$page_title = 'Bahawal Welfare Foundation';
$page_description = 'Learn about the Bahawal Welfare Foundation and its community and charitable initiatives alongside Bahawal College of Health Sciences.';

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
                <i class="fas fa-heart"></i> Affiliated Organization
            </div>
        </div>
        <h1><?php echo htmlspecialchars($foundation_name); ?></h1>
        <p><?php echo $foundation_tagline !== '' ? htmlspecialchars($foundation_tagline) : 'Verified information about this Foundation — its purpose, objectives, activities, and relationship with ' . htmlspecialchars(getSiteName()) . ' — is presented below as it becomes available.'; ?></p>
        <?php if ($foundation_established !== ''): ?>
        <div class="bwf-hero-meta"><i class="fas fa-calendar" style="margin-right:6px;"></i>Established <?php echo htmlspecialchars($foundation_established); ?></div>
        <?php endif; ?>
    </div>
</section>

<!-- PURPOSE -->
<section class="bwf-section">
    <div class="container">
        <div class="bwf-sh">
            <div class="bwf-sh-badge"><i class="fas fa-bullseye" style="font-size:9px;"></i> Purpose</div>
            <h2>Our Purpose</h2>
        </div>
        <?php if ($foundation_purpose !== ''): ?>
        <div class="bwf-card"><?php echo nl2br(htmlspecialchars($foundation_purpose)); ?></div>
        <?php else: ?>
        <div class="bwf-placeholder">
            <i class="fas fa-bullseye"></i>
            <p>The Foundation's verified purpose statement has not been published yet. This section will be updated once confirmed information is available — nothing is presented here as fact until then.</p>
        </div>
        <?php endif; ?>
    </div>
</section>

<!-- OBJECTIVES -->
<section class="bwf-section bwf-alt">
    <div class="container">
        <div class="bwf-sh">
            <div class="bwf-sh-badge"><i class="fas fa-list-check" style="font-size:9px;"></i> Objectives</div>
            <h2>Our Objectives</h2>
        </div>
        <?php if (!empty($objectives)): ?>
        <div class="bwf-obj-grid">
            <?php foreach ($objectives as $obj): ?>
            <div class="bwf-obj-item"><i class="fas fa-circle-check"></i> <?php echo htmlspecialchars($obj); ?></div>
            <?php endforeach; ?>
        </div>
        <?php else: ?>
        <div class="bwf-placeholder">
            <i class="fas fa-list-check"></i>
            <p>The Foundation's verified objectives have not been published yet. This section will list them here once confirmed.</p>
        </div>
        <?php endif; ?>
    </div>
</section>

<!-- RELATIONSHIP WITH BCHS -->
<section class="bwf-section">
    <div class="container">
        <div class="bwf-sh">
            <div class="bwf-sh-badge"><i class="fas fa-link" style="font-size:9px;"></i> Relationship</div>
            <h2>Relationship with <?php echo htmlspecialchars(getSiteName()); ?></h2>
        </div>
        <?php if ($foundation_relationship !== ''): ?>
        <div class="bwf-card"><?php echo nl2br(htmlspecialchars($foundation_relationship)); ?></div>
        <?php else: ?>
        <div class="bwf-placeholder">
            <i class="fas fa-link"></i>
            <p>The verified relationship between <?php echo htmlspecialchars($foundation_name); ?> and <?php echo htmlspecialchars(getSiteName()); ?> has not been published yet. This section will be updated once confirmed.</p>
        </div>
        <?php endif; ?>
    </div>
</section>

<!-- ACTIVITIES -->
<section class="bwf-section bwf-alt">
    <div class="container">
        <div class="bwf-sh">
            <div class="bwf-sh-badge"><i class="fas fa-hand-holding-heart" style="font-size:9px;"></i> Activities</div>
            <h2>Foundation Activities</h2>
        </div>
        <?php if ($has_activities): ?>
        <div class="bwf-activity-grid">
            <?php foreach ($activities as $a): ?>
            <div class="bwf-activity-card">
                <div class="bwf-activity-icon"><i class="fas <?php echo htmlspecialchars($a['icon'] ?: 'fa-hand-holding-heart'); ?>"></i></div>
                <h4><?php echo htmlspecialchars($a['title']); ?></h4>
                <?php if (!empty($a['activity_date'])): ?>
                <div class="bwf-activity-date"><i class="fas fa-calendar-days"></i> <?php echo date('d M Y', strtotime($a['activity_date'])); ?></div>
                <?php endif; ?>
                <?php if (!empty($a['description'])): ?>
                <p><?php echo htmlspecialchars($a['description']); ?></p>
                <?php endif; ?>
            </div>
            <?php endforeach; ?>
        </div>
        <?php else: ?>
        <div class="bwf-placeholder">
            <i class="fas fa-hand-holding-heart"></i>
            <p>No verified Foundation activities have been published yet. Real activities will be listed here as they're confirmed.</p>
        </div>
        <?php endif; ?>
    </div>
</section>

<?php include 'includes/footer.php'; ?>
