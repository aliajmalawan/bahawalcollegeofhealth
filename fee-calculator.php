<?php
require_once 'includes/config.php';
require_once 'includes/course_helper.php';
$page_title = 'Fee Calculator';
$page_description = 'Estimate your program fees and scholarship discounts at Bahawal College of Health Sciences with our free online fee calculator.';

// Only real, database-backed course data — no fabricated numbers.
$courses = [];
$cr = mysqli_query($conn, "SELECT id, name, duration, department, affiliation, admission_fee, initial_fee, semester_fee, fee_period, total_fee FROM courses WHERE status='active' ORDER BY display_order ASC, name ASC");
if ($cr) {
    while ($row = mysqli_fetch_assoc($cr)) {
        $courses[] = $row;
    }
}

$json_flags = JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE | JSON_HEX_TAG | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_HEX_AMP;
$num = function ($v) { return $v !== null ? (float) $v : null; };

// Embed as JSON for the client-side calculator — null stays null (never coerced to 0)
$courses_json = json_encode(array_map(function ($c) use ($num) {
    return [
        'id'            => (int) $c['id'],
        'name'          => $c['name'],
        'duration'      => $c['duration'] ?: '',
        'department'    => $c['department'] ?: '',
        'affiliation'   => $c['affiliation'] ?: '',
        'admission_fee' => $num($c['admission_fee']),
        'initial_fee'   => $num($c['initial_fee']),
        'semester_fee'  => $num($c['semester_fee']),
        'fee_period'    => $c['fee_period'] === 'Month' ? 'Month' : 'Semester',
        'total_fee'     => $num($c['total_fee']),
    ];
}, $courses), $json_flags);

// Merit Scholarship tiers — same source of truth as the Scholarships page (includes/settings_helper.php)
$merit_tiers = getMeritScholarshipTiers();
$merit_tiers_json = json_encode(array_map(function ($t) {
    return ['min' => (float) $t['min'], 'max' => $t['max'] !== null ? (float) $t['max'] : null, 'pct' => (float) $t['pct']];
}, $merit_tiers), $json_flags);
$merit_min = $merit_tiers ? min(array_column($merit_tiers, 'min')) : null;
// Human-readable summary built from the same tiers, so it can never drift out of
// sync with the admin-managed percentages (AdminCP > Scholarships > Merit Tiers).
$merit_tiers_text = implode(', ', array_map(function ($t) {
    return $t['range'] . ' = ' . $t['pct'] . '%';
}, $merit_tiers));

// Other scholarships from AdminCP > Scholarships. Only a single fixed percentage
// (e.g. "50%") can be calculated; anything else ("Up to 100%", "Varies") is listed for reference.
$fixed_scholarships = [];
$other_scholarships = [];
$sr = mysqli_query($conn, "SELECT id, title, category, percentage FROM scholarships WHERE status='active' ORDER BY display_order ASC, id ASC");
if ($sr) {
    while ($row = mysqli_fetch_assoc($sr)) {
        if (preg_match('/^\s*(\d{1,3}(?:\.\d+)?)\s*%?\s*$/', (string) $row['percentage'], $m) && (float) $m[1] > 0 && (float) $m[1] <= 100) {
            $fixed_scholarships[] = ['id' => (int) $row['id'], 'title' => $row['title'], 'pct' => (float) $m[1]];
        } else {
            $other_scholarships[] = $row;
        }
    }
}
$scholarships_json = json_encode($fixed_scholarships, $json_flags);

$preselect = isset($_GET['course']) ? intval($_GET['course']) : 0;
?>
<?php include 'includes/header.php'; ?>

<style>
/* ===== FEE CALCULATOR PAGE ===== */

/* --- Hero --- */
.fc-hero {
    background: linear-gradient(135deg,#0D1048 0%,#17165B 55%,#0D1048 100%);
    padding: 62px 0 50px;
    position: relative; overflow: hidden;
}
.fc-hero::after {
    content:'';
    position:absolute; bottom:-1px; left:0; right:0;
    height:40px;
    background:#F5F9FC;
    clip-path:ellipse(55% 100% at 50% 100%);
}
.fc-breadcrumb {
    display:flex; align-items:center; gap:8px;
    font-size:12px; color:rgba(255,255,255,0.5); margin-bottom:18px;
    position:relative; z-index:1;
}
.fc-breadcrumb a { color:rgba(255,255,255,0.6); text-decoration:none; }
.fc-breadcrumb a:hover { color:var(--accent-color); }
.fc-hero-badge {
    display:inline-flex; align-items:center; gap:7px;
    background:rgba(9,169,217,0.14); border:1px solid rgba(9,169,217,0.35);
    color:var(--accent-color); padding:6px 18px; border-radius:50px;
    font-size:10.5px; font-weight:700; letter-spacing:2px;
    text-transform:uppercase; margin-bottom:16px;
    position:relative; z-index:1;
}
.fc-hero h1 {
    font-size:38px; font-weight:800; color:#fff;
    margin:0 0 12px; line-height:1.15;
    position:relative; z-index:1;
}
.fc-hero h1 span { color:var(--accent-color); }
.fc-hero p {
    color:rgba(255,255,255,0.72); font-size:15px; margin:0; max-width:560px; line-height:1.7;
    position:relative; z-index:1;
}

/* --- Layout --- */
.fc-section { padding:52px 0 64px; background:#F5F9FC; }
.fc-layout { display:grid; grid-template-columns:minmax(0,5fr) minmax(0,7fr); gap:28px; align-items:start; }
@media (max-width:900px) { .fc-layout { grid-template-columns:1fr; } }

.fc-card {
    background:#fff; border-radius:18px; border:1px solid rgba(23,22,91,0.1);
    padding:26px 26px 28px;
}
.fc-card + .fc-card { margin-top:20px; }
.fc-card h3 {
    font-size:15px; font-weight:800; color:var(--primary-color);
    margin:0 0 18px; display:flex; align-items:center; gap:9px;
}
.fc-step {
    width:22px; height:22px; border-radius:50%; background:var(--primary-color); color:#fff;
    font-size:11.5px; display:inline-flex; align-items:center; justify-content:center; flex-shrink:0;
}

.fc-field { margin-bottom:16px; }
.fc-field:last-child { margin-bottom:0; }
.fc-field label { display:block; font-size:12.5px; font-weight:700; color:var(--text-dark); margin-bottom:6px; }
.fc-field select, .fc-field input {
    width:100%; padding:11px 13px; font-family:var(--font); font-size:13.5px;
    color:var(--text-dark); border:1px solid #d7dde0; border-radius:9px;
    background:#f9fafb; transition:var(--transition);
}
.fc-field select:focus, .fc-field input:focus {
    outline:none; border-color:var(--primary-color); background:#fff;
    box-shadow:0 0 0 3px rgba(23,22,91,0.1);
}
.fc-field small { display:block; margin-top:5px; font-size:11px; color:var(--text-light); line-height:1.5; }
.fc-merit-note { font-size:11.5px; margin-top:6px; display:none; font-weight:600; line-height:1.5; }
.fc-merit-note.ok { color:#16A34A; }
.fc-merit-note.bad { color:#DC2626; }

.fc-prog-info { display:none; margin-top:12px; padding:12px 14px; border-radius:10px; background:#F5F9FC; border:1px solid rgba(23,22,91,0.08); }
.fc-prog-info div { font-size:12px; color:var(--text-light); display:flex; gap:7px; padding:2px 0; line-height:1.5; }
.fc-prog-info i { color:var(--primary-color); width:13px; text-align:center; margin-top:3px; }
.fc-prog-info strong { color:var(--text-dark); font-weight:600; }
.fc-prog-info a { color:var(--primary-color); font-weight:700; text-decoration:none; font-size:12px; }

.fc-other-sch { margin-top:14px; font-size:11.5px; color:var(--text-light); line-height:1.6; }
.fc-other-sch ul { margin:4px 0 0; padding-left:18px; }

/* --- Breakdown --- */
.fc-group-title {
    font-size:11px; font-weight:700; letter-spacing:1px; text-transform:uppercase;
    color:var(--text-light); margin:0 0 4px;
}
.fc-breakdown-row {
    display:flex; justify-content:space-between; align-items:center; gap:12px;
    padding:9px 0; font-size:13px; color:var(--text-light);
    border-bottom:1px solid rgba(23,22,91,0.07);
}
.fc-breakdown-row small { display:block; font-size:11px; color:var(--text-light); font-weight:400; margin-top:1px; }
.fc-breakdown-row > span:first-child { color:var(--text-dark); font-weight:600; }
.fc-breakdown-row > span:last-child { color:var(--text-dark); font-weight:700; text-align:right; white-space:nowrap; }
.fc-breakdown-row .fc-na { color:var(--text-light); font-weight:500; font-style:italic; }
.fc-breakdown-row.fc-discount > span:last-child { color:#16A34A; }
.fc-breakdown-row.fc-discount > span:first-child { color:#15803D; }

.fc-pay-grid { display:grid; grid-template-columns:1fr 1fr; gap:12px; margin-top:18px; }
@media (max-width:520px) { .fc-pay-grid { grid-template-columns:1fr; } }
.fc-total-box {
    padding:16px 18px; border-radius:14px;
    background:linear-gradient(135deg,var(--primary-color),#0D1048);
    color:#fff;
}
.fc-total-box.fc-alt { background:#EAF7FB; color:var(--text-dark); border:1px solid rgba(9,169,217,0.25); }
.fc-total-label { font-size:11px; opacity:0.8; letter-spacing:0.5px; text-transform:uppercase; margin-bottom:4px; font-weight:700; }
.fc-total-amount { font-size:24px; font-weight:800; line-height:1.2; }
.fc-alt .fc-total-amount { color:var(--primary-color); }
.fc-total-amount s { font-size:13px; font-weight:600; opacity:0.6; margin-left:6px; }
.fc-total-sub { font-size:11.5px; opacity:0.75; margin-top:5px; line-height:1.45; }

.fc-program-total {
    margin-top:12px; padding:14px 16px; border-radius:12px;
    border:1px dashed rgba(23,22,91,0.25); background:#fff;
}
.fc-program-total .fc-pt-row { display:flex; justify-content:space-between; gap:10px; font-size:13px; padding:3px 0; color:var(--text-light); }
.fc-program-total .fc-pt-row strong { color:var(--text-dark); white-space:nowrap; }
.fc-program-total .fc-pt-row.fc-pt-final { border-top:1px solid rgba(23,22,91,0.1); margin-top:5px; padding-top:8px; font-weight:700; color:var(--text-dark); }
.fc-program-total .fc-pt-row.fc-pt-final strong { color:var(--primary-color); font-size:16px; }
.fc-program-total .fc-pt-row.fc-pt-save strong { color:#16A34A; }

.fc-inc-grid { display:grid; grid-template-columns:1fr 1fr; gap:12px; margin-top:18px; }
@media (max-width:520px) { .fc-inc-grid { grid-template-columns:1fr; } }
.fc-inc-box { border-radius:12px; padding:12px 14px; font-size:12.5px; }
.fc-inc-box h4 { font-size:12px; font-weight:800; margin:0 0 8px; display:flex; align-items:center; gap:7px; text-transform:uppercase; letter-spacing:0.5px; }
.fc-inc-box ul { list-style:none; margin:0; padding:0; }
.fc-inc-box li { display:flex; gap:7px; align-items:flex-start; padding:3px 0; color:var(--text-dark); line-height:1.45; }
.fc-inc-box li i { margin-top:3px; font-size:11px; flex-shrink:0; }
.fc-inc-yes { background:#F0FDF4; border:1px solid rgba(22,163,74,0.22); }
.fc-inc-yes h4, .fc-inc-yes li i { color:#15803D; }
.fc-inc-no { background:#fdf2f2; border:1px solid rgba(220,38,38,0.2); }
.fc-inc-no h4, .fc-inc-no li i { color:#DC2626; }
.fc-inc-no p { margin:6px 0 0; font-size:11px; color:#991b1b; line-height:1.5; }

.fc-disclaimer { margin-top:16px; font-size:11px; color:var(--text-light); line-height:1.6; }
.fc-disclaimer i { color:var(--primary-color); }

.fc-empty-msg {
    text-align:center; padding:30px 10px; color:var(--text-light); font-size:13px; line-height:1.6;
}
.fc-empty-msg i { font-size:32px; opacity:0.3; display:block; margin-bottom:12px; }
.fc-empty-msg a { color:var(--primary-color); font-weight:700; }
.fc-actions { display:flex; gap:10px; flex-wrap:wrap; margin-top:18px; }
.fc-btn {
    display:inline-flex; align-items:center; gap:7px; padding:10px 18px; border-radius:9px;
    font-size:13px; font-weight:700; text-decoration:none; transition:all 0.25s ease;
    background:var(--primary-color); color:#fff;
}
.fc-btn:hover { background:#0D1048; color:#fff; }
.fc-btn.fc-btn-outline { background:#fff; color:var(--primary-color); border:1px solid rgba(23,22,91,0.25); }
.fc-btn.fc-btn-outline:hover { background:rgba(23,22,91,0.05); }

@media (max-width:600px) {
    .fc-hero h1 { font-size:28px; }
    .fc-card { padding:20px 16px 22px; }
}
@media print {
    header, footer, .fc-hero, .fc-inputs, .fc-actions { display:none !important; }
    .fc-layout { grid-template-columns:1fr; }
}
</style>

<!-- HERO -->
<section class="fc-hero">
    <div class="container" style="position:relative;z-index:2;">
        <div class="fc-breadcrumb">
            <a href="index.php"><i class="fas fa-home" style="font-size:11px;"></i> Home</a>
            <span><i class="fas fa-chevron-right" style="font-size:9px;"></i></span>
            <span>Fee Calculator</span>
        </div>
        <div class="fc-hero-badge">
            <i class="fas fa-calculator"></i> Plan Ahead
        </div>
        <h1>Program Fee <span>Calculator</span></h1>
        <p>Select a program to see its fee breakdown from our records, apply a scholarship, and get an estimate of what you'll pay at admission and each semester or month after that.</p>
    </div>
</section>

<!-- CALCULATOR -->
<section class="fc-section">
    <div class="container">
        <div class="fc-layout">

            <!-- Inputs -->
            <div class="fc-inputs">
                <div class="fc-card">
                    <h3><span class="fc-step">1</span> Choose Your Program</h3>
                    <div class="fc-field">
                        <label for="fcProgram">Program *</label>
                        <select id="fcProgram">
                            <option value="">— Select a Program —</option>
                            <?php foreach ($courses as $c): ?>
                            <option value="<?php echo (int) $c['id']; ?>" <?php echo $preselect === (int) $c['id'] ? 'selected' : ''; ?>><?php echo htmlspecialchars($c['name']); ?></option>
                            <?php endforeach; ?>
                        </select>
                        <div class="fc-prog-info" id="fcProgInfo"></div>
                    </div>
                </div>

                <div class="fc-card">
                    <h3><span class="fc-step">2</span> Scholarship / Discount</h3>
                    <div class="fc-field">
                        <label for="fcScholarship">Available Scholarships</label>
                        <select id="fcScholarship">
                            <option value="none">No scholarship</option>
                            <?php if (!empty($merit_tiers)): ?>
                            <option value="merit">Merit Scholarship (based on your marks %)</option>
                            <?php endif; ?>
                            <?php foreach ($fixed_scholarships as $s): ?>
                            <option value="s<?php echo $s['id']; ?>"><?php echo htmlspecialchars($s['title']); ?> (<?php echo rtrim(rtrim(number_format($s['pct'], 2), '0'), '.'); ?>%)</option>
                            <?php endforeach; ?>
                            <option value="percent">Other discount — percentage (%)</option>
                            <option value="fixed">Other discount — fixed amount per semester / month (Rs.)</option>
                        </select>
                        <small>Scholarships and discounts apply to the tuition fee (semester / monthly fee) only — not to the Admission Fee or Initial Fee.</small>
                    </div>
                    <div class="fc-field" id="fcValueWrap" style="display:none;">
                        <label for="fcValue" id="fcValueLabel">Value</label>
                        <input type="number" id="fcValue" min="0" step="0.01" inputmode="decimal">
                        <div class="fc-merit-note" id="fcMeritNote"></div>
                        <small id="fcMeritHelp" style="display:none;">Merit tiers: <?php echo htmlspecialchars($merit_tiers_text); ?>. See the <a href="scholarships.php" style="color:var(--primary-color);font-weight:700;">Scholarships page</a> for terms.</small>
                    </div>
                    <?php if (!empty($other_scholarships)): ?>
                    <div class="fc-other-sch">
                        <strong style="color:var(--text-dark);">Also available</strong> (amount decided case by case):
                        <ul>
                            <?php foreach ($other_scholarships as $os): ?>
                            <li><?php echo htmlspecialchars($os['title']); ?><?php echo $os['percentage'] !== null && $os['percentage'] !== '' ? ' — ' . htmlspecialchars($os['percentage']) : ''; ?></li>
                            <?php endforeach; ?>
                        </ul>
                        <a href="scholarships.php" style="color:var(--primary-color);font-weight:700;">View scholarship details &rarr;</a>
                    </div>
                    <?php endif; ?>
                </div>
            </div>

            <!-- Breakdown -->
            <div class="fc-card">
                <h3><i class="fas fa-file-invoice-dollar"></i> Fee Breakdown &amp; Estimate</h3>
                <div id="fcResults" aria-live="polite">
                    <div class="fc-empty-msg">
                        <i class="fas fa-calculator"></i>
                        Select a program to see its fee breakdown.
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
(function() {
    var COURSES = <?php echo $courses_json; ?>;
    var MERIT_TIERS = <?php echo $merit_tiers_json; ?>;
    var MERIT_MIN = <?php echo $merit_min !== null ? (float) $merit_min : 'null'; ?>;
    var SCHOLARSHIPS = <?php echo $scholarships_json; ?>;

    var el = {
        program: document.getElementById('fcProgram'),
        progInfo: document.getElementById('fcProgInfo'),
        scholarship: document.getElementById('fcScholarship'),
        valueWrap: document.getElementById('fcValueWrap'),
        value: document.getElementById('fcValue'),
        valueLabel: document.getElementById('fcValueLabel'),
        meritNote: document.getElementById('fcMeritNote'),
        meritHelp: document.getElementById('fcMeritHelp'),
        results: document.getElementById('fcResults')
    };

    function esc(s) {
        return String(s).replace(/[&<>"']/g, function(ch) {
            return {'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[ch];
        });
    }
    function fmt(n) { return 'Rs. ' + Math.round(n).toLocaleString('en-PK'); }
    function has(v) { return v !== null && v !== undefined; }

    // Highest tier whose minimum the marks reach — so 89.5% falls in "85–89" rather than nowhere
    MERIT_TIERS.sort(function(a, b) { return b.min - a.min; });
    function getMeritPercent(marks) {
        for (var i = 0; i < MERIT_TIERS.length; i++) {
            if (marks >= MERIT_TIERS[i].min) return MERIT_TIERS[i].pct;
        }
        return 0;
    }

    // "5 Years" -> 10 semesters / 60 months; "6 Months" -> 1 semester / 6 months. null if unreadable.
    function periodsFromDuration(duration, period) {
        var m = String(duration || '').match(/(\d+(?:\.\d+)?)\s*(year|yr|month|semester)/i);
        if (!m) return null;
        var n = parseFloat(m[1]), unit = m[2].toLowerCase();
        var months = unit.indexOf('month') === 0 ? n : (unit === 'semester' ? n * 6 : n * 12);
        var count = period === 'Month' ? months : months / 6;
        return count >= 1 ? Math.round(count) : null;
    }

    function currentCourse() {
        return COURSES.find(function(c) { return String(c.id) === el.program.value; }) || null;
    }

    function renderProgInfo(c) {
        if (!c) { el.progInfo.style.display = 'none'; return; }
        var h = '';
        if (c.duration)    h += '<div><i class="fas fa-clock"></i><span><strong>Duration:</strong> ' + esc(c.duration) + '</span></div>';
        if (c.department)  h += '<div><i class="fas fa-building-columns"></i><span><strong>Department:</strong> ' + esc(c.department) + '</span></div>';
        if (c.affiliation) h += '<div><i class="fas fa-certificate"></i><span><strong>Affiliation:</strong> ' + esc(c.affiliation) + '</span></div>';
        h += '<div style="margin-top:4px;"><a href="course.php?id=' + c.id + '">View program details &rarr;</a></div>';
        el.progInfo.innerHTML = h;
        el.progInfo.style.display = 'block';
    }

    function onScholarshipChange() {
        var v = el.scholarship.value;
        var needsValue = v === 'merit' || v === 'percent' || v === 'fixed';
        el.valueWrap.style.display = needsValue ? 'block' : 'none';
        el.meritHelp.style.display = v === 'merit' ? 'block' : 'none';
        el.meritNote.style.display = 'none';
        el.value.value = '';
        if (v === 'merit') {
            el.valueLabel.textContent = 'Your Marks % (most recent qualifying result)';
            el.value.max = '100'; el.value.placeholder = 'e.g. 85';
        } else if (v === 'percent') {
            el.valueLabel.textContent = 'Discount Percentage (%)';
            el.value.max = '100'; el.value.placeholder = 'e.g. 10';
        } else if (v === 'fixed') {
            el.valueLabel.textContent = 'Discount Amount per Semester / Month (Rs.)';
            el.value.removeAttribute('max'); el.value.placeholder = 'e.g. 5000';
        }
        calculate();
    }

    // Returns {pct, fixed, label} describing the selected discount on the tuition fee
    function getDiscount() {
        var v = el.scholarship.value;
        var raw = el.value.value;
        var val = parseFloat(raw) || 0;
        if (v === 'merit') {
            if (raw === '') { el.meritNote.style.display = 'none'; return null; }
            var marks = Math.max(0, Math.min(val, 100));
            var pct = getMeritPercent(marks);
            if (pct > 0) {
                el.meritNote.textContent = marks + '% marks qualifies for a ' + pct + '% Merit Scholarship on tuition.';
                el.meritNote.className = 'fc-merit-note ok';
            } else {
                el.meritNote.textContent = (MERIT_MIN !== null ? 'Minimum ' + MERIT_MIN + '% marks required' : 'Not eligible') + ' for a Merit Scholarship — not eligible at this percentage.';
                el.meritNote.className = 'fc-merit-note bad';
            }
            el.meritNote.style.display = 'block';
            return pct > 0 ? { pct: pct, label: 'Merit Scholarship (' + pct + '%)' } : null;
        }
        if (v === 'percent') {
            var p = Math.max(0, Math.min(val, 100));
            return p > 0 ? { pct: p, label: 'Discount (' + p + '%)' } : null;
        }
        if (v === 'fixed') {
            return val > 0 ? { fixed: val, label: 'Discount (fixed)' } : null;
        }
        if (v.charAt(0) === 's') {
            var s = SCHOLARSHIPS.find(function(x) { return 's' + x.id === v; });
            return s ? { pct: s.pct, label: s.title + ' (' + s.pct + '%)' } : null;
        }
        return null;
    }

    function calculate() {
        var c = currentCourse();
        renderProgInfo(c);
        var discount = getDiscount();

        if (!c) {
            el.results.innerHTML = '<div class="fc-empty-msg"><i class="fas fa-calculator"></i>Select a program to see its fee breakdown.</div>';
            return;
        }

        var A = c.admission_fee, I = c.initial_fee, S = c.semester_fee, T = c.total_fee;
        if (!has(A) && !has(I) && !has(S) && !has(T)) {
            el.results.innerHTML = '<div class="fc-empty-msg"><i class="fas fa-circle-info"></i>Fee details for <strong>' + esc(c.name) + '</strong> haven\'t been published yet.<br>Please <a href="contact.php">contact the admission office</a> for current fees.</div>';
            return;
        }

        var isMonth = c.fee_period === 'Month';
        var unit = isMonth ? 'month' : 'semester';
        var tuitionLabel = isMonth ? 'Monthly Fee' : 'Semester Fee';
        var n = periodsFromDuration(c.duration, c.fee_period);

        // Discount applies to the recurring tuition fee only
        var cut = 0;
        if (discount && has(S)) cut = discount.fixed !== undefined ? Math.min(discount.fixed, S) : S * discount.pct / 100;
        var Snet = has(S) ? S - cut : null;

        var na = '<span class="fc-na">Not set</span>';
        var h = '';

        // 1. Fee components
        h += '<div class="fc-group-title">Fee components (from college records)</div>';
        h += '<div class="fc-breakdown-row"><span>Admission Fee<small>One-time, at admission</small></span><span>' + (has(A) ? fmt(A) : na) + '</span></div>';
        h += '<div class="fc-breakdown-row"><span>Initial Fee<small>First payment — covers the 1st ' + unit + '</small></span><span>' + (has(I) ? fmt(I) : na) + '</span></div>';
        h += '<div class="fc-breakdown-row"><span>' + tuitionLabel + ' (tuition)<small>Per ' + unit + (has(I) ? ', from the 2nd ' + unit + ' onward' : '') + '</small></span><span>' + (has(S) ? fmt(S) : na) + '</span></div>';
        if (has(T)) {
            h += '<div class="fc-breakdown-row"><span>Total Program Fee<small>Full program, as listed by the college</small></span><span>' + fmt(T) + '</span></div>';
        }
        if (cut > 0) {
            h += '<div class="fc-breakdown-row fc-discount"><span>' + esc(discount.label) + '<small>Applied to the ' + tuitionLabel.toLowerCase() + ' only</small></span><span>&minus; ' + fmt(cut) + ' / ' + unit + '</span></div>';
        } else if (discount && !has(S)) {
            h += '<div class="fc-breakdown-row fc-discount"><span>' + esc(discount.label) + '<small>Cannot be estimated — the ' + tuitionLabel.toLowerCase() + ' isn\'t set for this program</small></span><span>—</span></div>';
        }

        // 2. Estimated payable
        h += '<div class="fc-pay-grid">';
        var atAdmission, atAdmSub;
        if (has(I)) {
            atAdmission = (A || 0) + I;
            atAdmSub = (has(A) ? 'Admission Fee + ' : '') + 'Initial Fee (covers 1st ' + unit + ').' + (cut > 0 ? ' Scholarship applies from the next ' + unit + '.' : '');
        } else if (has(S)) {
            atAdmission = (A || 0) + Snet;
            atAdmSub = (has(A) ? 'Admission Fee + ' : '') + 'first ' + unit + '\'s fee' + (cut > 0 ? ' after scholarship' : '') + '.';
        } else {
            atAdmission = A || 0;
            atAdmSub = 'Admission Fee only — other components not set.';
        }
        h += '<div class="fc-total-box"><div class="fc-total-label">Estimated payable at admission</div><div class="fc-total-amount">' + fmt(atAdmission) + '</div><div class="fc-total-sub">' + atAdmSub + '</div></div>';

        if (has(S)) {
            h += '<div class="fc-total-box fc-alt"><div class="fc-total-label">Then, per ' + unit + '</div><div class="fc-total-amount">' + fmt(Snet) + (cut > 0 ? '<s>' + fmt(S) + '</s>' : '') + '</div><div class="fc-total-sub">' + tuitionLabel + (cut > 0 ? ' after ' + esc(discount.label) : '') + (has(I) ? ', from the 2nd ' + unit : '') + '.</div></div>';
        }
        h += '</div>';

        // 3. Full program estimate after scholarship — anchored on the college's listed total
        if (has(T) && cut > 0) {
            var paidPeriods = (n !== null) ? (has(I) ? n - 1 : n) : null;
            h += '<div class="fc-program-total">';
            h += '<div class="fc-pt-row"><span>Total Program Fee (listed)</span><strong>' + fmt(T) + '</strong></div>';
            if (cut > 0 && paidPeriods !== null && paidPeriods > 0) {
                var savings = cut * paidPeriods;
                h += '<div class="fc-pt-row fc-pt-save"><span>Scholarship savings (' + paidPeriods + ' ' + unit + 's &times; ' + fmt(cut) + ')</span><strong>&minus; ' + fmt(savings) + '</strong></div>';
                h += '<div class="fc-pt-row fc-pt-final"><span>Estimated total payable</span><strong>' + fmt(Math.max(T - savings, 0)) + '</strong></div>';
                h += '<div style="font-size:11px;color:var(--text-light);margin-top:4px;">Based on ' + esc(c.duration) + ' &asymp; ' + n + ' ' + unit + 's, assuming the scholarship is maintained every ' + unit + '.</div>';
            } else {
                h += '<div style="font-size:11px;color:var(--text-light);margin-top:4px;">Total savings depend on the number of ' + unit + 's and on keeping the scholarship — confirm with the admission office.</div>';
            }
            h += '</div>';
        }

        // 4. Included vs not included
        var inc = [];
        if (has(A)) inc.push('Admission Fee');
        if (has(I)) inc.push('Initial Fee');
        if (has(S)) inc.push(tuitionLabel + ' (tuition)');
        h += '<div class="fc-inc-grid">';
        h += '<div class="fc-inc-box fc-inc-yes"><h4><i class="fas fa-circle-check"></i> Included in this estimate</h4><ul>';
        inc.forEach(function(x) { h += '<li><i class="fas fa-check"></i>' + x + '</li>'; });
        if (cut > 0) h += '<li><i class="fas fa-check"></i>' + esc(discount.label) + ' (tuition only)</li>';
        h += '</ul></div>';
        h += '<div class="fc-inc-box fc-inc-no"><h4><i class="fas fa-circle-xmark"></i> Not included</h4><ul>';
        ['Examination Fee', 'Verification Fee', 'University Charges'].forEach(function(x) { h += '<li><i class="fas fa-xmark"></i>' + x + '</li>'; });
        h += '</ul><p>Charged separately by the college or the affiliated university when applicable.</p></div>';
        h += '</div>';

        h += '<p class="fc-disclaimer"><i class="fas fa-circle-info"></i> This is an estimate for planning only. Fees are subject to revision by the college, and scholarships are subject to eligibility, seat availability and verification of original documents.</p>';
        h += '<div class="fc-actions"><a class="fc-btn" href="admission.php?course=' + c.id + '"><i class="fas fa-graduation-cap"></i> Apply for this Program</a><a class="fc-btn fc-btn-outline" href="javascript:window.print()"><i class="fas fa-print"></i> Print Estimate</a></div>';

        el.results.innerHTML = h;
    }

    el.program.addEventListener('change', calculate);
    el.scholarship.addEventListener('change', onScholarshipChange);
    el.value.addEventListener('input', calculate);

    // ?merit=86 (from the Scholarships page calculator) pre-fills the Merit Scholarship
    var meritParam = new URLSearchParams(window.location.search).get('merit');
    if (meritParam !== null && meritParam !== '' && !isNaN(parseFloat(meritParam)) && el.scholarship.querySelector('option[value="merit"]')) {
        el.scholarship.value = 'merit';
        onScholarshipChange();
        el.value.value = Math.max(0, Math.min(parseFloat(meritParam), 100));
    }
    calculate();
})();
</script>

<?php include 'includes/footer.php'; ?>
