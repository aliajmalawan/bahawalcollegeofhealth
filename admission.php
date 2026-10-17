<?php
require_once 'includes/config.php';
require_once 'includes/admission_helper.php';
$page_title = 'Admission';
$page_description = 'Apply for admission to Bahawal College of Health Sciences — view eligibility criteria, required documents and the online application form.';

$v2 = admissionFormV2Ready($conn);           // extra fields + multi-document uploads available
$doc_types = getAdmissionDocTypes();
$sessions = getAdmissionSessions();

// Server upload limits — per-file sizes are capped to what PHP will actually accept
function admIniBytes($v) {
    $v = trim((string) $v); $n = (float) $v; $u = strtolower(substr($v, -1));
    return (int) ($u === 'g' ? $n * 1073741824 : ($u === 'm' ? $n * 1048576 : ($u === 'k' ? $n * 1024 : $n)));
}
$adm_max_file  = admIniBytes(ini_get('upload_max_filesize')) ?: 2097152;
$adm_max_total = admIniBytes(ini_get('post_max_size')) ?: 8388608;
$adm_max_count = (int) ini_get('max_file_uploads') ?: 20;
foreach ($doc_types as $k => $slot) { $doc_types[$k]['size'] = min($slot['size'], $adm_max_file); }

// Active programs (with department) for the form and the client-side program info panel
$form_courses = [];
$fcr = mysqli_query($conn, "SELECT id, name, department, duration, affiliation FROM courses WHERE status='active' ORDER BY display_order ASC, name ASC");
if ($fcr) { while ($row = mysqli_fetch_assoc($fcr)) { $form_courses[(int) $row['id']] = $row; } }

$success_message = '';
$error_message   = '';
$application_number = '';
$errors = [];        // list shown at the top
$field_errors = [];  // field name => message, shown under each field
$confirmation = null;

// Sticky form values — repopulated on validation failure so the applicant doesn't retype everything
$f = [
    'student_name' => '', 'father_name' => '', 'gender' => '', 'date_of_birth' => '', 'cnic_bform' => '',
    'phone' => '', 'guardian_phone' => '', 'email' => '', 'address' => '',
    'qualification' => '', 'board_university' => '', 'passing_year' => '', 'marks_percentage' => '', 'result_awaited' => '',
    'course_id' => '', 'admission_session' => '', 'message' => '', 'declaration' => '',
];

function admFail(&$errors, &$field_errors, $field, $msg) {
    $errors[] = $msg;
    if ($field !== null && !isset($field_errors[$field])) $field_errors[$field] = $msg;
}

// Confirmation after the Post/Redirect/Get hop — refreshing it never resubmits the application
if ($_SERVER['REQUEST_METHOD'] !== 'POST' && isset($_GET['submitted']) && !empty($_SESSION['adm_confirmation'])) {
    $confirmation = $_SESSION['adm_confirmation'];
    $application_number = $confirmation['number'];
    $success_message = 'Your admission application has been submitted successfully!';
}

// A request larger than post_max_size arrives with $_POST and $_FILES empty
$adm_too_large = $_SERVER['REQUEST_METHOD'] == 'POST' && empty($_POST) && (int) ($_SERVER['CONTENT_LENGTH'] ?? 0) > 0;
if ($adm_too_large) {
    $error_message = 'Your uploaded files are too large in total (limit ' . round($adm_max_total / 1048576) . 'MB). Please upload smaller or fewer files and submit again.';
}

if ($_SERVER['REQUEST_METHOD'] == 'POST' && !$adm_too_large) {
    foreach ($f as $key => $default) {
        $f[$key] = trim((string) ($_POST[$key] ?? ''));
    }
    $result_awaited = $v2 && $f['result_awaited'] === '1';
    $current_year = (int) date('Y');

    // ---- Validation (server-side; do not trust the browser) ----
    if ($f['student_name'] === '') admFail($errors, $field_errors, 'student_name', 'Student name is required.');
    elseif (mb_strlen($f['student_name']) > 100 || !preg_match("/^[\p{L} .'-]+$/u", $f['student_name'])) admFail($errors, $field_errors, 'student_name', 'Student name should contain letters only (max 100 characters).');

    if ($f['father_name'] === '') admFail($errors, $field_errors, 'father_name', 'Father / guardian name is required.');
    elseif (mb_strlen($f['father_name']) > 100 || !preg_match("/^[\p{L} .'-]+$/u", $f['father_name'])) admFail($errors, $field_errors, 'father_name', 'Father / guardian name should contain letters only (max 100 characters).');

    $dob_sql = 'NULL';
    if ($v2) {
        if (!in_array($f['gender'], ['male', 'female'], true)) admFail($errors, $field_errors, 'gender', 'Please select gender.');

        $dob = DateTime::createFromFormat('!Y-m-d', $f['date_of_birth']);
        if ($f['date_of_birth'] === '') {
            admFail($errors, $field_errors, 'date_of_birth', 'Date of birth is required.');
        } elseif (!$dob || $dob->format('Y-m-d') !== $f['date_of_birth']) {
            admFail($errors, $field_errors, 'date_of_birth', 'Please enter a valid date of birth.');
        } else {
            $age = $dob->diff(new DateTime('today'))->y;
            if ($dob > new DateTime('today') || $age < 10 || $age > 70) {
                admFail($errors, $field_errors, 'date_of_birth', 'Please check your date of birth.');
            } else {
                $dob_sql = "'" . $dob->format('Y-m-d') . "'";
            }
        }
    }

    $cnic_digits = preg_replace('/\D/', '', $f['cnic_bform']);
    if ($f['cnic_bform'] === '') {
        admFail($errors, $field_errors, 'cnic_bform', 'CNIC / B-Form number is required.');
    } elseif (strlen($cnic_digits) !== 13) {
        admFail($errors, $field_errors, 'cnic_bform', 'CNIC / B-Form must be a valid 13-digit number (e.g., 12345-1234567-1).');
    } else {
        $f['cnic_bform'] = substr($cnic_digits, 0, 5) . '-' . substr($cnic_digits, 5, 7) . '-' . substr($cnic_digits, 12, 1);
    }

    $phone_digits = preg_replace('/\D/', '', $f['phone']);
    if ($f['phone'] === '') {
        admFail($errors, $field_errors, 'phone', 'Contact number is required.');
    } elseif (strlen($phone_digits) < 10 || strlen($phone_digits) > 12) {
        admFail($errors, $field_errors, 'phone', 'Please enter a valid contact number, e.g. 03001234567.');
    }
    if ($v2 && $f['guardian_phone'] !== '') {
        $gp = preg_replace('/\D/', '', $f['guardian_phone']);
        if (strlen($gp) < 10 || strlen($gp) > 12) admFail($errors, $field_errors, 'guardian_phone', 'Please enter a valid guardian contact number, or leave it blank.');
    }

    if ($f['email'] !== '' && !filter_var($f['email'], FILTER_VALIDATE_EMAIL)) {
        admFail($errors, $field_errors, 'email', 'Please enter a valid email address, or leave it blank.');
    }

    if ($f['address'] === '') admFail($errors, $field_errors, 'address', 'Residential address is required.');
    elseif (mb_strlen($f['address']) < 10) admFail($errors, $field_errors, 'address', 'Please enter your complete address.');

    $course_id = intval($f['course_id']);
    $course_row = $form_courses[$course_id] ?? null;
    if (!$course_row) admFail($errors, $field_errors, 'course_id', 'Please select a valid program.');

    if ($v2) {
        if ($f['admission_session'] === '') admFail($errors, $field_errors, 'admission_session', 'Please select the admission session.');
        elseif (!in_array($f['admission_session'], $sessions, true)) admFail($errors, $field_errors, 'admission_session', 'Please select a valid admission session.');
    }

    if ($f['qualification'] === '') admFail($errors, $field_errors, 'qualification', 'Previous qualification is required.');
    if ($v2 && $f['board_university'] === '') admFail($errors, $field_errors, 'board_university', 'Board / institution is required.');

    // Marks and passing year are required unless the result is still awaited
    if ($f['marks_percentage'] === '') {
        if ($v2 && !$result_awaited) admFail($errors, $field_errors, 'marks_percentage', 'Marks / percentage is required (or tick "Result awaited").');
    } elseif (!is_numeric($f['marks_percentage']) || $f['marks_percentage'] < 0 || $f['marks_percentage'] > 100) {
        admFail($errors, $field_errors, 'marks_percentage', 'Marks / percentage must be a number between 0 and 100.');
    }
    if ($f['passing_year'] === '') {
        if ($v2 && !$result_awaited) admFail($errors, $field_errors, 'passing_year', 'Passing year is required (or tick "Result awaited").');
    } elseif (!preg_match('/^\d{4}$/', $f['passing_year']) || (int) $f['passing_year'] < 1970 || (int) $f['passing_year'] > $current_year + 1) {
        admFail($errors, $field_errors, 'passing_year', 'Please enter a valid passing year.');
    }

    if ($v2 && $f['declaration'] !== '1') admFail($errors, $field_errors, 'declaration', 'Please confirm that the information provided is correct.');

    // Same CNIC already has an open application for this program
    if ($course_row && strlen($cnic_digits) === 13) {
        $dup = mysqli_query($conn, "SELECT id FROM admissions WHERE course_id = '" . (int) $course_id . "' AND status = 'pending'
                                    AND REPLACE(REPLACE(cnic_bform, '-', ''), ' ', '') = '" . mysqli_real_escape_string($conn, $cnic_digits) . "' LIMIT 1");
        if ($dup && mysqli_num_rows($dup) > 0) {
            admFail($errors, $field_errors, 'cnic_bform', 'An application with this CNIC / B-Form for ' . $course_row['name'] . ' is already under review. Please contact the admission office instead of applying again.');
        }
    }

    // ---- Documents: validate everything first, store only once the whole form is valid ----
    $pending_files = []; // [type, file, mime, ext]
    $document_path = ''; // legacy single-document column (pre-migration form)
    if ($v2) {
        foreach ($doc_types as $type => $slot) {
            $files = admissionCollectFiles($slot['field']);
            if (count($files) > $slot['max']) {
                admFail($errors, $field_errors, $slot['field'], $slot['label'] . ': you can upload up to ' . $slot['max'] . ' file' . ($slot['max'] > 1 ? 's' : '') . '.');
                continue;
            }
            if ($slot['required'] && !$files) {
                admFail($errors, $field_errors, $slot['field'], $slot['label'] . ' is required.');
                continue;
            }
            foreach ($files as $file) {
                $chk = admissionValidateFile($file, $slot);
                if (!$chk['ok']) { admFail($errors, $field_errors, $slot['field'], $chk['error']); break; }
                $pending_files[] = [$type, $file, $chk['mime'], $chk['ext']];
            }
        }
    } elseif (isset($_FILES['documents']) && $_FILES['documents']['error'] !== UPLOAD_ERR_NO_FILE) {
        // Original single upload, kept until add_admission_form_fields.sql is run
        $chk = admissionValidateFile($_FILES['documents'], ['label' => 'Document', 'ext' => ['pdf', 'jpg', 'jpeg', 'png'], 'size' => min(5 * 1024 * 1024, $adm_max_file)]);
        if (!$chk['ok']) admFail($errors, $field_errors, 'documents', $chk['error']);
        else $pending_files[] = ['legacy', $_FILES['documents'], $chk['mime'], $chk['ext']];
    }

    if (empty($errors)) {
        // Store files now that the form is valid
        $stored = [];
        foreach ($pending_files as $pf) {
            $path = admissionStoreFile($pf[1], $pf[3]);
            if ($path === null) { admFail($errors, $field_errors, null, 'Could not save your documents. Please try again.'); break; }
            $stored[] = ['type' => $pf[0], 'path' => $path, 'name' => $pf[1]['name'], 'mime' => $pf[2], 'size' => (int) $pf[1]['size']];
            if ($pf[0] === 'legacy') $document_path = $path;
        }
    }

    if (empty($errors)) {
        $e = function ($v) use ($conn) { return mysqli_real_escape_string($conn, $v); };
        $passing_year     = $f['passing_year'] !== '' ? "'" . $e($f['passing_year']) . "'" : 'NULL';
        $marks_percentage = $f['marks_percentage'] !== '' ? floatval($f['marks_percentage']) : 'NULL';
        // previous_education kept as a human-readable summary for backward compatibility with existing admin views/reports
        $previous_education = trim($f['qualification'] . ($f['board_university'] !== '' ? ', ' . $f['board_university'] : '') . ($f['passing_year'] !== '' ? ', ' . $f['passing_year'] : '') . ($f['marks_percentage'] !== '' ? ' — ' . $f['marks_percentage'] . '%' : ($result_awaited ? ' — result awaited' : '')));

        $cols = "student_name,father_name,cnic_bform,phone,email,address,course_id,medium,previous_education,qualification,board_university,passing_year,marks_percentage,documents,message,status,created_at";
        $vals = "'{$e($f['student_name'])}','{$e($f['father_name'])}','{$e($f['cnic_bform'])}','{$e($f['phone'])}','{$e($f['email'])}','{$e($f['address'])}','$course_id','English','{$e($previous_education)}','{$e($f['qualification'])}','{$e($f['board_university'])}',$passing_year,$marks_percentage,'{$e($document_path)}','{$e($f['message'])}','pending',NOW()";
        if ($v2) {
            $cols .= ",gender,date_of_birth,guardian_phone,admission_session,result_awaited";
            $vals .= ",'{$e($f['gender'])}',$dob_sql,'{$e($f['guardian_phone'])}','{$e($f['admission_session'])}'," . ($result_awaited ? 1 : 0);
        }

        if (mysqli_query($conn, "INSERT INTO admissions ($cols) VALUES ($vals)")) {
            $new_id = mysqli_insert_id($conn);
            // Unique reference: derived from the auto-increment id, so it can never collide
            $application_number = 'BCHS-' . date('Y') . '-' . str_pad($new_id, 6, '0', STR_PAD_LEFT);
            mysqli_query($conn, "UPDATE admissions SET application_number = '" . $e($application_number) . "' WHERE id = $new_id");

            foreach ($stored as $s) {
                if ($s['type'] === 'legacy') continue;
                mysqli_query($conn, "INSERT INTO admission_documents (admission_id, doc_type, file_path, original_name, mime_type, file_size)
                                     VALUES ($new_id, '{$e($s['type'])}', '{$e($s['path'])}', '{$e(mb_substr($s['name'], 0, 255))}', '{$e($s['mime'])}', {$s['size']})");
            }

            // Best-effort ERP sync — safe no-op until AdminCP > ERP Integration is configured;
            // never affects the applicant-facing confirmation below.
            pushAdmissionToErp($conn, $new_id);

            $course_name = $course_row['name'];
            $session_txt = $v2 ? $f['admission_session'] : '';

            // Admin email
            $rows = [
                'Application #' => $application_number, 'Student Name' => $f['student_name'], 'Father / Guardian' => $f['father_name'],
                'CNIC / B-Form' => $f['cnic_bform'], 'Phone' => $f['phone'], 'Program' => $course_name,
            ];
            if ($session_txt !== '') $rows['Session'] = $session_txt;
            $rows['Documents'] = count($stored) . ' file(s) uploaded';
            $rows['Date'] = date('d M Y, h:i A');
            $trs = '';
            foreach ($rows as $k => $val) {
                $trs .= "<tr><td style='padding:10px;background:#f0f0f0;font-weight:bold;width:200px;'>" . htmlspecialchars($k) . "</td><td style='padding:10px;border-bottom:1px solid #ddd;'>" . htmlspecialchars($val) . "</td></tr>";
            }
            $msg_admin = "<html><body style='font-family:Arial;'>
                <div style='background:#17165B;color:#fff;padding:20px;text-align:center;'><h2>New Admission Application</h2></div>
                <div style='padding:20px;background:#F5F9FC;'><table width='100%' style='border-collapse:collapse;'>$trs</table></div>
                <div style='background:#333;color:#fff;padding:12px;text-align:center;font-size:12px;'>".SITE_NAME." — Automated Notification</div>
                </body></html>";
            $h = "MIME-Version:1.0\r\nContent-type:text/html;charset=UTF-8\r\nFrom:".SITE_NAME." <noreply@bahawalcollegeofhealth.com>" . ($f['email'] !== '' ? "\r\nReply-To:" . str_replace(["\r", "\n"], '', $f['email']) : '');
            @mail(ADMIN_EMAIL, "New Admission - ".SITE_NAME, $msg_admin, $h);

            if (!empty($f['email'])) {
                $msg_stu = "<html><body style='font-family:Arial;'>
                    <div style='background:#17165B;color:#fff;padding:24px;text-align:center;'><h2>".SITE_NAME."</h2><p>Admission Application Received</p></div>
                    <div style='padding:24px;'>
                    <p>Dear <strong>".htmlspecialchars($f['student_name'])."</strong>,</p>
                    <p>Your application for <strong>".htmlspecialchars($course_name)."</strong>" . ($session_txt !== '' ? " (session " . htmlspecialchars($session_txt) . ")" : '') . " has been received.</p>
                    <p style='background:#EAF7FB;padding:14px;border-left:4px solid #17165B;border-radius:4px;'><strong>Your Application Number:</strong> ".htmlspecialchars($application_number)."<br>Please keep this for your records — our team will contact you within 2-3 working days.</p>
                    <p>Contact: ".SITE_CONTACT." | ".ADMIN_EMAIL."</p>
                    <br><p>Best Regards,<br>Admission Team<br>".SITE_NAME."</p>
                    </div></body></html>";
                $hs = "MIME-Version:1.0\r\nContent-type:text/html;charset=UTF-8\r\nFrom:".SITE_NAME." <noreply@bahawalcollegeofhealth.com>";
                @mail($f['email'], "Application Received - ".SITE_NAME, $msg_stu, $hs);
            }

            // Post/Redirect/Get: show the confirmation on a GET so a refresh can't create a duplicate
            $doc_counts = [];
            foreach ($stored as $s) { if ($s['type'] !== 'legacy') $doc_counts[$s['type']] = ($doc_counts[$s['type']] ?? 0) + 1; }
            $_SESSION['adm_confirmation'] = [
                'number' => $application_number, 'name' => $f['student_name'], 'father' => $f['father_name'],
                'program' => $course_name, 'department' => $course_row['department'] ?? '', 'session' => $session_txt,
                'phone' => $f['phone'], 'email' => $f['email'], 'docs' => $doc_counts, 'legacy_doc' => $document_path !== '',
                'date' => date('d M Y, h:i A'),
            ];
            header('Location: admission.php?submitted=1#applyForm');
            exit;
        } else {
            // Don't leave orphaned uploads behind if the record couldn't be saved
            foreach ($stored as $s) { @unlink(__DIR__ . '/' . $s['path']); }
            $error_message = "Error submitting application. Please try again.";
        }
    } else {
        $error_message = "Please fix the following before submitting:";
    }
}

// Inline error helpers for the form markup
function admErrClass($field) { global $field_errors; return isset($field_errors[$field]) ? ' adm-invalid' : ''; }
function admErrMsg($field) { global $field_errors; return isset($field_errors[$field]) ? '<div class="adm-field-error" id="err_' . $field . '">' . htmlspecialchars($field_errors[$field]) . '</div>' : ''; }
?>
<?php include 'includes/header.php'; ?>

<style>
/* ── Admission Page ── */

/* Hero */
.adm-hero {
    position:relative; overflow:hidden;
    min-height:290px; display:flex; align-items:center;
    background:linear-gradient(130deg,rgba(13,16,72,0.86),rgba(23,22,91,0.92)),
               url('https://images.unsplash.com/photo-1427504494785-3a9ca7044f45?w=1600') center/cover no-repeat;
    padding:65px 0;
}
.adm-orb { position:absolute; border-radius:50%; pointer-events:none; filter:blur(80px); }
.adm-hero-badge {
    display:inline-flex; align-items:center; gap:7px;
    background:rgba(9,169,217,0.12); border:1px solid rgba(9,169,217,0.35);
    color:var(--accent-color); padding:6px 18px; border-radius:50px;
    font-size:10.5px; font-weight:700; letter-spacing:2px;
    text-transform:uppercase; margin-bottom:14px;
}
.adm-hero h1 { font-size:38px; font-weight:800; color:#fff; margin:0 0 10px; line-height:1.15; }
.adm-hero h1 span {
    background:linear-gradient(90deg,var(--accent-color),#18B9E8);
    -webkit-background-clip:text; -webkit-text-fill-color:transparent; background-clip:text;
}
.adm-hero p { color:rgba(255,255,255,0.72); font-size:14.5px; margin:0; max-width:480px; line-height:1.7; }
.adm-breadcrumb {
    display:flex; align-items:center; gap:8px;
    font-size:12px; color:rgba(255,255,255,0.5); margin-bottom:16px;
}
.adm-breadcrumb a { color:rgba(255,255,255,0.6); text-decoration:none; }
.adm-breadcrumb a:hover { color:var(--accent-color); }

/* ── Main Layout ── */
.adm-main { padding:55px 0 65px; background:#F5F9FC; }
.adm-layout {
    display:grid; grid-template-columns:1fr 340px;
    gap:28px; align-items:start;
}

/* ── Form Card ── */
.adm-form-card {
    background:#fff; border-radius:22px;
    border:1px solid rgba(23,22,91,0.1);
    box-shadow:0 6px 30px rgba(0,0,0,0.07);
    overflow:hidden;
}
.adm-form-header {
    background:linear-gradient(130deg,var(--primary-color),#0D1048);
    padding:24px 30px;
    display:flex; align-items:center; gap:14px;
}
.adm-form-header-ico {
    width:46px; height:46px; border-radius:13px;
    background:rgba(255,255,255,0.12);
    display:flex; align-items:center; justify-content:center;
    font-size:20px; color:#fff; flex-shrink:0;
}
.adm-form-header h2 { color:#fff; font-size:18px; font-weight:700; margin:0 0 3px; }
.adm-form-header p  { color:rgba(255,255,255,0.7); font-size:12.5px; margin:0; }
.adm-form-body { padding:28px 30px; }

/* Alert */
.adm-alert {
    display:flex; align-items:flex-start; gap:12px;
    padding:14px 18px; border-radius:12px; margin-bottom:22px;
    font-size:13.5px; line-height:1.6;
}
.adm-alert-ok  { background:#d4edda; color:#155724; border:1px solid #b8dfc4; }
.adm-alert-err { background:#f8d7da; color:#721c24; border:1px solid #f5c6cb; }
.adm-alert i   { font-size:16px; margin-top:2px; flex-shrink:0; }
.adm-error-list { margin:8px 0 0; padding-left:18px; }
.adm-error-list li { margin-bottom:3px; }
.adm-app-number {
    margin-top:14px; padding:14px 16px; border-radius:10px;
    background:#fff; border:1.5px dashed #16A34A;
    display:flex; flex-direction:column; gap:2px;
}
.adm-app-number span { font-size:10.5px; font-weight:700; letter-spacing:1px; text-transform:uppercase; color:#155724; }
.adm-app-number strong { font-size:22px; font-weight:800; color:#17165B; letter-spacing:0.5px; }
.adm-app-number small { font-size:11.5px; color:var(--text-light); margin-top:4px; }

/* Field groups */
.adm-section-label {
    font-size:11px; font-weight:700; letter-spacing:1.5px;
    text-transform:uppercase; color:var(--primary-color);
    padding:0 0 8px; border-bottom:1px solid rgba(23,22,91,0.12);
    margin:22px 0 16px; display:flex; align-items:center; gap:7px;
}
.adm-section-label:first-child { margin-top:0; }
.adm-section-label i { font-size:12px; }

.adm-row { display:grid; gap:16px; }
.adm-row-2 { grid-template-columns:1fr 1fr; }

/* Modern form inputs */
.adm-field { display:flex; flex-direction:column; gap:5px; }
.adm-field label {
    font-size:12.5px; font-weight:600; color:var(--text-dark);
}
.adm-field label .req { color:#e53935; margin-left:2px; }
.adm-field input,
.adm-field select,
.adm-field textarea {
    border:1.5px solid rgba(23,22,91,0.18);
    border-radius:10px; padding:10px 14px;
    font-size:13.5px; color:var(--text-dark);
    background:#fff; transition:border-color 0.25s, box-shadow 0.25s;
    font-family:inherit; width:100%; box-sizing:border-box;
}
.adm-field input:focus,
.adm-field select:focus,
.adm-field textarea:focus {
    outline:none; border-color:var(--primary-color);
    box-shadow:0 0 0 3px rgba(23,22,91,0.1);
}
.adm-field textarea { min-height:80px; resize:vertical; }
.adm-field small { font-size:11px; color:var(--text-light); }

/* File upload */
.adm-upload {
    border:1.5px dashed rgba(23,22,91,0.3);
    border-radius:10px; padding:16px 14px;
    text-align:center; cursor:pointer;
    transition:border-color 0.25s, background 0.25s;
    background:rgba(23,22,91,0.02);
}
.adm-upload:hover { border-color:var(--primary-color); background:rgba(23,22,91,0.04); }
.adm-upload input { display:none; }
.adm-upload-label { cursor:pointer; }
.adm-upload i { font-size:22px; color:var(--primary-color); margin-bottom:6px; display:block; }
.adm-upload span { font-size:12.5px; color:var(--text-light); display:block; }
.adm-upload strong { font-size:13px; color:var(--primary-color); }

/* Submit button */
.adm-submit {
    width:100%; padding:13px; border:none; border-radius:12px;
    background:var(--primary-color); color:#fff;
    font-size:15px; font-weight:700; cursor:pointer;
    display:flex; align-items:center; justify-content:center; gap:9px;
    transition:all 0.3s cubic-bezier(0.25,1,0.5,1);
    margin-top:22px; font-family:inherit;
}
.adm-submit:hover {
    background:#0D1048; transform:translateY(-2px);
    box-shadow:0 10px 28px rgba(23,22,91,0.3);
}

/* ── Sidebar ── */
.adm-sidebar { display:flex; flex-direction:column; gap:20px; }

.adm-side-card {
    background:#fff; border-radius:18px;
    border:1px solid rgba(23,22,91,0.1);
    box-shadow:0 4px 18px rgba(0,0,0,0.06);
    overflow:hidden;
}
.adm-side-head {
    padding:14px 20px;
    display:flex; align-items:center; gap:10px;
    border-bottom:1px solid rgba(23,22,91,0.08);
}
.adm-side-head i { color:var(--primary-color); font-size:15px; }
.adm-side-head h4 { font-size:13.5px; font-weight:700; color:var(--text-dark); margin:0; }
.adm-side-body { padding:16px 20px; }

/* Process steps (sidebar) */
.adm-step {
    display:flex; align-items:flex-start; gap:13px;
    padding:10px 0; border-bottom:1px solid rgba(23,22,91,0.06);
}
.adm-step:last-child { border-bottom:none; padding-bottom:0; }
.adm-step-num {
    width:30px; height:30px; border-radius:50%;
    background:var(--primary-color); color:#fff;
    display:flex; align-items:center; justify-content:center;
    font-size:12px; font-weight:800; flex-shrink:0;
}
.adm-step h5 { font-size:13px; font-weight:700; color:var(--text-dark); margin:0 0 3px; }
.adm-step p  { font-size:11.5px; color:var(--text-light); margin:0; line-height:1.5; }

/* Contact strip */
.adm-contact-row {
    display:flex; align-items:center; gap:10px;
    padding:9px 0; border-bottom:1px solid rgba(23,22,91,0.06);
    font-size:12.5px;
}
.adm-contact-row:last-child { border-bottom:none; padding-bottom:0; }
.adm-contact-ico {
    width:30px; height:30px; border-radius:9px;
    background:rgba(23,22,91,0.1);
    display:flex; align-items:center; justify-content:center;
    flex-shrink:0;
}
.adm-contact-ico i { color:var(--primary-color); font-size:12px; }
.adm-contact-row a { color:var(--text-dark); text-decoration:none; font-weight:600; }
.adm-contact-row a:hover { color:var(--primary-color); }

/* Doc checklist */
.adm-doc-item {
    display:flex; align-items:center; gap:9px;
    padding:7px 0; border-bottom:1px solid rgba(23,22,91,0.06);
    font-size:12.5px; color:var(--text-dark);
}
.adm-doc-item:last-child { border-bottom:none; }
.adm-doc-item i { color:var(--primary-color); font-size:11px; flex-shrink:0; }

/* ── Fee Section ── */
.adm-fee { padding:55px 0; background:#fff; }
.adm-fee-grid {
    display:grid; grid-template-columns:repeat(3,1fr);
    gap:18px; margin-top:38px;
}
.adm-fee-card {
    border-radius:18px; overflow:hidden;
    border:1px solid rgba(23,22,91,0.1);
    transition:transform 0.35s ease, box-shadow 0.35s ease;
    opacity:0; transform:translateY(28px);
}
.adm-fee-card.adm-in { animation:admIn 0.6s cubic-bezier(0.22,1,0.36,1) both; }
@keyframes admIn {
    from { opacity:0; transform:translateY(28px); }
    to   { opacity:1; transform:translateY(0); }
}
.adm-fee-card:hover { transform:translateY(-6px); box-shadow:0 16px 40px rgba(23,22,91,0.12); }
.adm-fee-top {
    padding:20px 22px 16px;
}
.adm-fee-top i { font-size:24px; margin-bottom:10px; display:block; }
.adm-fee-top h4 { font-size:14.5px; font-weight:700; color:#fff; margin:0 0 4px; }
.adm-fee-top small { color:rgba(255,255,255,0.7); font-size:11px; }
.adm-fee-amount {
    padding:14px 22px 18px;
    background:#fff;
}
.adm-fee-amount .price {
    font-size:22px; font-weight:800; color:var(--primary-color); line-height:1;
}
.adm-fee-amount .per { font-size:11px; color:var(--text-light); margin-top:3px; }
.adm-fee-note {
    margin-top:28px; padding:16px 20px;
    background:rgba(23,22,91,0.05);
    border:1px solid rgba(23,22,91,0.1);
    border-radius:14px; font-size:13px;
    color:var(--text-dark); text-align:center; line-height:1.6;
}
.adm-fee-note strong { color:var(--primary-color); }

/* ── Section header shared ── */
.adm-sh { text-align:center; margin-bottom:6px; }
.adm-sh-badge {
    display:inline-flex; align-items:center; gap:7px;
    background:rgba(23,22,91,0.08); border:1px solid rgba(23,22,91,0.22);
    color:var(--primary-color); padding:6px 16px; border-radius:50px;
    font-size:10.5px; font-weight:700; letter-spacing:2px;
    text-transform:uppercase; margin-bottom:12px;
}
.adm-sh h2 { font-size:28px; font-weight:800; color:var(--text-dark); margin:0 0 8px; }
.adm-sh h2 span { color:var(--primary-color); }
.adm-sh p { color:var(--text-light); font-size:14px; margin:0; }

/* ── CTA ── */
.adm-cta {
    padding:50px 0;
    background:linear-gradient(130deg,var(--primary-color) 0%,#17165B 55%,#0D1048 100%);
    position:relative; overflow:hidden;
}
.adm-cta::before {
    content:''; position:absolute; top:-100px; right:-100px;
    width:280px; height:280px;
    background:radial-gradient(circle,rgba(9,169,217,0.09) 0%,transparent 70%);
    border-radius:50%; pointer-events:none;
}

/* Responsive */
@media(max-width:960px) {
    .adm-layout { grid-template-columns:1fr; }
    .adm-sidebar { order:-1; }
    .adm-fee-grid { grid-template-columns:1fr 1fr; }
}
@media(max-width:580px) {
    .adm-row-2 { grid-template-columns:1fr; }
    .adm-fee-grid { grid-template-columns:1fr; }
    .adm-hero h1 { font-size:26px; }
}

/* ── Inline validation ── */
.adm-field-error { font-size:11.5px; color:#c62828; font-weight:600; margin-top:2px; line-height:1.45; }
.adm-invalid input, .adm-invalid select, .adm-invalid textarea { border-color:#e53935 !important; background:#fff8f8 !important; }
.adm-check { display:flex; align-items:flex-start; gap:9px; font-size:13px; color:var(--text-dark); cursor:pointer; line-height:1.55; }
.adm-check input { margin-top:3px; width:16px; height:16px; flex-shrink:0; accent-color:var(--primary-color); }
.adm-check.adm-invalid span { color:#c62828; }

/* ── Program info ── */
.adm-prog-info { display:none; margin:-4px 0 16px; padding:11px 14px; border-radius:10px; background:#EAF7FB; border:1px solid rgba(9,169,217,0.25); font-size:12.5px; color:var(--text-dark); }
.adm-prog-info div { display:flex; gap:8px; padding:2px 0; }
.adm-prog-info i { color:var(--primary-color); width:14px; text-align:center; margin-top:3px; }

/* ── Document slots ── */
.adm-doc-intro { font-size:12px; color:var(--text-light); margin:-4px 0 12px; line-height:1.6; }
.adm-docs { display:grid; grid-template-columns:1fr 1fr; gap:14px 12px; }
.adm-doc .adm-field-error { margin-top:5px; }
.adm-doc input[type=file] { position:absolute; width:1px; height:1px; opacity:0; pointer-events:none; }
.adm-doc-box {
    display:flex; flex-direction:column; align-items:center; text-align:center; gap:3px;
    border:1.5px dashed rgba(23,22,91,0.3); border-radius:10px; padding:14px 12px; cursor:pointer;
    background:rgba(23,22,91,0.02); transition:border-color 0.25s, background 0.25s; height:100%;
}
.adm-doc-box:hover, .adm-doc input:focus-visible + .adm-field-error, .adm-doc:focus-within .adm-doc-box { border-color:var(--primary-color); background:rgba(23,22,91,0.04); }
.adm-doc-box i { font-size:22px; color:var(--primary-color); margin-bottom:3px; }
.adm-doc-title { font-size:13px; font-weight:700; color:var(--text-dark); }
.adm-doc-hint { font-size:11px; color:var(--text-light); line-height:1.45; }
.adm-doc-files { margin-top:6px; font-size:11.5px; font-weight:700; color:var(--primary-color); word-break:break-all; }
.adm-doc.adm-has-file .adm-doc-box { border-style:solid; border-color:#16A34A; background:#F0FDF4; }
.adm-doc.adm-has-file .adm-doc-files { color:#15803D; }
.adm-doc.adm-invalid .adm-doc-box { border-color:#e53935; background:#fff8f8; }

/* ── Confirmation slip ── */
.adm-confirm { border:1px solid rgba(22,163,74,0.3); border-radius:14px; padding:22px; background:#fff; }
.adm-confirm-head { display:flex; align-items:center; gap:14px; margin-bottom:16px; }
.adm-confirm-ico { width:48px; height:48px; border-radius:50%; background:#16A34A; color:#fff; display:flex; align-items:center; justify-content:center; font-size:20px; flex-shrink:0; }
.adm-confirm-head h3 { margin:0 0 3px; font-size:19px; font-weight:800; color:#15803D; }
.adm-confirm-head p { margin:0; font-size:13px; color:var(--text-light); }
.adm-confirm .adm-app-number { margin:0 0 16px; }
.adm-confirm-table { width:100%; border-collapse:collapse; font-size:13px; margin-bottom:16px; }
.adm-confirm-table th { text-align:left; width:38%; padding:8px 10px; background:#F5F9FC; color:var(--text-light); font-weight:600; border-bottom:1px solid rgba(23,22,91,0.07); vertical-align:top; }
.adm-confirm-table td { padding:8px 10px; color:var(--text-dark); font-weight:600; border-bottom:1px solid rgba(23,22,91,0.07); overflow-wrap:anywhere; }
.adm-status-pill { display:inline-block; padding:2px 10px; border-radius:50px; background:rgba(245,158,11,0.12); color:#B45309; font-size:11.5px; font-weight:700; }
.adm-confirm-next { font-size:13px; color:var(--text-dark); background:#F5F9FC; border-radius:10px; padding:12px 14px; margin-bottom:16px; }
.adm-confirm-next ul { margin:6px 0 0; padding-left:18px; list-style:disc; }
.adm-confirm-next li { padding:2px 0; line-height:1.55; }
.adm-confirm-actions { display:flex; gap:10px; flex-wrap:wrap; align-items:center; }
.adm-confirm-actions .adm-submit { width:auto; padding-left:22px; padding-right:22px; }
.adm-btn-outline { display:inline-flex; align-items:center; gap:7px; padding:12px 20px; border-radius:10px; border:1px solid rgba(23,22,91,0.25); color:var(--primary-color); font-weight:700; font-size:14px; text-decoration:none; }
.adm-btn-outline:hover { background:rgba(23,22,91,0.05); color:var(--primary-color); }

@media(max-width:580px) {
    .adm-docs { grid-template-columns:1fr; }
    .adm-confirm { padding:16px; }
    .adm-confirm-table th { width:42%; }
}
@media print {
    body * { visibility:hidden; }
    #admSlip, #admSlip * { visibility:visible; }
    #admSlip { position:absolute; left:0; top:0; width:100%; border:none; }
    .adm-confirm-actions { display:none !important; }
}
</style>

<!-- ── Hero ── -->
<section class="adm-hero">
    <div class="adm-orb" style="width:360px;height:360px;background:rgba(23,22,91,0.2);top:-110px;right:-90px;"></div>
    <div class="adm-orb" style="width:220px;height:220px;background:rgba(9,169,217,0.07);bottom:-70px;left:-50px;"></div>
    <div class="container" style="position:relative;z-index:2;">
        <div class="adm-breadcrumb">
            <a href="index.php"><i class="fas fa-home"></i> Home</a>
            <i class="fas fa-chevron-right" style="font-size:9px;"></i>
            <span>Admission</span>
        </div>
        <div class="adm-hero-badge">
            <i class="fas fa-graduation-cap" style="font-size:9px;"></i>
            Admissions Open
        </div>
        <h1>Apply for <span>Admission</span></h1>
        <p>Start your educational journey with <?php echo getSiteName(); ?> — fill in the form and our team will guide you through the rest.</p>
    </div>
</section>

<!-- ── Main: Form + Sidebar ── -->
<section class="adm-main">
    <div class="container">
        <div class="adm-layout">

            <!-- ── Application Form ── -->
            <div class="adm-form-card" id="applyForm">
                <div class="adm-form-header">
                    <div class="adm-form-header-ico"><i class="fas fa-file-alt"></i></div>
                    <div>
                        <h2>Admission Application Form</h2>
                        <p>Fill in all required fields marked with *</p>
                    </div>
                </div>

                <div class="adm-form-body">
                    <?php if ($confirmation): $cf = $confirmation; ?>
                    <!-- ── Submission confirmation (printable slip) ── -->
                    <div class="adm-confirm" id="admSlip">
                        <div class="adm-confirm-head">
                            <div class="adm-confirm-ico"><i class="fas fa-check"></i></div>
                            <div>
                                <h3>Application Submitted</h3>
                                <p>Thank you, <?php echo htmlspecialchars($cf['name']); ?>. Your application has been received.</p>
                            </div>
                        </div>
                        <div class="adm-app-number">
                            <span>Your Application / Reference Number</span>
                            <strong><?php echo htmlspecialchars($cf['number']); ?></strong>
                            <small>Save or print this page — quote this number whenever you contact the admission office.</small>
                        </div>
                        <table class="adm-confirm-table">
                            <tr><th>Applicant</th><td><?php echo htmlspecialchars($cf['name']); ?></td></tr>
                            <tr><th>Father / Guardian</th><td><?php echo htmlspecialchars($cf['father']); ?></td></tr>
                            <tr><th>Program</th><td><?php echo htmlspecialchars($cf['program']); ?></td></tr>
                            <?php if (!empty($cf['department'])): ?><tr><th>Department</th><td><?php echo htmlspecialchars($cf['department']); ?></td></tr><?php endif; ?>
                            <?php if (!empty($cf['session'])): ?><tr><th>Admission Session</th><td><?php echo htmlspecialchars($cf['session']); ?></td></tr><?php endif; ?>
                            <tr><th>Contact</th><td><?php echo htmlspecialchars($cf['phone']); ?><?php echo $cf['email'] !== '' ? ' &middot; ' . htmlspecialchars($cf['email']) : ''; ?></td></tr>
                            <tr><th>Documents</th><td>
                                <?php
                                $doc_lines = [];
                                foreach ($doc_types as $dt => $slot) { if (!empty($cf['docs'][$dt])) $doc_lines[] = $slot['label'] . ($cf['docs'][$dt] > 1 ? ' (' . $cf['docs'][$dt] . ')' : ''); }
                                if (!empty($cf['legacy_doc'])) $doc_lines[] = 'Document uploaded';
                                echo $doc_lines ? htmlspecialchars(implode(', ', $doc_lines)) : 'None uploaded — please bring your documents to the admission office';
                                ?>
                            </td></tr>
                            <tr><th>Submitted</th><td><?php echo htmlspecialchars($cf['date']); ?></td></tr>
                            <tr><th>Status</th><td><span class="adm-status-pill">Under Review</span></td></tr>
                        </table>
                        <div class="adm-confirm-next">
                            <strong>What happens next?</strong>
                            <ul>
                                <li>Our admission team will review your application and contact you within 2-3 working days.</li>
                                <li>Bring your original documents to the college for verification.</li>
                                <?php if ($cf['email'] !== ''): ?><li>A confirmation has been sent to <?php echo htmlspecialchars($cf['email']); ?>.</li><?php endif; ?>
                            </ul>
                        </div>
                        <div class="adm-confirm-actions">
                            <button type="button" class="adm-submit" style="margin-top:0;" onclick="window.print()"><i class="fas fa-print"></i> Print / Save Slip</button>
                            <a href="admission.php#applyForm" class="adm-btn-outline"><i class="fas fa-plus"></i> New Application</a>
                        </div>
                    </div>
                    <?php endif; ?>

                    <?php if ($error_message): ?>
                    <div class="adm-alert adm-alert-err" role="alert" id="admErrorBox">
                        <i class="fas fa-exclamation-triangle"></i>
                        <div>
                            <?php echo htmlspecialchars($error_message); ?>
                            <?php if (!empty($errors)): ?>
                            <ul class="adm-error-list">
                                <?php foreach ($errors as $err): ?>
                                <li><?php echo htmlspecialchars($err); ?></li>
                                <?php endforeach; ?>
                            </ul>
                            <?php endif; ?>
                        </div>
                    </div>
                    <?php endif; ?>

                    <?php if (!$confirmation): ?>
                    <form method="POST" enctype="multipart/form-data" id="admissionForm" novalidate>

                        <!-- Personal Info -->
                        <div class="adm-section-label"><i class="fas fa-user"></i> Personal Information</div>
                        <div class="adm-row adm-row-2" style="margin-bottom:16px;">
                            <div class="adm-field<?php echo admErrClass('student_name'); ?>">
                                <label for="adm_student_name">Student Name <span class="req">*</span></label>
                                <input id="adm_student_name" type="text" name="student_name" required maxlength="100" autocomplete="name" placeholder="Full name as on CNIC / B-Form" value="<?php echo htmlspecialchars($f['student_name']); ?>">
                                <?php echo admErrMsg('student_name'); ?>
                            </div>
                            <div class="adm-field<?php echo admErrClass('father_name'); ?>">
                                <label for="adm_father_name">Father / Guardian Name <span class="req">*</span></label>
                                <input id="adm_father_name" type="text" name="father_name" required maxlength="100" placeholder="Father or guardian" value="<?php echo htmlspecialchars($f['father_name']); ?>">
                                <?php echo admErrMsg('father_name'); ?>
                            </div>
                        </div>
                        <?php if ($v2): ?>
                        <div class="adm-row adm-row-2" style="margin-bottom:16px;">
                            <div class="adm-field<?php echo admErrClass('gender'); ?>">
                                <label for="adm_gender">Gender <span class="req">*</span></label>
                                <select id="adm_gender" name="gender" required>
                                    <option value="">— Select —</option>
                                    <option value="male" <?php echo $f['gender'] === 'male' ? 'selected' : ''; ?>>Male</option>
                                    <option value="female" <?php echo $f['gender'] === 'female' ? 'selected' : ''; ?>>Female</option>
                                </select>
                                <?php echo admErrMsg('gender'); ?>
                            </div>
                            <div class="adm-field<?php echo admErrClass('date_of_birth'); ?>">
                                <label for="adm_dob">Date of Birth <span class="req">*</span></label>
                                <input id="adm_dob" type="date" name="date_of_birth" required min="<?php echo date('Y-m-d', strtotime('-70 years')); ?>" max="<?php echo date('Y-m-d', strtotime('-10 years')); ?>" value="<?php echo htmlspecialchars($f['date_of_birth']); ?>">
                                <?php echo admErrMsg('date_of_birth'); ?>
                            </div>
                        </div>
                        <?php endif; ?>
                        <div class="adm-row adm-row-2" style="margin-bottom:16px;">
                            <div class="adm-field<?php echo admErrClass('cnic_bform'); ?>">
                                <label for="adm_cnic">CNIC / B-Form Number <span class="req">*</span></label>
                                <input id="adm_cnic" type="text" name="cnic_bform" required inputmode="numeric" maxlength="15" placeholder="12345-1234567-1" value="<?php echo htmlspecialchars($f['cnic_bform']); ?>">
                                <?php echo admErrMsg('cnic_bform'); ?>
                            </div>
                            <div class="adm-field<?php echo admErrClass('phone'); ?>">
                                <label for="adm_phone">Contact Number <span class="req">*</span></label>
                                <input id="adm_phone" type="tel" name="phone" required maxlength="15" autocomplete="tel" placeholder="03001234567" value="<?php echo htmlspecialchars($f['phone']); ?>">
                                <?php echo admErrMsg('phone'); ?>
                            </div>
                        </div>
                        <div class="adm-row adm-row-2" style="margin-bottom:16px;">
                            <div class="adm-field<?php echo admErrClass('email'); ?>">
                                <label for="adm_email">Email Address</label>
                                <input id="adm_email" type="email" name="email" maxlength="100" autocomplete="email" placeholder="your.email@example.com" value="<?php echo htmlspecialchars($f['email']); ?>">
                                <small>Optional — your confirmation is emailed here.</small>
                                <?php echo admErrMsg('email'); ?>
                            </div>
                            <?php if ($v2): ?>
                            <div class="adm-field<?php echo admErrClass('guardian_phone'); ?>">
                                <label for="adm_guardian_phone">Guardian Contact Number</label>
                                <input id="adm_guardian_phone" type="tel" name="guardian_phone" maxlength="15" placeholder="03001234567" value="<?php echo htmlspecialchars($f['guardian_phone']); ?>">
                                <small>Optional</small>
                                <?php echo admErrMsg('guardian_phone'); ?>
                            </div>
                            <?php endif; ?>
                        </div>
                        <div class="adm-field<?php echo admErrClass('address'); ?>" style="margin-bottom:16px;">
                            <label for="adm_address">Residential Address <span class="req">*</span></label>
                            <textarea id="adm_address" name="address" required maxlength="500" autocomplete="street-address" placeholder="House, street, area, city"><?php echo htmlspecialchars($f['address']); ?></textarea>
                            <?php echo admErrMsg('address'); ?>
                        </div>

                        <!-- Academic Info -->
                        <div class="adm-section-label"><i class="fas fa-graduation-cap"></i> Academic Information</div>
                        <div class="adm-row adm-row-2" style="margin-bottom:16px;">
                            <div class="adm-field<?php echo admErrClass('qualification'); ?>">
                                <label for="adm_qualification">Previous Qualification <span class="req">*</span></label>
                                <input id="adm_qualification" type="text" name="qualification" required maxlength="150" list="admQualList" placeholder="e.g., F.Sc Pre-Medical" value="<?php echo htmlspecialchars($f['qualification']); ?>">
                                <?php echo admErrMsg('qualification'); ?>
                            </div>
                            <div class="adm-field<?php echo admErrClass('board_university'); ?>">
                                <label for="adm_board">Board / Institution<?php if ($v2): ?> <span class="req">*</span><?php endif; ?></label>
                                <input id="adm_board" type="text" name="board_university" <?php echo $v2 ? 'required' : ''; ?> maxlength="150" placeholder="e.g., BISE Multan" value="<?php echo htmlspecialchars($f['board_university']); ?>">
                                <?php echo admErrMsg('board_university'); ?>
                            </div>
                        </div>
                        <?php
                        // Qualification suggestions from the configured eligibility rules (no invented options)
                        $ql = mysqli_query($conn, "SELECT DISTINCT qualification FROM eligibility_rules WHERE status='active' ORDER BY qualification ASC");
                        ?>
                        <datalist id="admQualList">
                            <?php if ($ql) { while ($q = mysqli_fetch_assoc($ql)) { echo '<option value="' . htmlspecialchars($q['qualification']) . '">'; } } ?>
                        </datalist>
                        <?php if ($v2): ?>
                        <label class="adm-check" style="margin-bottom:12px;">
                            <input type="checkbox" name="result_awaited" value="1" id="adm_awaited" <?php echo $f['result_awaited'] === '1' ? 'checked' : ''; ?>>
                            <span>My result has not been announced yet (result awaited)</span>
                        </label>
                        <?php endif; ?>
                        <div class="adm-row adm-row-2" style="margin-bottom:16px;">
                            <div class="adm-field<?php echo admErrClass('marks_percentage'); ?>">
                                <label for="adm_marks">Marks / Percentage Obtained (%)<?php if ($v2): ?> <span class="req adm-req-marks">*</span><?php endif; ?></label>
                                <input id="adm_marks" type="number" name="marks_percentage" <?php echo $v2 ? 'required' : ''; ?> min="0" max="100" step="0.01" placeholder="e.g., 72" value="<?php echo htmlspecialchars($f['marks_percentage']); ?>">
                                <?php echo admErrMsg('marks_percentage'); ?>
                            </div>
                            <div class="adm-field<?php echo admErrClass('passing_year'); ?>">
                                <label for="adm_year">Passing Year<?php if ($v2): ?> <span class="req adm-req-marks">*</span><?php endif; ?></label>
                                <input id="adm_year" type="number" name="passing_year" <?php echo $v2 ? 'required' : ''; ?> min="1970" max="<?php echo date('Y') + 1; ?>" placeholder="e.g., <?php echo date('Y'); ?>" value="<?php echo htmlspecialchars($f['passing_year']); ?>">
                                <?php echo admErrMsg('passing_year'); ?>
                            </div>
                        </div>

                        <!-- Program -->
                        <div class="adm-section-label"><i class="fas fa-book-open"></i> Program Information</div>
                        <?php $selected_id = $f['course_id'] !== '' ? $f['course_id'] : ($_GET['course'] ?? ''); ?>
                        <div class="adm-row <?php echo $v2 ? 'adm-row-2' : ''; ?>" style="margin-bottom:16px;">
                            <div class="adm-field<?php echo admErrClass('course_id'); ?>">
                                <label for="adm_course">Desired Program <span class="req">*</span></label>
                                <select id="adm_course" name="course_id" required>
                                    <option value="">— Choose a Program —</option>
                                    <?php foreach ($form_courses as $c): ?>
                                    <option value="<?php echo (int) $c['id']; ?>" <?php echo (string) $selected_id === (string) $c['id'] ? 'selected' : ''; ?>><?php echo htmlspecialchars($c['name']); ?></option>
                                    <?php endforeach; ?>
                                </select>
                                <?php echo admErrMsg('course_id'); ?>
                            </div>
                            <?php if ($v2): ?>
                            <div class="adm-field<?php echo admErrClass('admission_session'); ?>">
                                <label for="adm_session">Admission Session <span class="req">*</span></label>
                                <select id="adm_session" name="admission_session" required>
                                    <?php if (count($sessions) !== 1): ?><option value="">— Select Session —</option><?php endif; ?>
                                    <?php foreach ($sessions as $sess): ?>
                                    <option value="<?php echo htmlspecialchars($sess); ?>" <?php echo $f['admission_session'] === $sess ? 'selected' : ''; ?>><?php echo htmlspecialchars($sess); ?></option>
                                    <?php endforeach; ?>
                                </select>
                                <?php echo admErrMsg('admission_session'); ?>
                            </div>
                            <?php endif; ?>
                        </div>
                        <div class="adm-prog-info" id="admProgInfo" aria-live="polite"></div>

                        <!-- Documents -->
                        <div class="adm-section-label"><i class="fas fa-paperclip"></i> Documents</div>
                        <?php if ($v2): ?>
                        <p class="adm-doc-intro">Upload clear scans or photos. Only the photograph is required online — other documents can also be submitted at the admission office. Total upload limit: <?php echo round($adm_max_total / 1048576); ?>MB.</p>
                        <div class="adm-docs">
                            <?php foreach ($doc_types as $dt => $slot): $multi = $slot['max'] > 1; ?>
                            <div class="adm-doc<?php echo admErrClass($slot['field']); ?>" data-max="<?php echo $slot['max']; ?>" data-size="<?php echo $slot['size']; ?>" data-ext="<?php echo implode(',', $slot['ext']); ?>" data-label="<?php echo htmlspecialchars($slot['label']); ?>" data-required="<?php echo $slot['required'] ? '1' : '0'; ?>">
                                <label class="adm-doc-box" for="adm_<?php echo $slot['field']; ?>">
                                    <i class="fas <?php echo $dt === 'photo' ? 'fa-user-circle' : ($dt === 'cnic' ? 'fa-id-card' : ($dt === 'academic' ? 'fa-file-lines' : 'fa-folder-open')); ?>"></i>
                                    <span class="adm-doc-title"><?php echo htmlspecialchars($slot['label']); ?><?php if ($slot['required']): ?> <span class="req">*</span><?php endif; ?></span>
                                    <span class="adm-doc-hint"><?php echo $slot['hint']; ?></span>
                                    <span class="adm-doc-files">Choose file<?php echo $multi ? 's' : ''; ?></span>
                                </label>
                                <input type="file" id="adm_<?php echo $slot['field']; ?>" name="<?php echo $slot['field'] . ($multi ? '[]' : ''); ?>" accept="<?php echo '.' . implode(',.', $slot['ext']); ?>" <?php echo $multi ? 'multiple' : ''; ?> <?php echo $slot['required'] ? 'required' : ''; ?>>
                                <?php echo admErrMsg($slot['field']); ?>
                            </div>
                            <?php endforeach; ?>
                        </div>
                        <?php else: ?>
                        <div class="adm-upload<?php echo admErrClass('documents'); ?>" style="margin-bottom:16px;" onclick="document.getElementById('docInput').click()">
                            <input type="file" id="docInput" name="documents" accept=".pdf,.jpg,.jpeg,.png">
                            <label class="adm-upload-label">
                                <i class="fas fa-cloud-upload-alt"></i>
                                <strong>Click to Upload Documents</strong>
                                <span>PDF, JPG, PNG — Max 5MB (Optional)</span>
                            </label>
                        </div>
                        <?php echo admErrMsg('documents'); ?>
                        <?php endif; ?>

                        <div class="adm-field" style="margin:16px 0 4px;">
                            <label for="adm_message">Additional Information</label>
                            <textarea id="adm_message" name="message" maxlength="2000" placeholder="Any extra details, scholarship request, etc..."><?php echo htmlspecialchars($f['message']); ?></textarea>
                        </div>

                        <?php if ($v2): ?>
                        <label class="adm-check<?php echo admErrClass('declaration'); ?>" style="margin-top:14px;">
                            <input type="checkbox" name="declaration" value="1" id="adm_declaration" required <?php echo $f['declaration'] === '1' ? 'checked' : ''; ?>>
                            <span>I confirm that the information and documents provided are correct. I understand that admission is subject to verification of original documents.</span>
                        </label>
                        <?php echo admErrMsg('declaration'); ?>
                        <?php endif; ?>

                        <button type="submit" class="adm-submit" id="admSubmitBtn">
                            <i class="fas fa-paper-plane"></i> Submit Application
                        </button>
                    </form>
                    <?php endif; ?>
                </div>
            </div>

            <!-- ── Sidebar ── -->
            <div class="adm-sidebar">

                <!-- Steps -->
                <div class="adm-side-card">
                    <div class="adm-side-head">
                        <i class="fas fa-list-ol"></i>
                        <h4>Admission Process</h4>
                    </div>
                    <div class="adm-side-body">
                        <?php $steps = getAdmissionSteps(); ?>
                        <?php foreach($steps as $i=>$s): ?>
                        <div class="adm-step">
                            <div class="adm-step-num"><?php echo $i+1; ?></div>
                            <div>
                                <h5><?php echo htmlspecialchars($s['title']); ?></h5>
                                <p><?php echo htmlspecialchars($s['desc']); ?></p>
                            </div>
                        </div>
                        <?php endforeach; ?>
                    </div>
                </div>

                <!-- Required Documents -->
                <div class="adm-side-card">
                    <div class="adm-side-head">
                        <i class="fas fa-folder-open"></i>
                        <h4>Required Documents</h4>
                    </div>
                    <div class="adm-side-body">
                        <?php $docs = getAdmissionDocuments(); ?>
                        <?php foreach($docs as $d): ?>
                        <div class="adm-doc-item">
                            <i class="fas fa-check-circle"></i>
                            <?php echo htmlspecialchars($d); ?>
                        </div>
                        <?php endforeach; ?>
                    </div>
                </div>

                <!-- Contact -->
                <div class="adm-side-card">
                    <div class="adm-side-head">
                        <i class="fas fa-headset"></i>
                        <h4>Need Help?</h4>
                    </div>
                    <div class="adm-side-body">
                        <div class="adm-contact-row">
                            <div class="adm-contact-ico"><i class="fas fa-phone-alt"></i></div>
                            <div><div style="font-size:11px;color:var(--text-light);">Call Us</div>
                            <a href="tel:<?php echo SITE_CONTACT; ?>"><?php echo SITE_CONTACT; ?></a></div>
                        </div>
                        <div class="adm-contact-row">
                            <div class="adm-contact-ico"><i class="fas fa-envelope"></i></div>
                            <div><div style="font-size:11px;color:var(--text-light);">Email</div>
                            <a href="mailto:<?php echo ADMIN_EMAIL; ?>"><?php echo ADMIN_EMAIL; ?></a></div>
                        </div>
                        <div class="adm-contact-row">
                            <div class="adm-contact-ico"><i class="fas fa-map-marker-alt"></i></div>
                            <div><div style="font-size:11px;color:var(--text-light);">Location</div>
                            <span style="font-weight:600;color:var(--text-dark);"><?php echo SITE_LOCATION; ?></span></div>
                        </div>
                        <div class="adm-contact-row">
                            <div class="adm-contact-ico"><i class="fas fa-clock"></i></div>
                            <div><div style="font-size:11px;color:var(--text-light);">Office Hours</div>
                            <span style="font-weight:600;color:var(--text-dark);">Mon–Sat, 8AM–4PM</span></div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</section>

<!-- ── CTA ── -->
<section class="adm-cta">
    <div class="container">
        <div style="display:flex;align-items:center;gap:44px;flex-wrap:wrap;position:relative;z-index:1;">
            <div style="flex:1 1 320px;">
                <div style="display:inline-flex;align-items:center;gap:7px;background:rgba(9,169,217,0.12);border:1px solid rgba(9,169,217,0.3);color:var(--accent-color);padding:6px 16px;border-radius:50px;font-size:10.5px;font-weight:700;letter-spacing:2px;text-transform:uppercase;margin-bottom:14px;">
                    <i class="fas fa-headset" style="font-size:9px;"></i> We're Here to Help
                </div>
                <h2 style="font-size:28px;font-weight:800;color:#fff;margin:0 0 10px;line-height:1.22;">
                    Questions About<br>
                    <span style="background:linear-gradient(90deg,var(--accent-color),#18B9E8);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">Admission Process?</span>
                </h2>
                <p style="color:rgba(255,255,255,0.68);font-size:14px;margin:0;line-height:1.7;">
                    Our admission team is ready to assist you — call, email, or visit our campus.
                </p>
            </div>
            <div style="display:flex;gap:12px;flex-wrap:wrap;flex-shrink:0;">
                <a href="contact.php"
                   style="display:inline-flex;align-items:center;gap:8px;background:var(--accent-color);color:#FFFFFF;padding:12px 26px;border-radius:10px;font-size:14px;font-weight:700;text-decoration:none;transition:all 0.3s ease;"
                   onmouseover="this.style.background='#18B9E8';this.style.transform='translateY(-2px)';"
                   onmouseout="this.style.background='var(--accent-color)';this.style.transform='';">
                    <i class="fas fa-envelope"></i> Contact Us
                </a>
                <a href="tel:<?php echo SITE_CONTACT; ?>"
                   style="display:inline-flex;align-items:center;gap:8px;background:rgba(255,255,255,0.08);border:1px solid rgba(255,255,255,0.25);color:#fff;padding:12px 26px;border-radius:10px;font-size:14px;font-weight:600;text-decoration:none;transition:all 0.3s ease;"
                   onmouseover="this.style.background='rgba(255,255,255,0.16)';this.style.transform='translateY(-2px)';"
                   onmouseout="this.style.background='rgba(255,255,255,0.08)';this.style.transform='';">
                    <i class="fas fa-phone"></i> Call Now
                </a>
            </div>
        </div>
    </div>
</section>

<script>
(function(){
    /* Fee cards entrance */
    var fCards = document.querySelectorAll('.adm-fee-card');
    if(fCards.length){
        var obs = new IntersectionObserver(function(entries){
            entries.forEach(function(e){
                if(!e.isIntersecting) return;
                var d = parseInt(e.target.dataset.admDelay)||0;
                setTimeout(function(){ e.target.classList.add('adm-in'); }, d);
                obs.unobserve(e.target);
            });
        },{threshold:0.1});
        fCards.forEach(function(c){ obs.observe(c); });
    }

    /* Legacy single-file upload label (shown until add_admission_form_fields.sql is run) */
    var inp = document.getElementById('docInput');
    if(inp){
        inp.addEventListener('change', function(){
            var lbl = this.closest('.adm-upload').querySelector('strong');
            if(this.files.length && lbl) lbl.textContent = this.files[0].name;
        });
    }

    /* ── Online admission form: inline validation, program info, document checks ── */
    var form = document.getElementById('admissionForm');
    if (form) {
        var PROGRAMS = <?php echo json_encode(array_map(function ($c) { return ['department' => $c['department'] ?: '', 'duration' => $c['duration'] ?: '', 'affiliation' => $c['affiliation'] ?: '']; }, $form_courses), JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE | JSON_HEX_TAG | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_HEX_AMP); ?>;
        var MAX_TOTAL = <?php echo (int) $adm_max_total; ?>;
        var MAX_COUNT = <?php echo (int) $adm_max_count; ?>;

        function fieldWrap(el) { return el.closest('.adm-field, .adm-doc, .adm-check'); }
        function setError(el, msg) {
            var wrap = fieldWrap(el); if (!wrap) return;
            var box = wrap.querySelector('.adm-field-error');
            if (!box && wrap.classList.contains('adm-check')) box = wrap.nextElementSibling && wrap.nextElementSibling.classList.contains('adm-field-error') ? wrap.nextElementSibling : null;
            if (msg) {
                wrap.classList.add('adm-invalid');
                if (!box) {
                    box = document.createElement('div'); box.className = 'adm-field-error';
                    if (wrap.classList.contains('adm-check')) wrap.parentNode.insertBefore(box, wrap.nextSibling); else wrap.appendChild(box);
                }
                box.textContent = msg;
                el.setAttribute('aria-invalid', 'true');
            } else {
                wrap.classList.remove('adm-invalid');
                if (box) box.remove();
                el.removeAttribute('aria-invalid');
            }
        }

        /* CNIC / B-Form: auto-format as 12345-1234567-1 */
        var cnic = document.getElementById('adm_cnic');
        if (cnic) cnic.addEventListener('input', function () {
            var d = cnic.value.replace(/\D/g, '').slice(0, 13), out = d.slice(0, 5);
            if (d.length > 5) out += '-' + d.slice(5, 12);
            if (d.length > 12) out += '-' + d.slice(12);
            cnic.value = out;
        });

        /* Result awaited: marks & passing year become optional */
        var awaited = document.getElementById('adm_awaited');
        var marks = document.getElementById('adm_marks'), year = document.getElementById('adm_year');
        function syncAwaited() {
            if (!awaited) return;
            [marks, year].forEach(function (i) { i.required = !awaited.checked; if (awaited.checked) setError(i, ''); });
            document.querySelectorAll('.adm-req-marks').forEach(function (r) { r.style.visibility = awaited.checked ? 'hidden' : ''; });
        }
        if (awaited) { awaited.addEventListener('change', syncAwaited); syncAwaited(); }

        /* Program → department / duration / affiliation */
        var course = document.getElementById('adm_course'), info = document.getElementById('admProgInfo');
        function esc(s) { return String(s).replace(/[&<>"']/g, function (c) { return {'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]; }); }
        function syncProgram() {
            var p = PROGRAMS[course.value];
            if (!p || (!p.department && !p.duration && !p.affiliation)) { info.style.display = 'none'; return; }
            var h = '';
            if (p.department) h += '<div><i class="fas fa-building-columns"></i><span><strong>Department:</strong> ' + esc(p.department) + '</span></div>';
            if (p.duration) h += '<div><i class="fas fa-clock"></i><span><strong>Duration:</strong> ' + esc(p.duration) + '</span></div>';
            if (p.affiliation) h += '<div><i class="fas fa-certificate"></i><span><strong>Affiliation:</strong> ' + esc(p.affiliation) + '</span></div>';
            info.innerHTML = h; info.style.display = 'block';
        }
        if (course && info) { course.addEventListener('change', syncProgram); syncProgram(); }

        /* Document slots: count, size and type checks before upload */
        function checkDoc(slot) {
            var input = slot.querySelector('input[type=file]'), files = input.files, label = slot.dataset.label;
            var max = parseInt(slot.dataset.max, 10), size = parseInt(slot.dataset.size, 10), exts = slot.dataset.ext.split(',');
            var names = slot.querySelector('.adm-doc-files');
            if (!files.length) {
                slot.classList.remove('adm-has-file');
                names.textContent = max > 1 ? 'Choose files' : 'Choose file';
                return slot.dataset.required === '1' ? label + ' is required.' : '';
            }
            names.textContent = Array.prototype.map.call(files, function (f) { return f.name; }).join(', ');
            slot.classList.add('adm-has-file');
            if (files.length > max) return label + ': you can upload up to ' + max + ' file' + (max > 1 ? 's' : '') + '.';
            for (var i = 0; i < files.length; i++) {
                var ext = files[i].name.split('.').pop().toLowerCase();
                if (exts.indexOf(ext) === -1) return label + ': allowed types are ' + exts.filter(function (e) { return e !== 'jpeg'; }).join(', ').toUpperCase() + '.';
                if (files[i].size > size) return label + ': "' + files[i].name + '" is larger than ' + Math.round(size / 1048576) + 'MB.';
            }
            return '';
        }
        document.querySelectorAll('.adm-doc').forEach(function (slot) {
            slot.querySelector('input[type=file]').addEventListener('change', function () { setError(this, checkDoc(slot)); });
        });

        /* Field-level messages */
        function fieldMessage(el) {
            var v = (el.value || '').trim(), name = el.name;
            if (el.type === 'checkbox') return el.required && !el.checked ? 'Please confirm that the information provided is correct.' : '';
            if (el.required && !v) {
                var lbl = form.querySelector('label[for="' + el.id + '"]');
                return (lbl ? lbl.textContent.replace('*', '').trim() : 'This field') + ' is required.';
            }
            if (!v) return '';
            if (name === 'cnic_bform' && v.replace(/\D/g, '').length !== 13) return 'CNIC / B-Form must be 13 digits (e.g., 12345-1234567-1).';
            if ((name === 'phone' || name === 'guardian_phone')) { var n = v.replace(/\D/g, '').length; if (n < 10 || n > 12) return 'Please enter a valid number, e.g. 03001234567.'; }
            if (name === 'email' && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(v)) return 'Please enter a valid email address.';
            if ((name === 'student_name' || name === 'father_name') && !/^[\p{L} .'-]+$/u.test(v)) return 'Please use letters only.';
            if (name === 'address' && v.length < 10) return 'Please enter your complete address.';
            if (name === 'marks_percentage' && (isNaN(+v) || +v < 0 || +v > 100)) return 'Enter a percentage between 0 and 100.';
            if (name === 'passing_year' && (!/^\d{4}$/.test(v) || +v < 1970 || +v > +el.max)) return 'Please enter a valid passing year.';
            if (name === 'date_of_birth' && ((el.min && v < el.min) || (el.max && v > el.max))) return 'Please check your date of birth.';
            return '';
        }
        form.querySelectorAll('input:not([type=file]), select, textarea').forEach(function (el) {
            el.addEventListener('blur', function () { if (el.type !== 'checkbox') setError(el, fieldMessage(el)); });
            el.addEventListener(el.type === 'checkbox' || el.tagName === 'SELECT' ? 'change' : 'input', function () {
                if (fieldWrap(el) && fieldWrap(el).classList.contains('adm-invalid')) setError(el, fieldMessage(el));
            });
        });

        form.addEventListener('submit', function (e) {
            var first = null, total = 0, count = 0;
            form.querySelectorAll('input:not([type=file]), select, textarea').forEach(function (el) {
                var msg = fieldMessage(el); setError(el, msg); if (msg && !first) first = el;
            });
            document.querySelectorAll('.adm-doc').forEach(function (slot) {
                var input = slot.querySelector('input[type=file]'), msg = checkDoc(slot);
                setError(input, msg); if (msg && !first) first = slot.querySelector('.adm-doc-box');
                Array.prototype.forEach.call(input.files, function (f) { total += f.size; count++; });
            });
            if (!first && total > MAX_TOTAL * 0.95) {
                var lastDoc = document.querySelector('.adm-doc:last-child input[type=file]');
                if (lastDoc) setError(lastDoc, 'Your files total ' + (total / 1048576).toFixed(1) + 'MB — the limit is ' + Math.round(MAX_TOTAL / 1048576) + 'MB. Please upload smaller files.');
                first = document.querySelector('.adm-docs');
            }
            if (!first && count > MAX_COUNT) {
                var od = document.querySelector('.adm-doc:last-child input[type=file]');
                if (od) setError(od, 'Please upload at most ' + MAX_COUNT + ' files in total.');
                first = document.querySelector('.adm-docs');
            }
            if (first) {
                e.preventDefault();
                first.scrollIntoView({ behavior: 'smooth', block: 'center' });
                if (first.focus) first.focus({ preventScroll: true });
                return;
            }
            var btn = document.getElementById('admSubmitBtn');
            btn.disabled = true; btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Submitting…';
        });

        /* Server-side errors: bring the first one into view */
        var firstInvalid = form.querySelector('.adm-invalid');
        if (firstInvalid) firstInvalid.scrollIntoView({ block: 'center' });
    }

    /* Confirmation page: make sure the slip is visible */
    var slip = document.getElementById('admSlip');
    if (slip) slip.scrollIntoView({ block: 'start' });

    /* Arriving from a "Apply for Scholarship" link — pre-fill the message field */
    var params = new URLSearchParams(window.location.search);
    var scholarshipName = params.get('scholarship');
    if (scholarshipName !== null) {
        var msg = document.querySelector('textarea[name="message"]');
        if (msg && !msg.value) {
            msg.value = scholarshipName
                ? 'I would like to apply for the "' + scholarshipName + '".'
                : 'I would like to apply for a scholarship.';
        }
    }
})();
</script>

<?php include 'includes/footer.php'; ?>
