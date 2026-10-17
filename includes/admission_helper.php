<?php
/**
 * Online admission form helpers — shared by admission.php and the AdminCP
 * admission / student screens.
 */

// Directory (relative to the site root) for applicant uploads. It carries a
// "Require all denied" .htaccess, so files are reachable only through
// AdminCP/admission_file.php for logged-in admins — CNIC scans and photos are never public.
define('ADMISSION_UPLOAD_DIR', 'uploads/applications/');

/** True once add_admission_form_fields.sql has been run. */
function admissionFormV2Ready($conn) {
    static $ready = null;
    if ($ready === null) {
        $t = mysqli_query($conn, "SHOW TABLES LIKE 'admission_documents'");
        $ready = $t && mysqli_num_rows($t) > 0
            && dbColumnExists($conn, 'admissions', 'admission_session')
            && dbColumnExists($conn, 'admissions', 'date_of_birth')
            && dbColumnExists($conn, 'admissions', 'gender')
            && dbColumnExists($conn, 'admissions', 'guardian_phone')
            && dbColumnExists($conn, 'admissions', 'result_awaited');
    }
    return $ready;
}

/** Admission sessions offered on the form (AdminCP > Admission > Page Content). */
function getAdmissionSessions() {
    $y = (int) date('Y');
    $raw = getSetting('adm_sessions', $y . '-' . ($y + 1));
    return array_values(array_filter(array_map('trim', preg_split('/\R/', (string) $raw))));
}

/**
 * Document slots on the form. 'max' = number of files allowed for the slot.
 * Only the photograph is mandatory online; the rest can also be submitted at the office.
 */
function getAdmissionDocTypes() {
    return [
        'photo'    => ['label' => 'Student Photograph',            'field' => 'doc_photo',    'required' => true,  'max' => 1, 'ext' => ['jpg', 'jpeg', 'png'],        'size' => 2 * 1024 * 1024, 'hint' => 'Recent passport-size photo · JPG or PNG · max 2MB'],
        'cnic'     => ['label' => 'CNIC / B-Form Copy',            'field' => 'doc_cnic',     'required' => false, 'max' => 2, 'ext' => ['pdf', 'jpg', 'jpeg', 'png'], 'size' => 5 * 1024 * 1024, 'hint' => 'Front &amp; back if separate · PDF, JPG or PNG · max 5MB each'],
        'academic' => ['label' => 'Previous Academic Documents',   'field' => 'doc_academic', 'required' => false, 'max' => 4, 'ext' => ['pdf', 'jpg', 'jpeg', 'png'], 'size' => 5 * 1024 * 1024, 'hint' => 'Result cards / certificates · up to 4 files · max 5MB each'],
        'other'    => ['label' => 'Other Documents',               'field' => 'doc_other',    'required' => false, 'max' => 3, 'ext' => ['pdf', 'jpg', 'jpeg', 'png'], 'size' => 5 * 1024 * 1024, 'hint' => 'e.g. domicile, migration certificate · up to 3 files · max 5MB each'],
    ];
}

/** Normalizes $_FILES[$field] (single or multiple) into a list of file entries, skipping empty slots. */
function admissionCollectFiles($field) {
    if (!isset($_FILES[$field])) return [];
    $f = $_FILES[$field];
    if (!is_array($f['name'])) {
        return $f['error'] === UPLOAD_ERR_NO_FILE ? [] : [$f];
    }
    $out = [];
    foreach ($f['name'] as $i => $name) {
        if ($f['error'][$i] === UPLOAD_ERR_NO_FILE) continue;
        $out[] = ['name' => $name, 'type' => $f['type'][$i], 'tmp_name' => $f['tmp_name'][$i], 'error' => $f['error'][$i], 'size' => $f['size'][$i]];
    }
    return $out;
}

/**
 * Validates one uploaded file against a document slot by extension AND real content.
 * Returns ['ok' => true, 'mime' => ..., 'ext' => ...] or ['ok' => false, 'error' => ...].
 */
function admissionValidateFile(array $file, array $slot) {
    $label = $slot['label'];
    if ($file['error'] === UPLOAD_ERR_INI_SIZE || $file['error'] === UPLOAD_ERR_FORM_SIZE) {
        return ['ok' => false, 'error' => "$label: file is too large."];
    }
    if ($file['error'] !== UPLOAD_ERR_OK || !is_uploaded_file($file['tmp_name'])) {
        return ['ok' => false, 'error' => "$label: upload failed, please try again."];
    }
    if ($file['size'] > $slot['size']) {
        return ['ok' => false, 'error' => "$label: file must be smaller than " . round($slot['size'] / 1048576) . 'MB.'];
    }
    $ext = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
    if (!in_array($ext, $slot['ext'], true)) {
        return ['ok' => false, 'error' => "$label: allowed file types are " . strtoupper(implode(', ', array_unique(str_replace('jpeg', 'jpg', $slot['ext'])))) . '.'];
    }
    $finfo = new finfo(FILEINFO_MIME_TYPE);
    $mime = $finfo->file($file['tmp_name']);
    $allowed_mimes = ['pdf' => ['application/pdf'], 'jpg' => ['image/jpeg'], 'jpeg' => ['image/jpeg'], 'png' => ['image/png']];
    if (!in_array($mime, $allowed_mimes[$ext] ?? [], true)) {
        return ['ok' => false, 'error' => "$label: the file content doesn't match its type — please upload a genuine " . strtoupper($ext) . ' file.'];
    }
    if (strpos($mime, 'image/') === 0 && @getimagesize($file['tmp_name']) === false) {
        return ['ok' => false, 'error' => "$label: the image could not be read — please upload another file."];
    }
    return ['ok' => true, 'mime' => $mime, 'ext' => $ext === 'jpeg' ? 'jpg' : $ext];
}

/** Ensures the protected upload directory exists with a deny-all .htaccess. Returns its absolute path. */
function admissionUploadDir() {
    $dir = dirname(__DIR__) . '/' . ADMISSION_UPLOAD_DIR;
    if (!is_dir($dir)) mkdir($dir, 0755, true);
    $ht = $dir . '.htaccess';
    if (!file_exists($ht)) {
        file_put_contents($ht, "# Applicant documents (CNIC, photos, certificates) — never served directly.\n# Admins download them through AdminCP/admission_file.php.\nRequire all denied\n");
    }
    return $dir;
}

/** Moves a validated upload into the protected directory under an unguessable name. Returns the relative path or null. */
function admissionStoreFile(array $file, $ext) {
    $dir = admissionUploadDir();
    $name = 'app_' . date('Ymd') . '_' . bin2hex(random_bytes(16)) . '.' . $ext;
    if (!move_uploaded_file($file['tmp_name'], $dir . $name)) return null;
    if ($ext !== 'pdf') compressUploadedImage($dir . $name);
    return ADMISSION_UPLOAD_DIR . $name;
}

/** All documents for an application, grouped by doc_type. */
function getApplicationFiles($conn, $admission_id) {
    $out = [];
    if (!admissionFormV2Ready($conn)) return $out;
    $r = mysqli_query($conn, "SELECT * FROM admission_documents WHERE admission_id = " . intval($admission_id) . " ORDER BY id ASC");
    if ($r) { while ($row = mysqli_fetch_assoc($r)) { $out[$row['doc_type']][] = $row; } }
    return $out;
}
