<?php
require_once 'includes/config.php';
$page_title = 'Fee Calculator';
$page_description = 'Estimate your program fees and scholarship discounts at Bahawal College of Health Sciences with our free online fee calculator.';

// Only real, database-backed course data — no fabricated numbers.
$courses = [];
$cr = mysqli_query($conn, "SELECT id, name, admission_fee, initial_fee, semester_fee, fee_period, total_fee FROM courses WHERE status='active' ORDER BY display_order ASC, name ASC");
if ($cr) {
    while ($row = mysqli_fetch_assoc($cr)) {
        $courses[] = $row;
    }
}

// Embed as JSON for the client-side calculator — null stays null (never coerced to 0)
$courses_json = json_encode(array_map(function ($c) {
    return [
        'id'            => (int) $c['id'],
        'name'          => $c['name'],
        'admission_fee' => $c['admission_fee'] !== null ? (float) $c['admission_fee'] : null,
        'initial_fee'   => $c['initial_fee'] !== null ? (float) $c['initial_fee'] : null,
        'semester_fee'  => $c['semester_fee'] !== null ? (float) $c['semester_fee'] : null,
        'fee_period'    => $c['fee_period'] ?: 'Semester',
        'total_fee'     => $c['total_fee'] !== null ? (float) $c['total_fee'] : null,
    ];
}, $courses), JSON_UNESCAPED_SLASHES | JSON_HEX_TAG | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_HEX_AMP);

// Merit Scholarship tiers — same source of truth as the Scholarships page (includes/settings_helper.php)
$merit_tiers = getMeritScholarshipTiers();
$merit_tiers_json = json_encode(array_map(function ($t) {
    return ['min' => (float) $t['min'], 'max' => $t['max'] !== null ? (float) $t['max'] : null, 'pct' => (float) $t['pct']];
}, $merit_tiers), JSON_UNESCAPED_SLASHES | JSON_HEX_TAG | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_HEX_AMP);
// Human-readable summary built from the same tiers, so it can never drift out of
// sync with the admin-managed percentages (AdminCP > Scholarships > Merit Tiers).
$merit_tiers_text = implode(', ', array_map(function ($t) {
    return $t['range'] . ' = ' . $t['pct'] . '%';
}, $merit_tiers));
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
.fc-layout { display:grid; grid-template-columns:1fr 1fr; gap:28px; align-items:start; }
@media (max-width:900px) { .fc-layout { grid-template-columns:1fr; } }

.fc-card {
    background:#fff; border-radius:18px; border:1px solid rgba(23,22,91,0.1);
    padding:26px 26px 28px;
}
.fc-card h3 {
    font-size:15px; font-weight:800; color:var(--primary-color);
    margin:0 0 18px; display:flex; align-items:center; gap:9px;
}

.fc-field { margin-bottom:16px; }
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
.fc-field small { display:block; margin-top:5px; font-size:11px; color:var(--text-light); }
.fc-row { display:grid; grid-template-columns:1fr 1fr; gap:14px; }
.fc-note-unavailable { font-size:11px; color:#DC2626; margin-top:4px; display:none; }
.fc-merit-note { font-size:11px; margin-top:4px; display:none; font-weight:600; line-height:1.5; }
.fc-merit-note.ok { color:#16A34A; }
.fc-merit-note.bad { color:#DC2626; }

/* --- Breakdown --- */
.fc-breakdown-row {
    display:flex; justify-content:space-between; align-items:center;
    padding:9px 0; font-size:13px; color:var(--text-light);
    border-bottom:1px solid rgba(23,22,91,0.07);
}
.fc-breakdown-row span:last-child { color:var(--text-dark); font-weight:700; }
.fc-breakdown-row.fc-discount span:last-child { color:#16A34A; }
.fc-breakdown-row.fc-subtotal {
    margin-top:6px; padding-top:12px;
    border-top:1px dashed rgba(23,22,91,0.2); border-bottom:none;
    font-size:14px; font-weight:700; color:var(--text-dark);
}
.fc-total-box {
    margin-top:16px; padding:18px 20px; border-radius:14px;
    background:linear-gradient(135deg,var(--primary-color),#0D1048);
    color:#fff;
}
.fc-total-box .fc-total-label { font-size:11.5px; opacity:0.75; letter-spacing:0.5px; text-transform:uppercase; margin-bottom:4px; }
.fc-total-box .fc-total-amount { font-size:26px; font-weight:800; }
.fc-total-sub { font-size:11.5px; opacity:0.7; margin-top:4px; }

.fc-secondary-total {
    margin-top:14px; padding:13px 16px; border-radius:12px;
    background:#EAF7FB; border:1px solid rgba(9,169,217,0.25);
    display:flex; justify-content:space-between; align-items:center;
}
.fc-secondary-total .fc-label { font-size:12px; color:var(--text-dark); font-weight:600; }
.fc-secondary-total .fc-amount { font-size:16px; color:var(--primary-color); font-weight:800; }

.fc-charges-note {
    display:flex; align-items:flex-start; gap:9px;
    margin-top:18px; padding:12px 14px; border-radius:10px;
    background:#fdf2f2; border:1px solid rgba(220,38,38,0.2);
    font-size:11.5px; color:#991b1b; line-height:1.6;
}
.fc-charges-note i { margin-top:2px; flex-shrink:0; color:#DC2626; }

.fc-empty-msg {
    text-align:center; padding:30px 10px; color:var(--text-light); font-size:13px;
}
.fc-empty-msg i { font-size:32px; opacity:0.3; display:block; margin-bottom:12px; }
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
        <p>Select a program to see its real fee breakdown, apply a scholarship or discount, and get an estimated total — using actual figures from our records.</p>
    </div>
</section>

<!-- CALCULATOR -->
<section class="fc-section">
    <div class="container">
        <div class="fc-layout">

            <!-- Inputs -->
            <div class="fc-card">
                <h3><i class="fas fa-sliders"></i> Enter Details</h3>

                <div class="fc-field">
                    <label>Program *</label>
                    <select id="fcProgram">
                        <option value="">— Select a Program —</option>
                        <?php foreach ($courses as $c): ?>
                        <option value="<?php echo $c['id']; ?>"><?php echo htmlspecialchars($c['name']); ?></option>
                        <?php endforeach; ?>
                    </select>
                    <small>Fee fields below fill in automatically once a program is selected. You can still adjust them.</small>
                </div>

                <div class="fc-row">
                    <div class="fc-field">
                        <label>Admission Fee (Rs.)</label>
                        <input type="number" id="fcAdmissionFee" min="0" step="0.01" placeholder="0">
                        <div class="fc-note-unavailable" id="fcAdmissionUnavailable">Not set for this program yet</div>
                    </div>
                    <div class="fc-field">
                        <label>Initial Fee (Rs.)</label>
                        <input type="number" id="fcInitialFee" min="0" step="0.01" placeholder="0">
                        <div class="fc-note-unavailable" id="fcInitialUnavailable">Not set for this program yet</div>
                    </div>
                </div>

                <div class="fc-row">
                    <div class="fc-field">
                        <label id="fcSemesterLabel">Semester / Monthly Fee (Rs.)</label>
                        <input type="number" id="fcSemesterFee" min="0" step="0.01" placeholder="0">
                        <div class="fc-note-unavailable" id="fcSemesterUnavailable">Not set for this program yet</div>
                    </div>
                    <div class="fc-field">
                        <label>Fee Period</label>
                        <select id="fcFeePeriod">
                            <option value="Semester">Per Semester</option>
                            <option value="Month">Per Month</option>
                        </select>
                    </div>
                </div>

                <div class="fc-row">
                    <div class="fc-field">
                        <label>Scholarship / Discount Type</label>
                        <select id="fcDiscountType">
                            <option value="none">No Discount</option>
                            <option value="percent">Percentage (%)</option>
                            <option value="fixed">Fixed Amount (Rs.)</option>
                            <option value="merit">Merit Scholarship (by Marks %)</option>
                        </select>
                    </div>
                    <div class="fc-field">
                        <label id="fcDiscountValueLabel">Discount Value</label>
                        <input type="number" id="fcDiscountValue" min="0" step="0.01" placeholder="0" disabled>
                        <div class="fc-merit-note" id="fcMeritNote"></div>
                    </div>
                </div>
                <div class="fc-field" id="fcMeritLinkWrap" style="display:none;margin-bottom:0;">
                    <small>Scholarship tiers: <?php echo htmlspecialchars($merit_tiers_text); ?>. See the full <a href="scholarships.php" target="_blank" style="color:var(--accent-color);font-weight:700;">Scholarships page</a> for details.</small>
                </div>
            </div>

            <!-- Breakdown -->
            <div class="fc-card">
                <h3><i class="fas fa-file-invoice-dollar"></i> Fee Breakdown</h3>

                <div id="fcResults">
                    <div class="fc-empty-msg">
                        <i class="fas fa-calculator"></i>
                        Select a program (or enter amounts manually) to see your fee breakdown.
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

    var el = {
        program: document.getElementById('fcProgram'),
        admissionFee: document.getElementById('fcAdmissionFee'),
        initialFee: document.getElementById('fcInitialFee'),
        semesterFee: document.getElementById('fcSemesterFee'),
        feePeriod: document.getElementById('fcFeePeriod'),
        semesterLabel: document.getElementById('fcSemesterLabel'),
        discountType: document.getElementById('fcDiscountType'),
        discountValue: document.getElementById('fcDiscountValue'),
        discountValueLabel: document.getElementById('fcDiscountValueLabel'),
        meritNote: document.getElementById('fcMeritNote'),
        meritLinkWrap: document.getElementById('fcMeritLinkWrap'),
        results: document.getElementById('fcResults'),
        admissionUnavailable: document.getElementById('fcAdmissionUnavailable'),
        initialUnavailable: document.getElementById('fcInitialUnavailable'),
        semesterUnavailable: document.getElementById('fcSemesterUnavailable'),
    };

    function getMeritPercent(marks) {
        for (var i = 0; i < MERIT_TIERS.length; i++) {
            var t = MERIT_TIERS[i];
            if (marks >= t.min && (t.max === null || marks <= t.max)) return t.pct;
        }
        return 0;
    }

    function fmt(n) {
        return 'Rs. ' + Math.round(n).toLocaleString('en-PK');
    }

    function setFieldFromDb(input, unavailableEl, value) {
        if (value === null || value === undefined) {
            input.value = '';
            unavailableEl.style.display = 'block';
        } else {
            input.value = value;
            unavailableEl.style.display = 'none';
        }
    }

    el.program.addEventListener('change', function() {
        var course = COURSES.find(function(c) { return String(c.id) === el.program.value; });
        if (!course) {
            calculate();
            return;
        }
        setFieldFromDb(el.admissionFee, el.admissionUnavailable, course.admission_fee);
        setFieldFromDb(el.initialFee, el.initialUnavailable, course.initial_fee);
        setFieldFromDb(el.semesterFee, el.semesterUnavailable, course.semester_fee);
        el.feePeriod.value = course.fee_period || 'Semester';
        el.semesterLabel.textContent = 'Semester / Monthly Fee (Rs.)';
        el._totalFee = course.total_fee;
        calculate();
    });

    el.discountType.addEventListener('change', function() {
        el.discountValue.disabled = el.discountType.value === 'none';
        if (el.discountType.value === 'none') el.discountValue.value = '';
        if (el.discountType.value === 'merit') {
            el.discountValueLabel.textContent = 'Marks % Obtained';
            el.discountValue.setAttribute('max', '100');
            el.discountValue.placeholder = 'e.g. 85';
            el.meritLinkWrap.style.display = 'block';
        } else {
            el.discountValueLabel.textContent = 'Discount Value';
            el.discountValue.removeAttribute('max');
            el.discountValue.placeholder = '0';
            el.meritNote.style.display = 'none';
            el.meritLinkWrap.style.display = 'none';
        }
        calculate();
    });

    var unavailablePairs = [
        [el.admissionFee, el.admissionUnavailable],
        [el.initialFee, el.initialUnavailable],
        [el.semesterFee, el.semesterUnavailable],
    ];
    unavailablePairs.forEach(function(pair) {
        pair[0].addEventListener('input', function() {
            // Typing a value manually means it's no longer "unavailable"
            if (pair[0].value !== '') pair[1].style.display = 'none';
            calculate();
        });
    });

    [el.feePeriod, el.discountValue].forEach(function(input) {
        input.addEventListener('input', calculate);
        input.addEventListener('change', calculate);
    });

    function calculate() {
        var admissionKnown = el.admissionFee.value !== '';
        var initialKnown = el.initialFee.value !== '';
        var semesterKnown = el.semesterFee.value !== '';
        var admission = admissionKnown ? (parseFloat(el.admissionFee.value) || 0) : 0;
        var initial = initialKnown ? (parseFloat(el.initialFee.value) || 0) : 0;
        var semester = semesterKnown ? (parseFloat(el.semesterFee.value) || 0) : 0;
        var anyKnown = admissionKnown || initialKnown || semesterKnown;
        var allKnown = admissionKnown && initialKnown && semesterKnown;
        var period = el.feePeriod.value;
        var subtotal = admission + initial + semester;

        if (!anyKnown && !el.program.value) {
            el.results.innerHTML = '<div class="fc-empty-msg"><i class="fas fa-calculator"></i>Select a program (or enter amounts manually) to see your fee breakdown.</div>';
            return;
        }

        if (el.program.value && !anyKnown) {
            el.results.innerHTML = '<div class="fc-empty-msg"><i class="fas fa-circle-info"></i>Fee details for this program haven\'t been added to our records yet. Please contact admissions for exact figures.</div>';
            return;
        }

        var discountType = el.discountType.value;
        var discountValue = parseFloat(el.discountValue.value) || 0;
        var discountAmount = 0;
        var discountLabel = 'Scholarship / Discount';
        var meritPct = 0;
        if (discountType === 'percent') {
            discountAmount = subtotal * (Math.min(discountValue, 100) / 100);
        } else if (discountType === 'fixed') {
            discountAmount = Math.min(discountValue, subtotal);
        } else if (discountType === 'merit') {
            var marks = Math.min(discountValue, 100);
            meritPct = getMeritPercent(marks);
            discountAmount = subtotal * (meritPct / 100);
            discountLabel = 'Merit Scholarship (' + meritPct + '%)';
            if (el.discountValue.value !== '') {
                if (meritPct > 0) {
                    el.meritNote.textContent = marks + '% marks qualifies for a ' + meritPct + '% Merit Scholarship.';
                    el.meritNote.className = 'fc-merit-note ok';
                } else {
                    el.meritNote.textContent = 'Minimum 70% marks required for a Merit Scholarship — not eligible at this percentage.';
                    el.meritNote.className = 'fc-merit-note bad';
                }
                el.meritNote.style.display = 'block';
            } else {
                el.meritNote.style.display = 'none';
            }
        }

        var estimatedToEnroll = subtotal - discountAmount;

        var html = '';
        html += '<div class="fc-breakdown-row"><span>Admission Fee</span><span>' + (admissionKnown ? fmt(admission) : 'N/A') + '</span></div>';
        html += '<div class="fc-breakdown-row"><span>Initial Fee</span><span>' + (initialKnown ? fmt(initial) : 'N/A') + '</span></div>';
        html += '<div class="fc-breakdown-row"><span>Fee per ' + period + '</span><span>' + (semesterKnown ? fmt(semester) : 'N/A') + '</span></div>';
        html += '<div class="fc-breakdown-row fc-subtotal"><span>Subtotal' + (!allKnown ? ' (partial)' : '') + '</span><span>' + fmt(subtotal) + '</span></div>';
        if (!allKnown) {
            html += '<div class="fc-note-unavailable" style="display:block;margin:-4px 0 4px;">Some fee figures aren\'t in our records yet — this subtotal only reflects what\'s available.</div>';
        }
        if (discountAmount > 0) {
            html += '<div class="fc-breakdown-row fc-discount"><span>' + discountLabel + '</span><span>&minus; ' + fmt(discountAmount) + '</span></div>';
        }

        html += '<div class="fc-total-box">';
        html += '<div class="fc-total-label">Estimated Payment to Enroll</div>';
        html += '<div class="fc-total-amount">' + fmt(estimatedToEnroll) + '</div>';
        html += '<div class="fc-total-sub">Admission Fee + Initial Fee + first ' + period + ' payment' + (discountAmount > 0 ? ', after discount' : '') + '</div>';
        html += '</div>';

        var totalFee = el._totalFee;
        if (totalFee !== null && totalFee !== undefined) {
            var totalDiscountAmount = discountAmount;
            if (discountType === 'percent') {
                totalDiscountAmount = totalFee * (Math.min(discountValue, 100) / 100);
            } else if (discountType === 'merit') {
                totalDiscountAmount = totalFee * (meritPct / 100);
            }
            var totalAfterDiscount = totalFee - totalDiscountAmount;
            html += '<div class="fc-secondary-total"><span class="fc-label">Full Program Fee (all ' + period + 's)' + (totalDiscountAmount > 0 ? ', after discount' : '') + '</span><span class="fc-amount">' + fmt(totalAfterDiscount) + '</span></div>';
        }

        html += '<div class="fc-charges-note"><i class="fas fa-circle-exclamation"></i><span>Examination Fee, Verification Fee &amp; University Charges are <strong>Not Included</strong> in this estimate — these are billed separately as applicable.</span></div>';

        el.results.innerHTML = html;
    }
})();
</script>

<?php include 'includes/footer.php'; ?>
