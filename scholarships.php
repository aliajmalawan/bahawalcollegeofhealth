<?php
require_once 'includes/config.php';
$page_title = 'Scholarships';
$page_description = 'Learn about merit scholarships and fee concessions available to students at Bahawal College of Health Sciences.';

$category_meta = [
    'merit'      => ['label' => 'Merit Scholarships',     'icon' => 'fa-medal',        'color' => '#17165B', 'bg' => 'rgba(23,22,91,0.08)'],
    'need_based' => ['label' => 'Need-Based Scholarships', 'icon' => 'fa-hand-holding-heart', 'color' => '#09A9D9', 'bg' => 'rgba(9,169,217,0.1)'],
    'other'      => ['label' => 'Other Scholarships',      'icon' => 'fa-star',         'color' => '#16A34A', 'bg' => 'rgba(22,163,74,0.1)'],
];

$grouped = ['merit' => [], 'need_based' => [], 'other' => []];
$sr = mysqli_query($conn, "SELECT * FROM scholarships WHERE status='active' ORDER BY display_order ASC, id ASC");
if ($sr) {
    while ($row = mysqli_fetch_assoc($sr)) {
        $cat = isset($grouped[$row['category']]) ? $row['category'] : 'other';
        $grouped[$cat][] = $row;
    }
}
$has_any = count($grouped['merit']) + count($grouped['need_based']) + count($grouped['other']) > 0;

// Merit Scholarship Formula — the same percentage tier applies to every program type
$merit_formula = getMeritScholarshipTiers();
?>
<?php include 'includes/header.php'; ?>

<style>
/* ===== SCHOLARSHIPS PAGE ===== */

.sch-hero {
    background: linear-gradient(135deg,#0D1048 0%,#17165B 55%,#0D1048 100%);
    padding: 62px 0 50px;
    position: relative; overflow: hidden;
}
.sch-hero::after {
    content:'';
    position:absolute; bottom:-1px; left:0; right:0;
    height:40px;
    background:#F5F9FC;
    clip-path:ellipse(55% 100% at 50% 100%);
}
.sch-breadcrumb {
    display:flex; align-items:center; gap:8px;
    font-size:12px; color:rgba(255,255,255,0.5); margin-bottom:18px;
    position:relative; z-index:1;
}
.sch-breadcrumb a { color:rgba(255,255,255,0.6); text-decoration:none; }
.sch-breadcrumb a:hover { color:var(--accent-color); }
.sch-hero-badge {
    display:inline-flex; align-items:center; gap:7px;
    background:rgba(9,169,217,0.14); border:1px solid rgba(9,169,217,0.35);
    color:var(--accent-color); padding:6px 18px; border-radius:50px;
    font-size:10.5px; font-weight:700; letter-spacing:2px;
    text-transform:uppercase; margin-bottom:16px;
    position:relative; z-index:1;
}
.sch-hero h1 {
    font-size:38px; font-weight:800; color:#fff;
    margin:0 0 12px; line-height:1.15;
    position:relative; z-index:1;
}
.sch-hero h1 span { color:var(--accent-color); }
.sch-hero p {
    color:rgba(255,255,255,0.72); font-size:15px; margin:0; max-width:560px; line-height:1.7;
    position:relative; z-index:1;
}

.sch-section { padding:56px 0 20px; background:#F5F9FC; }

/* --- Merit Formula Table --- */
.sch-formula-wrap { padding:0 0 12px; background:#F5F9FC; }
.sch-formula-card {
    background:#fff; border-radius:18px; border:1px solid rgba(23,22,91,0.1);
    padding:30px 32px 34px; margin-bottom:8px;
}
.sch-formula-head { text-align:center; margin-bottom:26px; }
.sch-formula-badge {
    display:inline-flex; align-items:center; gap:7px;
    background:rgba(23,22,91,0.08); border:1px solid rgba(23,22,91,0.22);
    color:var(--primary-color); padding:6px 16px; border-radius:50px;
    font-size:10.5px; font-weight:700; letter-spacing:2px;
    text-transform:uppercase; margin-bottom:12px;
}
.sch-formula-head h2 { font-size:22px; font-weight:800; color:var(--text-dark); margin:0 0 8px; }
.sch-formula-head p { color:var(--text-light); font-size:13.5px; margin:0 auto; max-width:560px; }

.sch-table-scroll { overflow-x:auto; border-radius:14px; border:1px solid rgba(23,22,91,0.1); }
.sch-formula-table { width:100%; border-collapse:collapse; min-width:560px; }
.sch-formula-table thead th {
    background:linear-gradient(135deg,var(--primary-color),#0D1048);
    color:#fff; font-size:12.5px; font-weight:700; letter-spacing:0.3px;
    padding:14px 18px; text-align:center; white-space:nowrap;
}
.sch-formula-table thead th:first-child { text-align:left; }
.sch-formula-table tbody td {
    padding:13px 18px; text-align:center; font-size:13.5px; color:var(--text-dark);
    border-bottom:1px solid rgba(23,22,91,0.07); white-space:nowrap;
}
.sch-formula-table tbody td:first-child { text-align:left; font-weight:700; color:var(--primary-color); }
.sch-formula-table tbody tr:last-child td { border-bottom:none; }
.sch-formula-table tbody tr:hover { background:#F5F9FC; }
.sch-formula-table .sch-pct-cell {
    display:inline-flex; align-items:center; justify-content:center;
    min-width:52px; padding:4px 10px; border-radius:20px;
    background:rgba(9,169,217,0.1); color:#078FB8; font-weight:800; font-size:13px;
}
.sch-formula-note {
    display:flex; align-items:flex-start; gap:9px;
    margin-top:18px; font-size:12px; color:var(--text-light); line-height:1.6;
}
.sch-formula-note i { color:var(--primary-color); margin-top:2px; flex-shrink:0; }

.sch-cat-group { margin-bottom:48px; }
.sch-cat-head {
    display:flex; align-items:center; gap:12px;
    margin-bottom:22px;
}
.sch-cat-icon {
    width:44px; height:44px; border-radius:12px;
    display:flex; align-items:center; justify-content:center;
    font-size:18px; flex-shrink:0;
}
.sch-cat-head h2 { font-size:21px; font-weight:800; color:var(--text-dark); margin:0; }

.sch-grid { display:grid; grid-template-columns:repeat(2,1fr); gap:22px; }
@media (max-width:900px) { .sch-grid { grid-template-columns:1fr; } }

.sch-card {
    background:#fff; border-radius:18px; border:1px solid rgba(23,22,91,0.1);
    overflow:hidden; display:flex; flex-direction:column;
    transition:transform 0.3s ease, box-shadow 0.3s ease;
}
.sch-card:hover { transform:translateY(-5px); box-shadow:0 16px 40px rgba(23,22,91,0.12); }

.sch-card-top {
    padding:20px 22px 16px;
    display:flex; align-items:flex-start; justify-content:space-between; gap:14px;
}
.sch-card-icon {
    width:46px; height:46px; border-radius:13px;
    display:flex; align-items:center; justify-content:center;
    font-size:19px; flex-shrink:0;
}
.sch-card-top h3 { font-size:15.5px; font-weight:800; color:var(--text-dark); margin:0 0 4px; line-height:1.3; }
.sch-pct {
    display:inline-flex; align-items:center;
    background:linear-gradient(135deg,var(--primary-color),#09A9D9);
    color:#fff; padding:4px 12px; border-radius:20px;
    font-size:12px; font-weight:800; white-space:nowrap; flex-shrink:0;
}

.sch-card-body { padding:0 22px 20px; flex:1; display:flex; flex-direction:column; gap:14px; }
.sch-desc { font-size:12.5px; color:var(--text-light); line-height:1.7; margin:0; }

.sch-subhead {
    font-size:11px; font-weight:700; letter-spacing:0.7px; text-transform:uppercase;
    color:var(--primary-color); margin:0 0 8px;
}
.sch-list { display:flex; flex-direction:column; gap:6px; }
.sch-list-item {
    display:flex; align-items:flex-start; gap:8px;
    font-size:12.5px; color:var(--text-dark); line-height:1.5;
}
.sch-list-item i { color:var(--accent-color); font-size:11px; margin-top:3px; flex-shrink:0; }
.sch-steps { display:flex; flex-direction:column; gap:8px; counter-reset:sch-step; }
.sch-step {
    display:flex; align-items:flex-start; gap:9px;
    font-size:12.5px; color:var(--text-dark); line-height:1.5;
}
.sch-step-num {
    width:19px; height:19px; border-radius:50%;
    background:var(--primary-color); color:#fff;
    font-size:10px; font-weight:800;
    display:flex; align-items:center; justify-content:center;
    flex-shrink:0; margin-top:1px;
}
.sch-terms {
    font-size:11px; color:var(--text-light); line-height:1.7;
    background:#F5F9FC; border-radius:10px; padding:10px 13px;
    border:1px solid rgba(23,22,91,0.08);
}
.sch-terms ul { margin:0; padding-left:16px; }

.sch-card-foot { padding:0 22px 22px; margin-top:auto; }
.sch-apply-btn {
    display:inline-flex; align-items:center; gap:8px;
    background:var(--primary-color); color:#fff;
    padding:10px 22px; border-radius:9px; width:100%; justify-content:center;
    font-size:13px; font-weight:700; text-decoration:none;
    transition:all 0.3s ease;
}
.sch-apply-btn:hover { background:#0D1048; color:#fff; box-shadow:0 8px 22px rgba(23,22,91,0.3); }

/* --- Empty state --- */
.sch-empty {
    text-align:center; padding:60px 30px;
    background:#fff; border-radius:18px; border:1px solid rgba(23,22,91,0.1);
    margin-bottom:20px;
}
.sch-empty i { font-size:48px; color:var(--border-color); margin-bottom:16px; display:block; }
.sch-empty h3 { color:var(--text-dark); font-size:18px; margin:0 0 8px; }
.sch-empty p { color:var(--text-light); font-size:13.5px; margin:0 auto; max-width:420px; }

/* --- CTA banner --- */
.sch-cta {
    padding:52px 0;
    background:linear-gradient(130deg,var(--primary-color) 0%,#17165B 55%,#0D1048 100%);
    position:relative; overflow:hidden;
}
.sch-cta-inner {
    display:flex; align-items:center; justify-content:space-between;
    gap:24px; flex-wrap:wrap; position:relative; z-index:1;
}
.sch-cta h2 { color:#fff; font-size:24px; font-weight:800; margin:0 0 8px; }
.sch-cta p { color:rgba(255,255,255,0.7); font-size:13.5px; margin:0; max-width:460px; }
.sch-cta-btn {
    display:inline-flex; align-items:center; gap:8px;
    background:var(--accent-color); color:#fff;
    padding:13px 28px; border-radius:10px;
    font-size:14px; font-weight:700; text-decoration:none;
    white-space:nowrap; transition:all 0.3s ease;
}
.sch-cta-btn:hover { background:#078FB8; transform:translateY(-2px); box-shadow:0 10px 26px rgba(9,169,217,0.35); color:#fff; }
</style>

<!-- HERO -->
<section class="sch-hero">
    <div class="container" style="position:relative;z-index:2;">
        <div class="sch-breadcrumb">
            <a href="index.php"><i class="fas fa-home" style="font-size:11px;"></i> Home</a>
            <span><i class="fas fa-chevron-right" style="font-size:9px;"></i></span>
            <span>Scholarships</span>
        </div>
        <div class="sch-hero-badge">
            <i class="fas fa-award"></i> Financial Support
        </div>
        <h1>Scholarships &amp; <span>Financial Aid</span></h1>
        <p>We support deserving students through merit-based and need-based scholarships. Explore what's available and how to apply.</p>
    </div>
</section>

<!-- MERIT SCHOLARSHIP FORMULA -->
<section class="sch-formula-wrap">
    <div class="container">
        <div class="sch-formula-card">
            <div class="sch-formula-head">
                <div class="sch-formula-badge"><i class="fas fa-square-root-variable" style="font-size:9px;"></i> Merit Formula</div>
                <h2>Merit Scholarship <span style="color:var(--primary-color);">Calculation</span></h2>
                <p>The same merit percentage applies across University, Diploma and F.Sc programs, based on your marks obtained.</p>
            </div>
            <div class="sch-table-scroll">
                <table class="sch-formula-table">
                    <thead>
                        <tr>
                            <th>Marks Obtained</th>
                            <th>University Program</th>
                            <th>Diploma Program</th>
                            <th>F.Sc Program</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($merit_formula as $row): ?>
                        <tr>
                            <td><?php echo htmlspecialchars($row['range']); ?></td>
                            <td><span class="sch-pct-cell"><?php echo $row['pct']; ?>%</span></td>
                            <td><span class="sch-pct-cell"><?php echo $row['pct']; ?>%</span></td>
                            <td><span class="sch-pct-cell"><?php echo $row['pct']; ?>%</span></td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
            <div class="sch-formula-note">
                <i class="fas fa-circle-info"></i>
                <span>Merit percentage is calculated on your most recent qualifying result and applies to tuition fees only. Final award is subject to seat availability and verification of original documents.</span>
            </div>
        </div>
    </div>
</section>

<!-- SCHOLARSHIPS -->
<section class="sch-section">
    <div class="container">
        <?php if (!$has_any): ?>
            <div class="sch-empty">
                <i class="fas fa-award"></i>
                <h3>Scholarship Details Coming Soon</h3>
                <p>We're finalizing the details of our scholarship programs. Check back soon, or contact our admissions office to ask about current financial aid options.</p>
            </div>
        <?php else: ?>
            <?php foreach ($category_meta as $cat_key => $meta): if (empty($grouped[$cat_key])) continue; ?>
            <div class="sch-cat-group">
                <div class="sch-cat-head">
                    <div class="sch-cat-icon" style="background:<?php echo $meta['bg']; ?>;color:<?php echo $meta['color']; ?>;">
                        <i class="fas <?php echo $meta['icon']; ?>"></i>
                    </div>
                    <h2><?php echo htmlspecialchars($meta['label']); ?></h2>
                </div>
                <div class="sch-grid">
                    <?php foreach ($grouped[$cat_key] as $s):
                        $eligibility = array_values(array_filter(array_map('trim', explode("\n", $s['eligibility'] ?? ''))));
                        $steps       = array_values(array_filter(array_map('trim', explode("\n", $s['application_procedure'] ?? ''))));
                        $terms       = array_values(array_filter(array_map('trim', explode("\n", $s['terms_conditions'] ?? ''))));
                        $icon = $s['icon'] ?: 'fa-award';
                    ?>
                    <div class="sch-card">
                        <div class="sch-card-top">
                            <div style="display:flex;align-items:flex-start;gap:12px;">
                                <div class="sch-card-icon" style="background:<?php echo $meta['bg']; ?>;color:<?php echo $meta['color']; ?>;">
                                    <i class="fas <?php echo htmlspecialchars($icon); ?>"></i>
                                </div>
                                <h3><?php echo htmlspecialchars($s['title']); ?></h3>
                            </div>
                            <?php if (!empty($s['percentage'])): ?>
                            <span class="sch-pct"><?php echo htmlspecialchars($s['percentage']); ?></span>
                            <?php endif; ?>
                        </div>
                        <div class="sch-card-body">
                            <?php if (!empty($s['description'])): ?>
                            <p class="sch-desc"><?php echo htmlspecialchars($s['description']); ?></p>
                            <?php endif; ?>

                            <?php if (!empty($eligibility)): ?>
                            <div>
                                <div class="sch-subhead">Eligibility</div>
                                <div class="sch-list">
                                    <?php foreach ($eligibility as $e): ?>
                                    <div class="sch-list-item"><i class="fas fa-check-circle"></i> <?php echo htmlspecialchars($e); ?></div>
                                    <?php endforeach; ?>
                                </div>
                            </div>
                            <?php endif; ?>

                            <?php if (!empty($steps)): ?>
                            <div>
                                <div class="sch-subhead">How to Apply</div>
                                <div class="sch-steps">
                                    <?php foreach ($steps as $i => $step): ?>
                                    <div class="sch-step"><span class="sch-step-num"><?php echo $i + 1; ?></span> <?php echo htmlspecialchars($step); ?></div>
                                    <?php endforeach; ?>
                                </div>
                            </div>
                            <?php endif; ?>

                            <?php if (!empty($terms)): ?>
                            <div>
                                <div class="sch-subhead">Terms &amp; Conditions</div>
                                <div class="sch-terms">
                                    <ul>
                                        <?php foreach ($terms as $t): ?>
                                        <li><?php echo htmlspecialchars($t); ?></li>
                                        <?php endforeach; ?>
                                    </ul>
                                </div>
                            </div>
                            <?php endif; ?>
                        </div>
                        <div class="sch-card-foot">
                            <a href="admission.php?scholarship=<?php echo urlencode($s['title']); ?>#applyForm" class="sch-apply-btn">
                                Apply for Scholarship <i class="fas fa-arrow-right" style="font-size:11px;"></i>
                            </a>
                        </div>
                    </div>
                    <?php endforeach; ?>
                </div>
            </div>
            <?php endforeach; ?>
        <?php endif; ?>
    </div>
</section>

<!-- CTA -->
<section class="sch-cta">
    <div class="container">
        <div class="sch-cta-inner">
            <div>
                <h2>Have Questions About Scholarships?</h2>
                <p>Our admissions team can walk you through eligibility and help you apply for the right scholarship.</p>
            </div>
            <a href="admission.php?scholarship=1#applyForm" class="sch-cta-btn">
                <i class="fas fa-award"></i> Apply for Scholarship
            </a>
        </div>
    </div>
</section>

<?php include 'includes/footer.php'; ?>
