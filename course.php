<?php
require_once 'includes/config.php';
require_once 'includes/course_helper.php';

$course_id = isset($_GET['id']) ? intval($_GET['id']) : 0;
$course = null;
if ($course_id > 0) {
    $res = mysqli_query($conn, "SELECT * FROM courses WHERE id = $course_id AND status='active' LIMIT 1");
    $course = $res ? mysqli_fetch_assoc($res) : null;
}

if (!$course) {
    http_response_code(404);
    $page_title = 'Program Not Found';
} else {
    $page_title = $course['name'];
    $page_description = mb_substr(trim(preg_replace('/\s+/', ' ', $course['description'] ?? '')), 0, 155);
    $page_canonical = 'course.php?id=' . (int)$course['id'];

    // Other active programs for the sidebar
    $others = [];
    $or = mysqli_query($conn, "SELECT id, name, icon, duration FROM courses WHERE status='active' AND id <> " . (int)$course['id'] . " ORDER BY display_order ASC, name ASC LIMIT 5");
    if ($or) { while ($row = mysqli_fetch_assoc($or)) { $others[] = $row; } }
}

$cat_labels = ['regular' => 'Regular Program', 'test' => 'Test Preparation', 'short' => 'Short Course / Certificate'];
$adm_steps = getAdmissionSteps();
$adm_docs  = getAdmissionDocuments();
?>
<?php include 'includes/header.php'; ?>

<style>
/* ── Course Detail Page ── */
.cd-hero {
    position:relative; overflow:hidden;
    background:linear-gradient(130deg,rgba(13,16,72,0.9),rgba(23,22,91,0.92)),
               url('https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=1600') center/cover no-repeat;
    padding:56px 0 52px;
}
.cd-breadcrumb { display:flex; align-items:center; gap:8px; flex-wrap:wrap; font-size:12px; color:rgba(255,255,255,0.5); margin-bottom:18px; }
.cd-breadcrumb a { color:rgba(255,255,255,0.65); text-decoration:none; }
.cd-breadcrumb a:hover { color:var(--accent-color); }
.cd-hero-inner { display:flex; align-items:center; gap:22px; }
.cd-hero-icon {
    width:70px; height:70px; border-radius:18px; flex-shrink:0;
    background:rgba(9,169,217,0.15); border:1px solid rgba(9,169,217,0.35);
    display:flex; align-items:center; justify-content:center;
    color:var(--accent-color); font-size:30px;
}
.cd-cat {
    display:inline-flex; align-items:center; gap:6px;
    background:rgba(9,169,217,0.12); border:1px solid rgba(9,169,217,0.35);
    color:var(--accent-color); padding:4px 14px; border-radius:50px;
    font-size:10.5px; font-weight:700; letter-spacing:1.5px; text-transform:uppercase; margin-bottom:10px;
}
.cd-hero h1 { color:#fff; font-size:34px; font-weight:800; margin:0; line-height:1.2; }
.cd-hero-pills { display:flex; flex-wrap:wrap; gap:10px; margin-top:14px; }
.cd-hero-pill {
    display:inline-flex; align-items:center; gap:6px;
    background:rgba(255,255,255,0.08); border:1px solid rgba(255,255,255,0.15);
    color:rgba(255,255,255,0.85); padding:5px 13px; border-radius:50px; font-size:12px; font-weight:600;
}
.cd-hero-pill i { color:var(--accent-color); font-size:11px; }

.cd-section { padding:46px 0 60px; background:#F5F9FC; }
.cd-layout { display:grid; grid-template-columns:minmax(0,1fr) 360px; gap:26px; align-items:start; }
.cd-card {
    background:#fff; border-radius:18px; border:1px solid rgba(23,22,91,0.1);
    padding:24px 26px; margin-bottom:22px;
}
.cd-card h2 {
    font-size:18px; font-weight:800; color:var(--text-dark);
    margin:0 0 14px; display:flex; align-items:center; gap:10px;
}
.cd-card h2 i { color:var(--primary-color); font-size:16px; }
.cd-desc { font-size:14px; line-height:1.8; color:var(--text-light); }
.cd-desc p { margin:0 0 12px; }

.cd-facts { display:grid; grid-template-columns:repeat(2,minmax(0,1fr)); gap:14px; }
.cd-fact {
    display:flex; gap:12px; align-items:flex-start;
    background:#F5F9FC; border:1px solid rgba(23,22,91,0.08); border-radius:12px; padding:13px 14px;
}
.cd-fact-icon {
    width:36px; height:36px; border-radius:10px; flex-shrink:0;
    background:rgba(23,22,91,0.08); color:var(--primary-color);
    display:flex; align-items:center; justify-content:center; font-size:14px;
}
.cd-fact-label { font-size:10.5px; font-weight:700; letter-spacing:1px; text-transform:uppercase; color:var(--text-light); margin-bottom:3px; }
.cd-fact-value { font-size:13.5px; font-weight:600; color:var(--text-dark); line-height:1.45; overflow-wrap:anywhere; }
.cd-fact-value.cd-muted { color:var(--text-light); font-weight:500; font-style:italic; }

.cd-steps { display:grid; grid-template-columns:repeat(2,minmax(0,1fr)); gap:12px; margin-bottom:18px; }
.cd-step { display:flex; gap:12px; align-items:flex-start; }
.cd-step-num {
    width:30px; height:30px; border-radius:50%; flex-shrink:0;
    background:var(--primary-color); color:#fff; font-size:13px; font-weight:800;
    display:flex; align-items:center; justify-content:center;
}
.cd-step strong { display:block; font-size:13.5px; color:var(--text-dark); }
.cd-step span { font-size:12.5px; color:var(--text-light); line-height:1.5; }
.cd-sub { font-size:13px; font-weight:700; color:var(--text-dark); margin:4px 0 8px; }
.cd-docs { list-style:none; margin:0; padding:0; display:grid; grid-template-columns:repeat(2,minmax(0,1fr)); gap:6px 16px; }
.cd-docs li { font-size:13px; color:var(--text-dark); display:flex; gap:8px; align-items:flex-start; line-height:1.5; }
.cd-docs li i { color:var(--primary-color); font-size:11px; margin-top:4px; }
.cd-adm-note {
    background:#EAF7FB; border-left:4px solid var(--accent-color); border-radius:8px;
    padding:12px 14px; font-size:13px; color:var(--text-dark); line-height:1.7; margin-bottom:18px;
}

.cd-side { position:sticky; top:90px; }
.cd-side .cd-card { padding:20px; }
.cd-side .cr-fee-box { background:#fff; border:none; padding:0; }
.cd-side .cr-fee-row { font-size:13px; padding:6px 0; }
.cd-side .cr-fee-row.cr-fee-total { font-size:14.5px; }
.cd-btn {
    display:flex; align-items:center; justify-content:center; gap:8px;
    padding:12px 18px; border-radius:10px; font-size:14px; font-weight:700;
    text-decoration:none; transition:all 0.3s ease; margin-top:10px;
}
.cd-btn-primary { background:var(--primary-color); color:#fff; }
.cd-btn-primary:hover { background:#0D1048; color:#fff; transform:translateY(-2px); }
.cd-btn-outline { border:1px solid rgba(23,22,91,0.25); color:var(--primary-color); background:#fff; }
.cd-btn-outline:hover { background:rgba(23,22,91,0.05); color:var(--primary-color); }
.cd-others a {
    display:flex; align-items:center; gap:10px; padding:9px 0;
    border-bottom:1px solid rgba(23,22,91,0.07); text-decoration:none;
    font-size:13px; font-weight:600; color:var(--text-dark);
}
.cd-others a:last-child { border-bottom:none; }
.cd-others a:hover { color:var(--primary-color); }
.cd-others a i { color:var(--primary-color); width:18px; text-align:center; }

.cd-notfound { padding:80px 0; text-align:center; background:#F5F9FC; }
.cd-notfound h1 { font-size:28px; color:var(--text-dark); margin:14px 0 8px; }
.cd-notfound p { color:var(--text-light); margin:0 0 20px; }

<?php echo renderCourseFeeStyles(); ?>

@media (max-width:980px) {
    .cd-layout { grid-template-columns:1fr; }
    .cd-side { position:static; }
}
@media (max-width:600px) {
    .cd-hero h1 { font-size:24px; }
    .cd-hero-inner { flex-direction:column; align-items:flex-start; gap:14px; }
    .cd-facts, .cd-steps, .cd-docs { grid-template-columns:1fr; }
    .cd-card { padding:20px 16px; }
}
</style>

<?php if (!$course): ?>
<section class="cd-notfound">
    <div class="container">
        <i class="fas fa-book-open" style="font-size:40px;color:var(--primary-color);"></i>
        <h1>Program not found</h1>
        <p>This program is not available or is no longer offered.</p>
        <a href="courses.php" class="cd-btn cd-btn-primary" style="display:inline-flex;"><i class="fas fa-arrow-left"></i> Browse All Programs</a>
    </div>
</section>
<?php else:
    $icon = $course['icon'] ?: 'fa-book';
    $cat_label = $cat_labels[$course['category'] ?? ''] ?? 'Program';
    $period = getCourseFeePeriodLabels($course);
    $admission_info = trim($course['admission_info'] ?? '');
    $facts = [
        ['icon' => 'fa-graduation-cap',   'label' => 'Program',     'value' => $course['name']],
        ['icon' => 'fa-building-columns', 'label' => 'Department',  'value' => $course['department'] ?? ''],
        ['icon' => 'fa-certificate',      'label' => 'Affiliation', 'value' => $course['affiliation'] ?? ''],
        ['icon' => 'fa-clock',            'label' => 'Duration',    'value' => $course['duration'] ?? ''],
        ['icon' => 'fa-clipboard-check',  'label' => 'Eligibility', 'value' => $course['eligibility'] ?? ''],
        ['icon' => 'fa-calendar-alt',     'label' => 'Fee Payment', 'value' => $course['semester_fee'] !== null ? ucfirst($period['per']) : ''],
    ];
?>
<!-- ── Hero ── -->
<section class="cd-hero">
    <div class="container">
        <div class="cd-breadcrumb">
            <a href="index.php"><i class="fas fa-home"></i> Home</a>
            <i class="fas fa-chevron-right" style="font-size:9px;"></i>
            <a href="courses.php">Courses &amp; Programs</a>
            <i class="fas fa-chevron-right" style="font-size:9px;"></i>
            <span><?php echo htmlspecialchars($course['name']); ?></span>
        </div>
        <div class="cd-hero-inner">
            <div class="cd-hero-icon"><i class="fas <?php echo htmlspecialchars($icon); ?>"></i></div>
            <div>
                <div class="cd-cat"><?php echo htmlspecialchars($cat_label); ?></div>
                <h1><?php echo htmlspecialchars($course['name']); ?></h1>
                <div class="cd-hero-pills">
                    <?php if (!empty($course['duration'])): ?><span class="cd-hero-pill"><i class="fas fa-clock"></i> <?php echo htmlspecialchars($course['duration']); ?></span><?php endif; ?>
                    <?php if (!empty($course['department'])): ?><span class="cd-hero-pill"><i class="fas fa-building-columns"></i> <?php echo htmlspecialchars($course['department']); ?></span><?php endif; ?>
                    <?php if (!empty($course['affiliation'])): ?><span class="cd-hero-pill"><i class="fas fa-certificate"></i> <?php echo htmlspecialchars($course['affiliation']); ?></span><?php endif; ?>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="cd-section">
    <div class="container">
        <div class="cd-layout">
            <div>
                <!-- Overview -->
                <?php if (!empty($course['description'])): ?>
                <div class="cd-card">
                    <h2><i class="fas fa-book-open"></i> Program Overview</h2>
                    <div class="cd-desc">
                        <?php foreach (array_filter(array_map('trim', preg_split('/\R{2,}/', $course['description']))) as $para): ?>
                        <p><?php echo nl2br(htmlspecialchars($para)); ?></p>
                        <?php endforeach; ?>
                    </div>
                </div>
                <?php endif; ?>

                <!-- Key facts -->
                <div class="cd-card">
                    <h2><i class="fas fa-list-check"></i> Program at a Glance</h2>
                    <div class="cd-facts">
                        <?php foreach ($facts as $f): $has = trim((string)$f['value']) !== ''; ?>
                        <div class="cd-fact">
                            <div class="cd-fact-icon"><i class="fas <?php echo $f['icon']; ?>"></i></div>
                            <div>
                                <div class="cd-fact-label"><?php echo $f['label']; ?></div>
                                <div class="cd-fact-value<?php echo $has ? '' : ' cd-muted'; ?>">
                                    <?php echo $has ? htmlspecialchars($f['value']) : 'Contact admission office'; ?>
                                </div>
                            </div>
                        </div>
                        <?php endforeach; ?>
                    </div>
                </div>

                <!-- Fee structure (full) -->
                <div class="cd-card">
                    <h2><i class="fas fa-money-check-dollar"></i> Fee Structure</h2>
                    <?php echo renderCourseFeeBox($course, false); ?>
                    <?php if (courseHasFeeData($course)): ?>
                    <p style="font-size:12px;color:var(--text-light);margin:12px 0 0;line-height:1.6;">
                        <i class="fas fa-circle-info" style="color:var(--primary-color);"></i>
                        <strong>Admission Fee</strong> is a one-time charge.
                        <?php if ($course['initial_fee'] !== null): ?>The <strong>Initial Fee</strong> is the first payment and covers the 1st <?php echo $period['unit']; ?>.<?php endif; ?>
                        <?php if ($course['semester_fee'] !== null): ?>The <strong><?php echo $period['label']; ?></strong> is charged <?php echo $period['per']; ?><?php echo $course['initial_fee'] !== null ? ' from the 2nd ' . $period['unit'] . ' onward' : ''; ?>.<?php endif; ?>
                        <?php if ($course['total_fee'] !== null): ?><strong>Total Program Fee</strong> is the tuition for the complete program as set by the college.<?php endif; ?>
                        Fees are subject to revision by the college administration.
                    </p>
                    <?php endif; ?>
                </div>

                <!-- Admission information -->
                <div class="cd-card">
                    <h2><i class="fas fa-user-graduate"></i> Admission Information</h2>
                    <?php if ($admission_info !== ''): ?>
                    <div class="cd-adm-note"><?php echo nl2br(htmlspecialchars($admission_info)); ?></div>
                    <?php endif; ?>
                    <?php if (!empty($course['eligibility'])): ?>
                    <div class="cd-adm-note"><strong>Eligibility:</strong> <?php echo htmlspecialchars($course['eligibility']); ?></div>
                    <?php endif; ?>

                    <div class="cd-sub">How to apply</div>
                    <div class="cd-steps">
                        <?php foreach ($adm_steps as $i => $st): ?>
                        <div class="cd-step">
                            <div class="cd-step-num"><?php echo $i + 1; ?></div>
                            <div><strong><?php echo htmlspecialchars($st['title']); ?></strong><span><?php echo htmlspecialchars($st['desc']); ?></span></div>
                        </div>
                        <?php endforeach; ?>
                    </div>

                    <?php if (!empty($adm_docs)): ?>
                    <div class="cd-sub">Documents required</div>
                    <ul class="cd-docs">
                        <?php foreach ($adm_docs as $doc): ?>
                        <li><i class="fas fa-check-circle"></i> <?php echo htmlspecialchars($doc); ?></li>
                        <?php endforeach; ?>
                    </ul>
                    <?php endif; ?>
                </div>
            </div>

            <!-- Sidebar -->
            <aside class="cd-side">
                <div class="cd-card">
                    <?php echo renderCourseFeeBox($course); ?>
                    <a href="admission.php?course=<?php echo (int)$course['id']; ?>" class="cd-btn cd-btn-primary"><i class="fas fa-graduation-cap"></i> Apply for this Program</a>
                    <?php if (courseHasFeeData($course)): ?>
                    <a href="fee-calculator.php?course=<?php echo (int)$course['id']; ?>" class="cd-btn cd-btn-outline"><i class="fas fa-calculator"></i> Estimate My Fee</a>
                    <?php endif; ?>
                    <a href="eligibility-checker.php?course=<?php echo (int)$course['id']; ?>" class="cd-btn cd-btn-outline"><i class="fas fa-clipboard-check"></i> Check Eligibility</a>
                    <a href="contact.php" class="cd-btn cd-btn-outline"><i class="fas fa-phone"></i> Contact Admission Office</a>
                </div>

                <?php if (!empty($others)): ?>
                <div class="cd-card cd-others">
                    <h2 style="font-size:15px;margin-bottom:6px;"><i class="fas fa-layer-group"></i> Other Programs</h2>
                    <?php foreach ($others as $o): ?>
                    <a href="course.php?id=<?php echo (int)$o['id']; ?>">
                        <i class="fas <?php echo htmlspecialchars($o['icon'] ?: 'fa-book'); ?>"></i>
                        <span><?php echo htmlspecialchars($o['name']); ?></span>
                    </a>
                    <?php endforeach; ?>
                    <a href="courses.php" style="color:var(--primary-color);"><i class="fas fa-arrow-right"></i> View all programs</a>
                </div>
                <?php endif; ?>
            </aside>
        </div>
    </div>
</section>
<?php endif; ?>

<?php include 'includes/footer.php'; ?>
