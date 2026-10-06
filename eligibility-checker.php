<?php
require_once 'includes/config.php';
$page_title = 'Eligibility Checker';
$page_description = 'Check your eligibility for admission to Bahawal College of Health Sciences programs in seconds with our free online eligibility checker.';

// Real, database-backed programs
$courses = [];
$cr = mysqli_query($conn, "SELECT id, name FROM courses WHERE status='active' ORDER BY display_order ASC, name ASC");
if ($cr) {
    while ($row = mysqli_fetch_assoc($cr)) {
        $courses[] = $row;
    }
}

// Real, admin-configured eligibility rules, grouped by course
$rules_by_course = [];
$rr = mysqli_query($conn, "SELECT * FROM eligibility_rules WHERE status='active' ORDER BY course_id ASC, display_order ASC, id ASC");
if ($rr) {
    while ($row = mysqli_fetch_assoc($rr)) {
        $cid = (int) $row['course_id'];
        if (!isset($rules_by_course[$cid])) $rules_by_course[$cid] = [];
        $rules_by_course[$cid][] = [
            'qualification'  => $row['qualification'],
            'min_percentage' => (float) $row['min_percentage'],
            'notes'          => $row['notes'],
        ];
    }
}

$courses_json = json_encode(array_map(function ($c) {
    return ['id' => (int) $c['id'], 'name' => $c['name']];
}, $courses), JSON_UNESCAPED_SLASHES | JSON_HEX_TAG | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_HEX_AMP);

$rules_json = json_encode($rules_by_course, JSON_UNESCAPED_SLASHES | JSON_HEX_TAG | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_HEX_AMP);
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
                    <label>Program *</label>
                    <select id="elgProgram">
                        <option value="">— Select a Program —</option>
                        <?php foreach ($courses as $c): ?>
                        <option value="<?php echo $c['id']; ?>"><?php echo htmlspecialchars($c['name']); ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>

                <div class="elg-field">
                    <label>Previous Qualification *</label>
                    <select id="elgQualification" disabled>
                        <option value="">— Select a Program First —</option>
                    </select>
                    <small id="elgQualNote"></small>
                </div>

                <div class="elg-field">
                    <label>Marks / Percentage Obtained (%) *</label>
                    <input type="number" id="elgPercentage" min="0" max="100" step="0.01" placeholder="e.g., 72" disabled>
                </div>

                <button type="button" class="elg-btn" id="elgCheckBtn" disabled><i class="fas fa-magnifying-glass"></i> Check Eligibility</button>
            </div>

            <!-- Result -->
            <div class="elg-card">
                <h3><i class="fas fa-circle-check"></i> Result</h3>

                <div id="elgResults">
                    <div class="elg-empty-msg">
                        <i class="fas fa-clipboard-check"></i>
                        Fill in your details and click "Check Eligibility" to see your result.
                    </div>
                </div>

                <div class="elg-disclaimer">
                    <i class="fas fa-circle-info"></i>
                    <span>This is a quick self-check based on our recorded minimum criteria — it does not guarantee admission. Final eligibility is confirmed by the admissions office, and entry test / interview requirements may still apply.</span>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
(function() {
    var COURSES = <?php echo $courses_json; ?>;
    var RULES = <?php echo $rules_json; ?>;

    var el = {
        program: document.getElementById('elgProgram'),
        qualification: document.getElementById('elgQualification'),
        qualNote: document.getElementById('elgQualNote'),
        percentage: document.getElementById('elgPercentage'),
        checkBtn: document.getElementById('elgCheckBtn'),
        results: document.getElementById('elgResults'),
    };

    function escapeHtml(str) {
        var d = document.createElement('div');
        d.textContent = str;
        return d.innerHTML;
    }

    el.program.addEventListener('change', function() {
        var courseId = el.program.value;
        var rules = RULES[courseId] || [];

        el.qualification.innerHTML = '';
        if (!courseId) {
            el.qualification.innerHTML = '<option value="">— Select a Program First —</option>';
            el.qualification.disabled = true;
            el.percentage.disabled = true;
            el.checkBtn.disabled = true;
            el.qualNote.textContent = '';
            return;
        }

        if (rules.length === 0) {
            el.qualification.innerHTML = '<option value="">— Not Configured Yet —</option>';
            el.qualification.disabled = true;
            el.qualNote.textContent = 'Eligibility rules for this program haven\'t been added yet — you can still check, and we\'ll mark it as "Review Required".';
        } else {
            var opts = '<option value="">— Select Your Qualification —</option>';
            rules.forEach(function(r, i) {
                opts += '<option value="' + i + '">' + escapeHtml(r.qualification) + '</option>';
            });
            opts += '<option value="other">Other / Not Listed</option>';
            el.qualification.innerHTML = opts;
            el.qualification.disabled = false;
            el.qualNote.textContent = '';
        }
        el.percentage.disabled = false;
        el.checkBtn.disabled = false;
        el.results.innerHTML = '<div class="elg-empty-msg"><i class="fas fa-clipboard-check"></i>Fill in your details and click "Check Eligibility" to see your result.</div>';
    });

    function renderResult(type, title, explain, notes) {
        var icons = { eligible: 'fa-circle-check', 'not-eligible': 'fa-circle-xmark', review: 'fa-hourglass-half' };
        var subs = { eligible: 'ELIGIBLE', 'not-eligible': 'NOT ELIGIBLE', review: 'REVIEW REQUIRED' };
        var html = '<div class="elg-result-box ' + type + '">';
        html += '<div class="elg-result-head"><div class="elg-result-icon"><i class="fas ' + icons[type] + '"></i></div>';
        html += '<div><div class="elg-result-title">' + title + '</div><div class="elg-result-sub">' + subs[type] + '</div></div></div>';
        html += '<p class="elg-result-explain">' + explain + '</p>';
        if (notes) html += '<div class="elg-result-notes"><i class="fas fa-note-sticky"></i> ' + escapeHtml(notes) + '</div>';
        html += '</div>';
        el.results.innerHTML = html;
    }

    el.checkBtn.addEventListener('click', function() {
        var courseId = el.program.value;
        var courseName = '';
        COURSES.forEach(function(c) { if (String(c.id) === courseId) courseName = c.name; });
        var rules = RULES[courseId] || [];
        var qualValue = el.qualification.value;
        var percentage = parseFloat(el.percentage.value);

        if (!courseId) {
            renderResult('review', 'Select a Program', 'Please select a program to check your eligibility.', '');
            return;
        }
        if (isNaN(percentage) || percentage < 0 || percentage > 100) {
            renderResult('review', 'Enter Your Percentage', 'Please enter a valid marks percentage between 0 and 100.', '');
            return;
        }

        if (rules.length === 0) {
            renderResult('review', 'Review Required', 'Eligibility rules for <strong>' + escapeHtml(courseName) + '</strong> haven\'t been finalized in our records yet. Please contact our admissions office directly for the exact requirements for this program.', '');
            return;
        }

        if (qualValue === '') {
            renderResult('review', 'Select Your Qualification', 'Please select your previous qualification to check eligibility.', '');
            return;
        }

        if (qualValue === 'other') {
            renderResult('review', 'Review Required', 'The qualification you hold isn\'t in our configured eligibility list for <strong>' + escapeHtml(courseName) + '</strong>. Please contact our admissions office to confirm whether it qualifies.', '');
            return;
        }

        var rule = rules[parseInt(qualValue, 10)];
        if (!rule) {
            renderResult('review', 'Review Required', 'We couldn\'t match your selection. Please contact our admissions office to confirm your eligibility.', '');
            return;
        }

        if (percentage >= rule.min_percentage) {
            renderResult(
                'eligible',
                'You Are Eligible',
                'You meet the minimum requirement of <strong>' + rule.min_percentage + '%</strong> in <strong>' + escapeHtml(rule.qualification) + '</strong> for <strong>' + escapeHtml(courseName) + '</strong> with your ' + percentage + '%.',
                rule.notes
            );
        } else {
            renderResult(
                'not-eligible',
                'Not Eligible',
                '<strong>' + escapeHtml(courseName) + '</strong> requires a minimum of <strong>' + rule.min_percentage + '%</strong> in <strong>' + escapeHtml(rule.qualification) + '</strong>. You entered ' + percentage + '%, which is below this requirement.',
                rule.notes
            );
        }
    });
})();
</script>

<?php include 'includes/footer.php'; ?>
