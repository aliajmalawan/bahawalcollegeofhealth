<?php
/**
 * Course / program helpers shared by courses.php, course.php and index.php.
 * Fee amounts come straight from the `courses` table — blank (NULL) amounts are
 * never shown as Rs. 0; they fall back to "contact the admission office".
 */

// Charges that are never part of the quoted program fee
function getCourseExcludedCharges() {
    return ['Examination Fee', 'Verification Fee', 'University Charges'];
}

function courseHasFeeData($course) {
    foreach (['admission_fee', 'initial_fee', 'semester_fee', 'total_fee'] as $k) {
        if (isset($course[$k]) && $course[$k] !== null && $course[$k] !== '') return true;
    }
    return false;
}

function formatCourseFee($amount) {
    return 'Rs. ' . number_format((float)$amount);
}

// "Semester" -> "Semester Fee" / "per semester"; "Month" -> "Monthly Fee" / "per month"
function getCourseFeePeriodLabels($course) {
    $period = ($course['fee_period'] ?? 'Semester') === 'Month' ? 'Month' : 'Semester';
    return $period === 'Month'
        ? ['label' => 'Monthly Fee',  'per' => 'per month',    'unit' => 'month']
        : ['label' => 'Semester Fee', 'per' => 'per semester', 'unit' => 'semester'];
}

// True when the optional admission_info column has been added (add_course_admission_info.sql)
function courseAdmissionInfoColumnExists($conn) {
    return dbColumnExists($conn, 'courses', 'admission_info');
}

/**
 * Fee breakdown box. Uses the .cr-fee-* classes defined in renderCourseFeeStyles().
 * $compact = true hides the per-charge "Not Included" list in favour of a one-line note.
 */
function renderCourseFeeBox($course, $compact = true) {
    $period = getCourseFeePeriodLabels($course);
    ob_start();
    ?>
    <div class="cr-fee-box">
        <div class="cr-fee-title"><i class="fas fa-money-check-dollar"></i> Fee Structure</div>
        <?php if (courseHasFeeData($course)): ?>
            <?php if ($course['admission_fee'] !== null): ?>
            <div class="cr-fee-row"><span>Admission Fee <small>(one time)</small></span><span><?php echo formatCourseFee($course['admission_fee']); ?></span></div>
            <?php endif; ?>
            <?php if ($course['initial_fee'] !== null): ?>
            <div class="cr-fee-row"><span>Initial Fee <small>(covers 1st <?php echo $period['unit']; ?>)</small></span><span><?php echo formatCourseFee($course['initial_fee']); ?></span></div>
            <?php endif; ?>
            <?php if ($course['semester_fee'] !== null): ?>
            <div class="cr-fee-row"><span><?php echo $period['label']; ?></span><span><?php echo formatCourseFee($course['semester_fee']); ?> <small><?php echo $period['per']; ?></small></span></div>
            <?php endif; ?>
            <?php if ($course['total_fee'] !== null): ?>
            <div class="cr-fee-row cr-fee-total"><span>Total Program Fee</span><span><?php echo formatCourseFee($course['total_fee']); ?></span></div>
            <?php endif; ?>
        <?php else: ?>
            <div class="cr-fee-pending">
                <i class="fas fa-circle-info"></i>
                <span>Fee details for this program will be announced soon. Please contact the admission office for current fees.</span>
            </div>
        <?php endif; ?>

        <?php if ($compact): ?>
        <div class="cr-fee-note">
            <i class="fas fa-circle-exclamation"></i>
            <span>Examination Fee, Verification Fee &amp; University Charges are <strong>Not Included</strong></span>
        </div>
        <?php else: ?>
        <div class="cr-fee-excluded">
            <div class="cr-fee-excluded-title"><i class="fas fa-circle-exclamation"></i> Additional charges (Not Included in the above fee)</div>
            <?php foreach (getCourseExcludedCharges() as $charge): ?>
            <div class="cr-fee-row cr-fee-ex-row"><span><?php echo $charge; ?></span><span class="cr-not-inc">Not Included</span></div>
            <?php endforeach; ?>
            <p class="cr-fee-ex-help">These are charged separately by the college or the affiliated university at the applicable time.</p>
        </div>
        <?php endif; ?>
    </div>
    <?php
    return ob_get_clean();
}

function renderCourseFeeStyles() {
    return <<<CSS
.cr-fee-box {
    background:#F5F9FC; border:1px solid rgba(23,22,91,0.1);
    border-radius:12px; padding:12px 14px; margin-top:2px;
}
.cr-fee-title {
    font-size:11px; font-weight:700; letter-spacing:1px; text-transform:uppercase;
    color:var(--primary-color); margin-bottom:6px; display:flex; align-items:center; gap:6px;
}
.cr-fee-row {
    display:flex; justify-content:space-between; align-items:center; gap:10px;
    font-size:12.5px; color:var(--text-light);
    padding:4px 0;
}
.cr-fee-row small { font-size:10.5px; color:var(--text-light); font-weight:500; }
.cr-fee-row span:last-child { color:var(--text-dark); font-weight:600; text-align:right; }
.cr-fee-row.cr-fee-total {
    border-top:1px dashed rgba(23,22,91,0.18);
    margin-top:4px; padding-top:8px;
    font-size:13.5px; font-weight:700; color:var(--primary-color);
}
.cr-fee-row.cr-fee-total span:last-child { color:var(--primary-color); font-weight:800; }
.cr-fee-pending {
    display:flex; align-items:flex-start; gap:7px;
    font-size:12px; color:var(--text-dark); line-height:1.55;
}
.cr-fee-pending i { color:var(--primary-color); margin-top:3px; flex-shrink:0; }
.cr-fee-note {
    display:flex; align-items:flex-start; gap:6px;
    font-size:10.5px; color:#DC2626; margin-top:8px;
    padding-top:8px; border-top:1px solid rgba(23,22,91,0.08);
    line-height:1.5;
}
.cr-fee-note i { margin-top:2px; flex-shrink:0; }
.cr-fee-excluded { margin-top:10px; padding-top:10px; border-top:1px solid rgba(23,22,91,0.1); }
.cr-fee-excluded-title { font-size:12px; font-weight:700; color:#DC2626; margin-bottom:4px; display:flex; gap:6px; align-items:center; }
.cr-fee-row.cr-fee-ex-row span:first-child { color:var(--text-dark); }
.cr-not-inc {
    background:rgba(220,38,38,0.08); border:1px solid rgba(220,38,38,0.25);
    color:#DC2626 !important; font-size:10.5px; font-weight:700 !important;
    padding:2px 9px; border-radius:50px; text-transform:uppercase; letter-spacing:0.5px;
}
.cr-fee-ex-help { font-size:11px; color:var(--text-light); margin:6px 0 0; line-height:1.5; }
CSS;
}
