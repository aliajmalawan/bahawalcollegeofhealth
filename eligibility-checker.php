<?php
require_once 'includes/config.php';
$page_title = 'Eligibility Checker';
$page_description = 'Check your eligibility for admission to Bahawal College of Health Sciences programs in seconds with our free online eligibility checker.';

// Real, database-backed programs (with their published eligibility text, if any)
$courses = [];
$cr = mysqli_query($conn, "SELECT id, name, eligibility, duration, affiliation FROM courses WHERE status='active' ORDER BY display_order ASC, name ASC");
if ($cr) {
    while ($row = mysqli_fetch_assoc($cr)) {
        $courses[] = $row;
    }
}

// Optional rule columns from add_eligibility_rule_fields.sql
$elg_has_year = dbColumnExists($conn, 'eligibility_rules', 'max_years_since_passing');
$elg_has_reqs = dbColumnExists($conn, 'eligibility_rules', 'requirements');

// Real, admin-configured eligibility rules, grouped by course
$rules_by_course = [];
$rr = mysqli_query($conn, "SELECT * FROM eligibility_rules WHERE status='active' ORDER BY course_id ASC, display_order ASC, id ASC");
if ($rr) {
    while ($row = mysqli_fetch_assoc($rr)) {
        $cid = (int) $row['course_id'];
        if (!isset($rules_by_course[$cid])) $rules_by_course[$cid] = [];
        $years = ($elg_has_year && $row['max_years_since_passing'] !== null) ? (int) $row['max_years_since_passing'] : null;
        $reqs  = $elg_has_reqs ? array_values(array_filter(array_map('trim', preg_split('/\R/', (string) $row['requirements'])))) : [];
        $rules_by_course[$cid][] = [
            'qualification'  => $row['qualification'],
            'min_percentage' => (float) $row['min_percentage'],
            'notes'          => $row['notes'],
            'max_years'      => $years,
            'requirements'   => $reqs,
        ];
    }
}

$json_flags = JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE | JSON_HEX_TAG | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_HEX_AMP;
$courses_json = json_encode(array_map(function ($c) {
    return ['id' => (int) $c['id'], 'name' => $c['name'], 'eligibility' => $c['eligibility'] ?: ''];
}, $courses), $json_flags);
$rules_json = json_encode((object) $rules_by_course, $json_flags);

$preselect = isset($_GET['course']) ? intval($_GET['course']) : 0;
?>
<?php include 'includes/header.php'; ?>

<style>
/* ===== ELIGIBILITY CHECKER PAGE ===== */

/* --- Hero --- */
.elg-hero {
    background: linear-gradient(135deg,#0D1048 0%,#17165B 55%,#0D1048 100%);
    padding: 62px 0 50px;
    position: relative; overflow: hidden;
}
.elg-hero::after {
    content:'';
    position:absolute; bottom:-1px; left:0; right:0;
    height:40px;
    background:#F5F9FC;
    clip-path:ellipse(55% 100% at 50% 100%);
}
.elg-breadcrumb {
    display:flex; align-items:center; gap:8px;
    font-size:12px; color:rgba(255,255,255,0.5); margin-bottom:18px;
    position:relative; z-index:1;
}
.elg-breadcrumb a { color:rgba(255,255,255,0.6); text-decoration:none; }
.elg-breadcrumb a:hover { color:var(--accent-color); }
.elg-hero-badge {
    display:inline-flex; align-items:center; gap:7px;
    background:rgba(9,169,217,0.14); border:1px solid rgba(9,169,217,0.35);
    color:var(--accent-color); padding:6px 18px; border-radius:50px;
    font-size:10.5px; font-weight:700; letter-spacing:2px;
    text-transform:uppercase; margin-bottom:16px;
    position:relative; z-index:1;
}
.elg-hero h1 {
    font-size:38px; font-weight:800; color:#fff;
    margin:0 0 12px; line-height:1.15;
    position:relative; z-index:1;
}
.elg-hero h1 span { color:var(--accent-color); }
.elg-hero p {
    color:rgba(255,255,255,0.72); font-size:15px; margin:0; max-width:580px; line-height:1.7;
    position:relative; z-index:1;
}

/* --- Layout --- */
.elg-section { padding:52px 0 64px; background:#F5F9FC; }
.elg-layout { display:grid; grid-template-columns:1fr 1fr; gap:28px; align-items:start; }
@media (max-width:900px) { .elg-layout { grid-template-columns:1fr; } }

.elg-card {
    background:#fff; border-radius:18px; border:1px solid rgba(23,22,91,0.1);
    padding:26px 26px 28px;
}
.elg-card h3 {
    font-size:15px; font-weight:800; color:var(--primary-color);
    margin:0 0 18px; display:flex; align-items:center; gap:9px;
}

.elg-field { margin-bottom:16px; }
.elg-field label { display:block; font-size:12.5px; font-weight:700; color:var(--text-dark); margin-bottom:6px; }
.elg-field select, .elg-field input {
    width:100%; padding:11px 13px; font-family:var(--font); font-size:13.5px;
    color:var(--text-dark); border:1px solid #d7dde0; border-radius:9px;
    background:#f9fafb; transition:var(--transition);
}
.elg-field select:focus, .elg-field input:focus {
    outline:none; border-color:var(--primary-color); background:#fff;
    box-shadow:0 0 0 3px rgba(23,22,91,0.1);
}
.elg-field small { display:block; margin-top:5px; font-size:11px; color:var(--text-light); }
.elg-field select:disabled, .elg-field input:disabled { background:#f1f3f5; color:var(--text-light); cursor:not-allowed; }

.elg-btn {
    width:100%; padding:13px 16px; border:none; border-radius:10px;
    background:linear-gradient(135deg,var(--primary-color),#0D1048); color:#fff;
    font-family:var(--font); font-size:14px; font-weight:700; cursor:pointer;
    display:flex; align-items:center; justify-content:center; gap:9px;
    transition:var(--transition);
}
.elg-btn:hover { opacity:0.92; transform:translateY(-1px); }

/* --- Result --- */
.elg-empty-msg { text-align:center; padding:30px 10px; color:var(--text-light); font-size:13px; }
.elg-empty-msg i { font-size:32px; opacity:0.3; display:block; margin-bottom:12px; }

.elg-result-box { border-radius:14px; padding:22px 22px 20px; }
.elg-result-box.eligible      { background:rgba(22,163,74,0.08); border:1px solid rgba(22,163,74,0.3); }
.elg-result-box.not-eligible  { background:rgba(220,38,38,0.08); border:1px solid rgba(220,38,38,0.3); }
.elg-result-box.review        { background:rgba(245,158,11,0.08); border:1px solid rgba(245,158,11,0.3); }

.elg-result-head { display:flex; align-items:center; gap:12px; margin-bottom:12px; }
.elg-result-icon { width:44px; height:44px; border-radius:50%; display:flex; align-items:center; justify-content:center; flex-shrink:0; font-size:19px; color:#fff; }
.elg-result-box.eligible .elg-result-icon     { background:#16A34A; }
.elg-result-box.not-eligible .elg-result-icon { background:#DC2626; }
.elg-result-box.review .elg-result-icon       { background:#F59E0B; }
.elg-result-title { font-size:18px; font-weight:800; }
.elg-result-box.eligible .elg-result-title     { color:#16A34A; }
.elg-result-box.not-eligible .elg-result-title { color:#DC2626; }
.elg-result-box.review .elg-result-title       { color:#B45309; }
.elg-result-sub { font-size:11.5px; color:var(--text-light); }
.elg-result-explain { font-size:13px; color:var(--text-dark); line-height:1.7; margin:0; }
.elg-result-notes { margin-top:10px; padding-top:10px; border-top:1px dashed rgba(23,22,91,0.15); font-size:12px; color:var(--text-light); }

.elg-disclaimer {
    display:flex; align-items:flex-start; gap:9px;
    margin-top:18px; padding:12px 14px; border-radius:10px;
    background:#EAF7FB; border:1px solid rgba(9,169,217,0.25);
    font-size:11.5px; color:var(--text-dark); line-height:1.6;
}
.elg-disclaimer i { margin-top:2px; flex-shrink:0; color:var(--primary-color); }

/* --- Criteria panel, marks mode, requirements --- */
.elg-criteria { display:none; margin:-4px 0 16px; padding:12px 14px; border-radius:10px; background:#F5F9FC; border:1px solid rgba(23,22,91,0.08); font-size:12px; color:var(--text-dark); line-height:1.55; }
.elg-criteria-title { font-size:10.5px; font-weight:700; letter-spacing:1px; text-transform:uppercase; color:var(--primary-color); margin-bottom:6px; }
.elg-criteria ul { list-style:none; margin:0; padding:0; }
.elg-criteria li { display:flex; gap:7px; padding:2px 0; }
.elg-criteria li i { color:var(--primary-color); font-size:10px; margin-top:4px; flex-shrink:0; }
.elg-criteria .elg-crit-meta { color:var(--text-light); }
.elg-toggle { display:inline-flex; background:#f1f3f5; border-radius:8px; padding:3px; margin-bottom:8px; }
.elg-toggle button { border:none; background:transparent; padding:6px 12px; border-radius:6px; font-size:12px; font-weight:700; color:var(--text-light); cursor:pointer; font-family:inherit; }
.elg-toggle button.active { background:#fff; color:var(--primary-color); box-shadow:0 1px 4px rgba(0,0,0,0.08); }
.elg-marks-row { display:grid; grid-template-columns:1fr auto 1fr; gap:8px; align-items:center; }
.elg-marks-row span { color:var(--text-light); font-weight:700; }
.elg-calc-pct { font-size:11.5px; color:var(--primary-color); font-weight:700; margin-top:5px; min-height:1em; }
.elg-check { display:flex; align-items:flex-start; gap:8px; font-size:12.5px; color:var(--text-dark); cursor:pointer; margin:2px 0 16px; line-height:1.5; }
.elg-check input { width:auto !important; margin-top:3px; }
.elg-req { padding:10px 12px; border:1px solid rgba(23,22,91,0.1); border-radius:10px; margin-bottom:8px; }
.elg-req-q { font-size:12.5px; font-weight:600; color:var(--text-dark); margin-bottom:7px; line-height:1.5; }
.elg-req-opts { display:flex; gap:6px; flex-wrap:wrap; }
.elg-req-opts label { position:relative; }
.elg-req-opts input { position:absolute; opacity:0; pointer-events:none; }
.elg-req-opts span { display:inline-block; padding:5px 14px; border-radius:50px; border:1px solid #d7dde0; font-size:12px; font-weight:700; color:var(--text-light); cursor:pointer; }
.elg-req-opts input:checked + span { background:var(--primary-color); border-color:var(--primary-color); color:#fff; }
.elg-req-opts input:focus-visible + span { box-shadow:0 0 0 3px rgba(23,22,91,0.25); }
.elg-checks { list-style:none; margin:12px 0 0; padding:12px 0 0; border-top:1px dashed rgba(23,22,91,0.15); }
.elg-checks li { display:flex; gap:8px; font-size:12.5px; padding:3px 0; color:var(--text-dark); line-height:1.5; }
.elg-checks li i { margin-top:3px; flex-shrink:0; width:14px; text-align:center; }
.elg-checks .ok i { color:#16A34A; }
.elg-checks .bad i { color:#DC2626; }
.elg-checks .warn i { color:#F59E0B; }
.elg-next { display:flex; gap:10px; flex-wrap:wrap; margin-top:16px; }
.elg-next a { display:inline-flex; align-items:center; gap:7px; padding:9px 16px; border-radius:9px; font-size:12.5px; font-weight:700; text-decoration:none; background:var(--primary-color); color:#fff; }
.elg-next a.elg-outline { background:#fff; color:var(--primary-color); border:1px solid rgba(23,22,91,0.25); }
@media (max-width:600px) { .elg-hero h1 { font-size:28px; } .elg-card { padding:20px 16px 22px; } }
</style>

<!-- HERO -->
<section class="elg-hero">
    <div class="container" style="position:relative;z-index:2;">
        <div class="elg-breadcrumb">
            <a href="index.php"><i class="fas fa-home" style="font-size:11px;"></i> Home</a>
            <span><i class="fas fa-chevron-right" style="font-size:9px;"></i></span>
            <span>Eligibility Checker</span>
        </div>
        <div class="elg-hero-badge">
            <i class="fas fa-clipboard-check"></i> Quick Self-Check
        </div>
        <h1>Eligibility <span>Checker</span></h1>
        <p>Select a program, enter your previous qualification and marks, and get an instant indication of whether you meet our admission requirements.</p>
    </div>
</section>

<!-- CHECKER -->
<section class="elg-section">
    <div class="container">
        <div class="elg-layout">

            <!-- Inputs -->
            <div class="elg-card">
                <h3><i class="fas fa-sliders"></i> Your Details</h3>

                <div class="elg-field">
                    <label for="elgProgram">Desired Program *</label>
                    <select id="elgProgram">
                        <option value="">— Select a Program —</option>
                        <?php foreach ($courses as $c): ?>
                        <option value="<?php echo (int) $c['id']; ?>" <?php echo $preselect === (int) $c['id'] ? 'selected' : ''; ?>><?php echo htmlspecialchars($c['name']); ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="elg-criteria" id="elgCriteria"></div>

                <div class="elg-field">
                    <label for="elgQualification">Previous Qualification *</label>
                    <select id="elgQualification" disabled>
                        <option value="">— Select a Program First —</option>
                    </select>
                    <small id="elgQualNote"></small>
                </div>

                <label class="elg-check"><input type="checkbox" id="elgAwaited" disabled> My result has not been announced yet (result awaited)</label>

                <div class="elg-field" id="elgMarksWrap">
                    <label>Marks Obtained *</label>
                    <div class="elg-toggle" role="group" aria-label="How to enter marks">
                        <button type="button" class="active" data-mode="pct">Percentage</button>
                        <button type="button" data-mode="marks">Obtained / Total</button>
                    </div>
                    <div id="elgModePct">
                        <input type="number" id="elgPercentage" min="0" max="100" step="0.01" placeholder="e.g., 72" disabled aria-label="Percentage obtained">
                    </div>
                    <div id="elgModeMarks" style="display:none;">
                        <div class="elg-marks-row">
                            <input type="number" id="elgObtained" min="0" step="1" placeholder="Obtained, e.g. 820" disabled aria-label="Marks obtained">
                            <span>/</span>
                            <input type="number" id="elgTotal" min="1" step="1" placeholder="Total, e.g. 1100" disabled aria-label="Total marks">
                        </div>
                        <div class="elg-calc-pct" id="elgCalcPct"></div>
                    </div>
                </div>

                <div class="elg-field" id="elgYearWrap" style="display:none;">
                    <label for="elgYear">Passing Year *</label>
                    <input type="number" id="elgYear" min="1970" max="<?php echo date('Y'); ?>" step="1" placeholder="e.g., <?php echo date('Y'); ?>">
                    <small id="elgYearNote"></small>
                </div>

                <div id="elgReqWrap" style="display:none;">
                    <div class="elg-field" style="margin-bottom:6px;"><label>Program Requirements *</label></div>
                    <div id="elgReqList"></div>
                </div>

                <button type="button" class="elg-btn" id="elgCheckBtn" disabled style="margin-top:8px;"><i class="fas fa-magnifying-glass"></i> Check Eligibility</button>
            </div>

            <!-- Result -->
            <div class="elg-card">
                <h3><i class="fas fa-circle-check"></i> Result</h3>

                <div id="elgResults" aria-live="polite">
                    <div class="elg-empty-msg">
                        <i class="fas fa-clipboard-check"></i>
                        Fill in your details and click "Check Eligibility" to see your result.
                    </div>
                </div>

                <div class="elg-disclaimer">
                    <i class="fas fa-circle-info"></i>
                    <span>This is a quick self-check based on our recorded minimum criteria — it does not guarantee admission. Final eligibility is confirmed by the admissions office after verification of original documents, and entry test / interview requirements may still apply.</span>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
(function() {
    var COURSES = <?php echo $courses_json; ?>;
    var RULES = <?php echo $rules_json; ?>;
    var THIS_YEAR = <?php echo (int) date('Y'); ?>;

    var $ = function(id) { return document.getElementById(id); };
    var el = {
        program: $('elgProgram'), criteria: $('elgCriteria'),
        qualification: $('elgQualification'), qualNote: $('elgQualNote'),
        awaited: $('elgAwaited'), marksWrap: $('elgMarksWrap'),
        modePct: $('elgModePct'), modeMarks: $('elgModeMarks'),
        percentage: $('elgPercentage'), obtained: $('elgObtained'), total: $('elgTotal'), calcPct: $('elgCalcPct'),
        yearWrap: $('elgYearWrap'), year: $('elgYear'), yearNote: $('elgYearNote'),
        reqWrap: $('elgReqWrap'), reqList: $('elgReqList'),
        checkBtn: $('elgCheckBtn'), results: $('elgResults')
    };
    var marksMode = 'pct';
    var EMPTY = '<div class="elg-empty-msg"><i class="fas fa-clipboard-check"></i>Fill in your details and click "Check Eligibility" to see your result.</div>';

    function esc(str) {
        return String(str == null ? '' : str).replace(/[&<>"']/g, function(c) { return {'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]; });
    }
    function course() { return COURSES.find(function(c) { return String(c.id) === el.program.value; }) || null; }
    function rules() { return RULES[el.program.value] || []; }
    function rule() { var v = el.qualification.value; return (v === '' || v === 'other') ? null : (rules()[parseInt(v, 10)] || null); }
    function yearsText(n) { return n === 0 ? 'passed this year' : 'passed within the last ' + n + ' year' + (n === 1 ? '' : 's'); }

    // Published criteria for the selected program — what the student is checked against
    function renderCriteria() {
        var c = course(), rs = rules();
        if (!c) { el.criteria.style.display = 'none'; return; }
        var h = '<div class="elg-criteria-title">Eligibility criteria for this program</div>';
        if (rs.length) {
            h += '<ul>';
            rs.forEach(function(r) {
                var meta = [];
                meta.push('minimum ' + r.min_percentage + '%');
                if (r.max_years !== null) meta.push(yearsText(r.max_years));
                if (r.requirements.length) meta.push(r.requirements.length + ' additional requirement' + (r.requirements.length > 1 ? 's' : ''));
                h += '<li><i class="fas fa-check"></i><span><strong>' + esc(r.qualification) + '</strong> <span class="elg-crit-meta">— ' + meta.join(', ') + '</span></span></li>';
            });
            h += '</ul>';
        } else if (c.eligibility) {
            h += '<div>' + esc(c.eligibility) + '</div><div class="elg-crit-meta" style="margin-top:4px;">Detailed criteria are not configured for the self-check yet — your result will be marked for review.</div>';
        } else {
            h += '<div class="elg-crit-meta">Eligibility criteria for this program have not been published yet — please contact the admission office.</div>';
        }
        el.criteria.innerHTML = h;
        el.criteria.style.display = 'block';
    }

    function setInputsEnabled(on) {
        [el.awaited, el.percentage, el.obtained, el.total].forEach(function(i) { i.disabled = !on; });
        el.checkBtn.disabled = !on;
    }

    function onProgramChange() {
        var rs = rules();
        renderCriteria();
        el.results.innerHTML = EMPTY;
        if (!el.program.value) {
            el.qualification.innerHTML = '<option value="">— Select a Program First —</option>';
            el.qualification.disabled = true;
            el.qualNote.textContent = '';
            setInputsEnabled(false);
            onRuleChange();
            return;
        }
        if (rs.length === 0) {
            el.qualification.innerHTML = '<option value="">— Not Configured Yet —</option>';
            el.qualification.disabled = true;
            el.qualNote.textContent = 'Eligibility rules for this program haven\'t been added yet — you can still check, and we\'ll mark it as "Requires Review".';
        } else {
            var opts = '<option value="">— Select Your Qualification —</option>';
            rs.forEach(function(r, i) { opts += '<option value="' + i + '">' + esc(r.qualification) + '</option>'; });
            opts += '<option value="other">Other / Not Listed</option>';
            el.qualification.innerHTML = opts;
            el.qualification.disabled = false;
            el.qualNote.textContent = '';
        }
        setInputsEnabled(true);
        onRuleChange();
    }

    // Passing year and program-specific requirements appear only when the chosen rule needs them
    function onRuleChange() {
        var r = rule();
        if (r && r.max_years !== null) {
            el.yearWrap.style.display = 'block';
            el.yearNote.textContent = 'Required: ' + yearsText(r.max_years) + ' (' + (THIS_YEAR - r.max_years) + ' or later).';
        } else {
            el.yearWrap.style.display = 'none';
            el.year.value = '';
        }
        if (r && r.requirements.length) {
            var h = '';
            r.requirements.forEach(function(q, i) {
                h += '<div class="elg-req" role="radiogroup" aria-label="' + esc(q) + '"><div class="elg-req-q">' + esc(q) + '</div><div class="elg-req-opts">';
                [['yes', 'Yes'], ['no', 'No'], ['unsure', 'Not sure']].forEach(function(o) {
                    h += '<label><input type="radio" name="elgReq' + i + '" value="' + o[0] + '"><span>' + o[1] + '</span></label>';
                });
                h += '</div></div>';
            });
            el.reqList.innerHTML = h;
            el.reqWrap.style.display = 'block';
        } else {
            el.reqList.innerHTML = '';
            el.reqWrap.style.display = 'none';
        }
        el.results.innerHTML = EMPTY;
    }

    function setMode(mode) {
        marksMode = mode;
        document.querySelectorAll('.elg-toggle button').forEach(function(b) { b.classList.toggle('active', b.dataset.mode === mode); });
        el.modePct.style.display = mode === 'pct' ? 'block' : 'none';
        el.modeMarks.style.display = mode === 'marks' ? 'block' : 'none';
        updateCalcPct();
    }

    // Returns {value} or {error}
    function readPercentage() {
        if (marksMode === 'pct') {
            if (el.percentage.value === '') return { error: 'Please enter your marks percentage.' };
            var p = parseFloat(el.percentage.value);
            if (isNaN(p) || p < 0 || p > 100) return { error: 'Please enter a valid percentage between 0 and 100.' };
            return { value: p };
        }
        var o = parseFloat(el.obtained.value), t = parseFloat(el.total.value);
        if (el.obtained.value === '' || el.total.value === '') return { error: 'Please enter both obtained and total marks.' };
        if (isNaN(o) || isNaN(t) || t <= 0 || o < 0 || o > t) return { error: 'Obtained marks must be between 0 and the total marks.' };
        return { value: Math.round(o / t * 10000) / 100 };
    }

    function updateCalcPct() {
        if (marksMode !== 'marks') return;
        var r = readPercentage();
        el.calcPct.textContent = r.value !== undefined ? '= ' + r.value + '%' : '';
    }

    function renderResult(type, title, explain, checks, notes) {
        var icons = { eligible: 'fa-circle-check', 'not-eligible': 'fa-circle-xmark', review: 'fa-hourglass-half' };
        var subs = { eligible: 'ELIGIBLE', 'not-eligible': 'NOT ELIGIBLE', review: 'REQUIRES FURTHER REVIEW' };
        var h = '<div class="elg-result-box ' + type + '">';
        h += '<div class="elg-result-head"><div class="elg-result-icon"><i class="fas ' + icons[type] + '"></i></div>';
        h += '<div><div class="elg-result-title">' + title + '</div><div class="elg-result-sub">' + subs[type] + '</div></div></div>';
        h += '<p class="elg-result-explain">' + explain + '</p>';
        if (checks && checks.length) {
            var ic = { ok: 'fa-check', bad: 'fa-xmark', warn: 'fa-question' };
            h += '<ul class="elg-checks">';
            checks.forEach(function(c) { h += '<li class="' + c[0] + '"><i class="fas ' + ic[c[0]] + '"></i><span>' + c[1] + '</span></li>'; });
            h += '</ul>';
        }
        if (notes) h += '<div class="elg-result-notes"><i class="fas fa-note-sticky"></i> ' + esc(notes) + '</div>';
        h += '</div>';
        var c = course();
        if (c && type !== 'not-eligible') {
            h += '<div class="elg-next"><a href="admission.php?course=' + c.id + '"><i class="fas fa-graduation-cap"></i> ' + (type === 'eligible' ? 'Apply Now' : 'Apply / Ask Admissions') + '</a>';
            h += '<a class="elg-outline" href="course.php?id=' + c.id + '"><i class="fas fa-circle-info"></i> Program Details</a></div>';
        } else if (c) {
            h += '<div class="elg-next"><a class="elg-outline" href="courses.php"><i class="fas fa-layer-group"></i> Explore Other Programs</a><a class="elg-outline" href="contact.php"><i class="fas fa-phone"></i> Contact Admissions</a></div>';
        }
        el.results.innerHTML = h;
        // On stacked (mobile) layouts the result sits below the form — bring it into view
        if (window.innerWidth < 900 && el.results.scrollIntoView) el.results.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }

    function check() {
        var c = course();
        if (!c) { renderResult('review', 'Select a Program', 'Please select a program to check your eligibility.'); return; }
        var rs = rules();
        var name = '<strong>' + esc(c.name) + '</strong>';
        var awaited = el.awaited.checked;

        if (rs.length === 0) {
            renderResult('review', 'Review Required', 'Detailed eligibility rules for ' + name + ' haven\'t been finalized in our records yet.' +
                (c.eligibility ? ' Published criteria: <strong>' + esc(c.eligibility) + '</strong>.' : '') +
                ' Please contact our admissions office to confirm your eligibility.');
            return;
        }
        if (el.qualification.value === '') { renderResult('review', 'Select Your Qualification', 'Please select your previous qualification to check eligibility.'); return; }
        if (el.qualification.value === 'other') {
            renderResult('review', 'Review Required', 'The qualification you hold isn\'t in our configured eligibility list for ' + name + '. Please contact our admissions office to confirm whether it qualifies.');
            return;
        }
        var r = rule();
        if (!r) { renderResult('review', 'Review Required', 'We couldn\'t match your selection. Please contact our admissions office.'); return; }

        var checks = [], fail = false, review = false;
        var pct = null;

        // Marks
        if (awaited) {
            review = true;
            checks.push(['warn', 'Result awaited — minimum required is ' + r.min_percentage + '% in ' + esc(r.qualification) + '.']);
        } else {
            var pr = readPercentage();
            if (pr.error) { renderResult('review', 'Enter Your Marks', pr.error); return; }
            pct = pr.value;
            if (pct >= r.min_percentage) checks.push(['ok', 'Marks: ' + pct + '% (minimum ' + r.min_percentage + '%)']);
            else { fail = true; checks.push(['bad', 'Marks: ' + pct + '% is below the minimum of ' + r.min_percentage + '%']); }
        }

        // Passing year
        if (r.max_years !== null) {
            var earliest = THIS_YEAR - r.max_years;
            if (awaited) {
                checks.push(['ok', 'Passing year: ' + THIS_YEAR + ' (result awaited)']);
            } else {
                var y = parseInt(el.year.value, 10);
                if (el.year.value === '' || isNaN(y)) { renderResult('review', 'Enter Your Passing Year', 'This qualification must have been ' + yearsText(r.max_years) + '. Please enter your passing year.'); return; }
                if (y > THIS_YEAR || y < 1970) { renderResult('review', 'Check Your Passing Year', 'Please enter a valid passing year between 1970 and ' + THIS_YEAR + '.'); return; }
                if (y >= earliest) checks.push(['ok', 'Passing year: ' + y + ' (' + earliest + ' or later required)']);
                else { fail = true; checks.push(['bad', 'Passing year: ' + y + ' — must be ' + earliest + ' or later (' + yearsText(r.max_years) + ')']); }
            }
        }

        // Program-specific requirements
        for (var i = 0; i < r.requirements.length; i++) {
            var picked = document.querySelector('input[name="elgReq' + i + '"]:checked');
            var q = esc(r.requirements[i]);
            if (!picked) { renderResult('review', 'Answer All Requirements', 'Please answer every program requirement (Yes, No or Not sure).'); return; }
            if (picked.value === 'yes') checks.push(['ok', q]);
            else if (picked.value === 'no') { fail = true; checks.push(['bad', q + ' — not met']); }
            else { review = true; checks.push(['warn', q + ' — not sure']); }
        }

        if (fail) {
            renderResult('not-eligible', 'Not Eligible', name + ' requires ' + esc(r.qualification) + ' with a minimum of <strong>' + r.min_percentage + '%</strong>' +
                (r.max_years !== null ? ', ' + yearsText(r.max_years) : '') + '. Based on your answers, you don\'t meet one or more criteria below.', checks, r.notes);
        } else if (review) {
            renderResult('review', 'You May Be Eligible', 'You may be eligible for ' + name + ', but the admissions office needs to confirm the items marked below' +
                (awaited ? ' once your result is announced' : '') + '.', checks, r.notes);
        } else {
            renderResult('eligible', 'You Are Eligible', 'You meet the recorded eligibility criteria for ' + name + ' with ' + esc(r.qualification) + '.', checks, r.notes);
        }
    }

    el.program.addEventListener('change', onProgramChange);
    el.qualification.addEventListener('change', onRuleChange);
    el.awaited.addEventListener('change', function() {
        el.marksWrap.style.opacity = el.awaited.checked ? '0.5' : '';
        [el.percentage, el.obtained, el.total].forEach(function(i) { i.disabled = el.awaited.checked || !el.program.value; });
        el.year.disabled = el.awaited.checked;
    });
    document.querySelectorAll('.elg-toggle button').forEach(function(b) { b.addEventListener('click', function() { setMode(b.dataset.mode); }); });
    [el.obtained, el.total].forEach(function(i) { i.addEventListener('input', updateCalcPct); });
    el.checkBtn.addEventListener('click', check);

    if (el.program.value) onProgramChange();
})();
</script>

<?php include 'includes/footer.php'; ?>
