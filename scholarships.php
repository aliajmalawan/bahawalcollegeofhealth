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
$merit_min = $merit_formula ? min(array_column($merit_formula, 'min')) : null;

// Program types shown as formula columns (same tiers for each — see getMeritScholarshipTiers())
$program_types = ['university' => 'University Program', 'diploma' => 'Diploma Program', 'fsc' => 'F.Sc Program'];

// Programs with a published tuition fee, for the scholarship amount estimate
$sch_courses = [];
$scr = mysqli_query($conn, "SELECT id, name, duration, admission_fee, initial_fee, semester_fee, fee_period, total_fee FROM courses WHERE status='active' AND semester_fee IS NOT NULL ORDER BY display_order ASC, name ASC");
if ($scr) {
    while ($row = mysqli_fetch_assoc($scr)) {
        $sch_courses[] = [
            'id'            => (int) $row['id'],
            'name'          => $row['name'],
            'duration'      => $row['duration'] ?: '',
            'admission_fee' => $row['admission_fee'] !== null ? (float) $row['admission_fee'] : null,
            'initial_fee'   => $row['initial_fee'] !== null ? (float) $row['initial_fee'] : null,
            'semester_fee'  => (float) $row['semester_fee'],
            'fee_period'    => $row['fee_period'] === 'Month' ? 'Month' : 'Semester',
            'total_fee'     => $row['total_fee'] !== null ? (float) $row['total_fee'] : null,
        ];
    }
}
$json_flags = JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE | JSON_HEX_TAG | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_HEX_AMP;
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
.sch-formula-table tbody tr.sch-row-hit { background:#F0FDF4; }
.sch-formula-table tbody tr.sch-row-hit td:first-child { box-shadow:inset 4px 0 0 #16A34A; }
.sch-formula-table tbody tr.sch-row-hit .sch-pct-cell { background:#16A34A; color:#fff; }

/* Stack the formula table into cards on phones instead of scrolling sideways */
@media (max-width:600px) {
    .sch-formula-card { padding:22px 16px 24px; }
    .sch-table-scroll { border:none; overflow:visible; }
    .sch-formula-table { min-width:0; }
    .sch-formula-table thead { display:none; }
    .sch-formula-table, .sch-formula-table tbody, .sch-formula-table tr, .sch-formula-table td { display:block; width:100%; }
    .sch-formula-table tbody tr {
        border:1px solid rgba(23,22,91,0.1); border-radius:12px;
        margin-bottom:10px; overflow:hidden;
    }
    .sch-formula-table tbody td {
        display:flex; justify-content:space-between; align-items:center;
        padding:9px 14px; white-space:normal; text-align:right;
    }
    .sch-formula-table tbody td:first-child {
        background:linear-gradient(135deg,var(--primary-color),#0D1048); color:#fff;
        justify-content:flex-start;
    }
    .sch-formula-table tbody tr.sch-row-hit td:first-child { background:#16A34A; box-shadow:none; }
    .sch-formula-table tbody td[data-label]::before {
        content:attr(data-label); font-weight:600; color:var(--text-light); font-size:12.5px; text-align:left;
    }
    .sch-formula-table tbody tr:last-child td { border-bottom:1px solid rgba(23,22,91,0.07); }
    .sch-formula-table tbody tr td:last-child { border-bottom:none; }
}

/* --- Scholarship Calculator --- */
.sch-calc-wrap { padding:20px 0 12px; background:#F5F9FC; }
.sch-calc {
    background:#fff; border-radius:18px; border:1px solid rgba(23,22,91,0.1);
    padding:30px 32px 32px;
    display:grid; grid-template-columns:minmax(0,5fr) minmax(0,7fr); gap:30px;
}
.sch-calc h2 { font-size:20px; font-weight:800; color:var(--text-dark); margin:0 0 6px; display:flex; align-items:center; gap:10px; }
.sch-calc h2 i { color:var(--primary-color); }
.sch-calc-intro { font-size:13px; color:var(--text-light); margin:0 0 20px; line-height:1.6; }
.sch-field { margin-bottom:16px; }
.sch-field label { display:block; font-size:12.5px; font-weight:700; color:var(--text-dark); margin-bottom:6px; }
.sch-field input, .sch-field select {
    width:100%; padding:11px 13px; font-family:var(--font); font-size:14px;
    color:var(--text-dark); border:1px solid #d7dde0; border-radius:9px; background:#f9fafb;
}
.sch-field input:focus, .sch-field select:focus {
    outline:none; border-color:var(--primary-color); background:#fff; box-shadow:0 0 0 3px rgba(23,22,91,0.1);
}
.sch-field small { display:block; margin-top:5px; font-size:11px; color:var(--text-light); line-height:1.5; }
.sch-types { display:grid; grid-template-columns:repeat(3,minmax(0,1fr)); gap:8px; }
.sch-type input { position:absolute; opacity:0; pointer-events:none; }
.sch-type span {
    display:flex; align-items:center; justify-content:center; text-align:center;
    min-height:44px; padding:8px 6px; border-radius:9px; cursor:pointer;
    border:1px solid #d7dde0; background:#f9fafb;
    font-size:12px; font-weight:700; color:var(--text-light); line-height:1.3; transition:all 0.2s ease;
}
.sch-type input:checked + span { background:var(--primary-color); border-color:var(--primary-color); color:#fff; }
.sch-type input:focus-visible + span { box-shadow:0 0 0 3px rgba(23,22,91,0.25); }

.sch-result { background:#F5F9FC; border-radius:14px; padding:22px; border:1px solid rgba(23,22,91,0.08); }
.sch-result-empty { text-align:center; color:var(--text-light); font-size:13px; padding:30px 10px; line-height:1.6; }
.sch-result-empty i { font-size:32px; opacity:0.3; display:block; margin-bottom:10px; }
.sch-result-hero { display:flex; align-items:center; gap:18px; flex-wrap:wrap; }
.sch-result-pct {
    width:96px; height:96px; border-radius:50%; flex-shrink:0;
    background:linear-gradient(135deg,#16A34A,#15803D); color:#fff;
    display:flex; flex-direction:column; align-items:center; justify-content:center;
    box-shadow:0 10px 24px rgba(22,163,74,0.3);
}
.sch-result-pct strong { font-size:28px; font-weight:800; line-height:1; }
.sch-result-pct small { font-size:10px; opacity:0.85; text-transform:uppercase; letter-spacing:0.5px; margin-top:3px; }
.sch-result-pct.sch-none { background:linear-gradient(135deg,#9CA3AF,#6B7280); box-shadow:none; }
.sch-result-hero h3 { font-size:17px; font-weight:800; color:var(--text-dark); margin:0 0 4px; }
.sch-result-hero p { font-size:12.5px; color:var(--text-light); margin:0; line-height:1.55; }
.sch-amounts { margin-top:18px; border-top:1px dashed rgba(23,22,91,0.18); padding-top:14px; }
.sch-amt-row { display:flex; justify-content:space-between; gap:12px; padding:6px 0; font-size:13px; color:var(--text-light); }
.sch-amt-row strong { color:var(--text-dark); white-space:nowrap; }
.sch-amt-row.sch-save strong { color:#16A34A; }
.sch-amt-row.sch-final { border-top:1px solid rgba(23,22,91,0.1); margin-top:4px; padding-top:10px; font-weight:700; color:var(--text-dark); }
.sch-amt-row.sch-final strong { color:var(--primary-color); font-size:16px; }
.sch-amt-title { font-size:11px; font-weight:700; letter-spacing:1px; text-transform:uppercase; color:var(--primary-color); margin:12px 0 2px; }
.sch-amt-note { font-size:11px; color:var(--text-light); margin-top:8px; line-height:1.55; }
.sch-calc-link { display:inline-flex; align-items:center; gap:6px; margin-top:14px; font-size:13px; font-weight:700; color:var(--primary-color); text-decoration:none; }
.sch-calc-link:hover { color:var(--accent-color); }
@media (max-width:900px) { .sch-calc { grid-template-columns:1fr; } }
@media (max-width:600px) {
    .sch-calc { padding:22px 16px 24px; }
    .sch-result { padding:16px; }
}

/* --- Merit policy summary --- */
.sch-policy { display:grid; grid-template-columns:repeat(3,minmax(0,1fr)); gap:16px; margin-top:22px; }
.sch-policy > div { background:#F5F9FC; border:1px solid rgba(23,22,91,0.08); border-radius:12px; padding:14px 16px; }
.sch-policy h4 { font-size:13px; font-weight:800; color:var(--primary-color); margin:0 0 8px; display:flex; align-items:center; gap:7px; }
.sch-policy ul { margin:0; padding-left:18px; list-style:disc; }
.sch-policy li { font-size:12.5px; color:var(--text-dark); line-height:1.6; padding:1px 0; }
@media (max-width:900px) { .sch-policy { grid-template-columns:1fr; } }

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
                <p>Your merit scholarship is based on the marks percentage of your most recent qualifying result. The same percentage applies to University, Diploma and F.Sc programs.</p>
            </div>
            <div class="sch-table-scroll">
                <table class="sch-formula-table">
                    <caption class="sr-only" style="position:absolute;left:-9999px;">Merit scholarship percentage by marks obtained and program type</caption>
                    <thead>
                        <tr>
                            <th scope="col">Marks Percentage</th>
                            <?php foreach ($program_types as $type_label): ?>
                            <th scope="col"><?php echo $type_label; ?></th>
                            <?php endforeach; ?>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($merit_formula as $row): ?>
                        <tr data-min="<?php echo (int) $row['min']; ?>">
                            <td><?php echo htmlspecialchars($row['range']); ?></td>
                            <?php foreach ($program_types as $type_label): ?>
                            <td data-label="<?php echo $type_label; ?>"><span class="sch-pct-cell"><?php echo $row['pct']; ?>%</span></td>
                            <?php endforeach; ?>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
            <div class="sch-formula-note">
                <i class="fas fa-circle-info"></i>
                <span>Merit percentage is calculated on your most recent qualifying result and applies to tuition fees only. Final award is subject to seat availability and verification of original documents.</span>
            </div>
            <div class="sch-policy">
                <div>
                    <h4><i class="fas fa-user-check"></i> Eligibility</h4>
                    <ul>
                        <?php if ($merit_min !== null): ?><li>Minimum <?php echo (int) $merit_min; ?>% marks in your most recent qualifying result</li><?php endif; ?>
                        <li>Open to University, Diploma and F.Sc program applicants</li>
                        <li>Subject to seat availability</li>
                    </ul>
                </div>
                <div>
                    <h4><i class="fas fa-list-ol"></i> How to Apply</h4>
                    <ul>
                        <li>Submit the <a href="admission.php?scholarship=Merit%20Scholarship#applyForm" style="color:var(--primary-color);font-weight:700;">admission form</a> and mention the Merit Scholarship</li>
                        <li>Attach your result card / certificate</li>
                        <li>Bring original documents for verification</li>
                    </ul>
                </div>
                <div>
                    <h4><i class="fas fa-file-contract"></i> Terms</h4>
                    <ul>
                        <li>Applies to tuition fees (semester / monthly fee) only</li>
                        <li>Admission Fee, Initial Fee, examination, verification and university charges are not discounted</li>
                        <li>Final award after verification of original documents</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- SCHOLARSHIP CALCULATOR -->
<section class="sch-calc-wrap" id="calculator">
    <div class="container">
        <div class="sch-calc">
            <div>
                <h2><i class="fas fa-calculator"></i> Scholarship Calculator</h2>
                <p class="sch-calc-intro">Enter your marks and program type to see your merit scholarship. Select a program to estimate the amount you save and what remains payable.</p>

                <div class="sch-field">
                    <label for="schMarks">Your Marks Percentage *</label>
                    <input type="number" id="schMarks" min="0" max="100" step="0.01" inputmode="decimal" placeholder="e.g. 86">
                    <small>Use the percentage from your most recent qualifying result.</small>
                </div>

                <div class="sch-field">
                    <label id="schTypeLabel">Program Type *</label>
                    <div class="sch-types" role="radiogroup" aria-labelledby="schTypeLabel">
                        <?php $first = true; foreach ($program_types as $type_key => $type_label): ?>
                        <label class="sch-type"><input type="radio" name="schType" value="<?php echo $type_key; ?>" <?php echo $first ? 'checked' : ''; ?>><span><?php echo $type_label; ?></span></label>
                        <?php $first = false; endforeach; ?>
                    </div>
                </div>

                <div class="sch-field">
                    <label for="schProgram">Program (optional — for amount estimate)</label>
                    <select id="schProgram">
                        <option value=""><?php echo $sch_courses ? '— Select a program —' : 'No program fees published yet'; ?></option>
                        <?php foreach ($sch_courses as $c): ?>
                        <option value="<?php echo $c['id']; ?>"><?php echo htmlspecialchars($c['name']); ?></option>
                        <?php endforeach; ?>
                    </select>
                    <small>Only programs with published fees are listed.</small>
                </div>
            </div>

            <div class="sch-result" id="schResult" aria-live="polite">
                <div class="sch-result-empty"><i class="fas fa-award"></i>Enter your marks percentage to see your scholarship.</div>
            </div>
        </div>
    </div>
</section>

<script>
(function () {
    var TIERS = <?php echo json_encode(array_map(function ($t) { return ['min' => (float) $t['min'], 'range' => $t['range'], 'pct' => (float) $t['pct']]; }, $merit_formula), $json_flags); ?>;
    var COURSES = <?php echo json_encode($sch_courses, $json_flags); ?>;
    var TYPES = <?php echo json_encode($program_types, $json_flags); ?>;
    var MIN = <?php echo $merit_min !== null ? (float) $merit_min : 'null'; ?>;

    // Highest tier whose minimum the marks reach — so 89.5% falls in "85–89" rather than nowhere
    TIERS.sort(function (a, b) { return b.min - a.min; });
    function tierFor(marks) {
        for (var i = 0; i < TIERS.length; i++) if (marks >= TIERS[i].min) return TIERS[i];
        return null;
    }
    function fmt(n) { return 'Rs. ' + Math.round(n).toLocaleString('en-PK'); }
    function esc(s) { return String(s).replace(/[&<>"']/g, function (c) { return {'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]; }); }
    // "5 Years" -> 10 semesters / 60 months; null if the duration can't be read
    function periods(duration, period) {
        var m = String(duration || '').match(/(\d+(?:\.\d+)?)\s*(year|yr|month|semester)/i);
        if (!m) return null;
        var n = parseFloat(m[1]), u = m[2].toLowerCase();
        var months = u.indexOf('month') === 0 ? n : (u === 'semester' ? n * 6 : n * 12);
        var c = period === 'Month' ? months : months / 6;
        return c >= 1 ? Math.round(c) : null;
    }

    var marksEl = document.getElementById('schMarks');
    var progEl = document.getElementById('schProgram');
    var out = document.getElementById('schResult');
    var rows = document.querySelectorAll('.sch-formula-table tbody tr[data-min]');

    function highlight(tier) {
        rows.forEach(function (r) { r.classList.toggle('sch-row-hit', !!tier && parseFloat(r.dataset.min) === tier.min); });
    }

    function calc() {
        var raw = marksEl.value.trim();
        var typeEl = document.querySelector('input[name="schType"]:checked');
        var typeLabel = TYPES[typeEl ? typeEl.value : 'university'];
        if (raw === '') {
            highlight(null);
            out.innerHTML = '<div class="sch-result-empty"><i class="fas fa-award"></i>Enter your marks percentage to see your scholarship.</div>';
            return;
        }
        var marks = parseFloat(raw);
        if (isNaN(marks) || marks < 0 || marks > 100) {
            highlight(null);
            out.innerHTML = '<div class="sch-result-empty"><i class="fas fa-triangle-exclamation"></i>Please enter a marks percentage between 0 and 100.</div>';
            return;
        }
        var tier = tierFor(marks);
        highlight(tier);
        var pct = tier ? tier.pct : 0;
        var h = '<div class="sch-result-hero">';
        h += '<div class="sch-result-pct' + (pct ? '' : ' sch-none') + '"><strong>' + pct + '%</strong><small>Scholarship</small></div><div>';
        if (tier) {
            h += '<h3>You qualify for a ' + pct + '% Merit Scholarship</h3>';
            h += '<p>' + esc(typeLabel) + ' &middot; ' + marks + '% marks falls in the <strong>' + esc(tier.range) + '</strong> tier. Applies to tuition fees only.</p>';
        } else {
            h += '<h3>Not eligible for a Merit Scholarship</h3>';
            h += '<p>' + (MIN !== null ? 'A minimum of ' + MIN + '% marks is required.' : '') + ' You may still be eligible for other scholarships listed below.</p>';
        }
        h += '</div></div>';

        var c = COURSES.find(function (x) { return String(x.id) === progEl.value; });
        if (c && pct) {
            var isMonth = c.fee_period === 'Month';
            var unit = isMonth ? 'month' : 'semester';
            var S = c.semester_fee, cut = S * pct / 100, n = periods(c.duration, c.fee_period);
            h += '<div class="sch-amounts">';
            h += '<div class="sch-amt-title">' + esc(c.name) + '</div>';
            h += '<div class="sch-amt-row"><span>' + (isMonth ? 'Monthly' : 'Semester') + ' fee (tuition)</span><strong>' + fmt(S) + '</strong></div>';
            h += '<div class="sch-amt-row sch-save"><span>Scholarship amount (' + pct + '%)</span><strong>&minus; ' + fmt(cut) + ' / ' + unit + '</strong></div>';
            h += '<div class="sch-amt-row sch-final"><span>Remaining payable per ' + unit + '</span><strong>' + fmt(S - cut) + '</strong></div>';
            if (c.total_fee !== null && n !== null) {
                // Initial Fee covers the 1st semester/month, so the discount applies to the remaining ones
                var discounted = c.initial_fee !== null ? n - 1 : n;
                if (discounted > 0) {
                    var save = cut * discounted;
                    h += '<div class="sch-amt-title" style="margin-top:14px;">Full program estimate</div>';
                    h += '<div class="sch-amt-row"><span>Total program fee (listed)</span><strong>' + fmt(c.total_fee) + '</strong></div>';
                    h += '<div class="sch-amt-row sch-save"><span>Total scholarship (' + discounted + ' ' + unit + 's)</span><strong>&minus; ' + fmt(save) + '</strong></div>';
                    h += '<div class="sch-amt-row sch-final"><span>Estimated remaining payable</span><strong>' + fmt(Math.max(c.total_fee - save, 0)) + '</strong></div>';
                }
            }
            var atAdm = c.initial_fee !== null ? (c.admission_fee || 0) + c.initial_fee : null;
            h += '<p class="sch-amt-note">' + (atAdm !== null ? 'Payable at admission: ' + fmt(atAdm) + ' (Admission Fee + Initial Fee, which covers the 1st ' + unit + '; not discounted). ' : '') +
                 'Examination, verification and university charges are not included. Estimate only — subject to verification and seat availability.</p>';
            h += '</div>';
            h += '<a class="sch-calc-link" href="fee-calculator.php?course=' + c.id + '&amp;merit=' + encodeURIComponent(marks) + '">See full fee breakdown <i class="fas fa-arrow-right"></i></a>';
        } else if (pct && COURSES.length) {
            h += '<p class="sch-amt-note" style="margin-top:14px;">Select a program to estimate your scholarship amount and remaining payable fee.</p>';
        }
        out.innerHTML = h;
    }

    marksEl.addEventListener('input', calc);
    progEl.addEventListener('change', calc);
    document.querySelectorAll('input[name="schType"]').forEach(function (r) { r.addEventListener('change', calc); });
})();
</script>

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
