<?php
/**
 * Streams an applicant's uploaded document to a logged-in admin.
 * Applicant files live in uploads/applications/ (web access denied), so this is
 * the only way to view them.
 *   ?id=N            — a row in admission_documents
 *   ?legacy=N        — the single `documents` file of admission N (pre-migration form)
 *   &download=1      — force download instead of inline view
 */
session_start([
    'cookie_httponly' => true,
    'cookie_samesite' => 'Lax',
    'cookie_secure' => (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off'),
]);
require_once '../includes/config.php';
require_once '../includes/admission_helper.php';

if (!isset($_SESSION['admin_logged_in']) || $_SESSION['admin_logged_in'] !== true) {
    http_response_code(403);
    exit('Forbidden');
}

$path = null;
$name = 'document';
if (isset($_GET['id']) && admissionFormV2Ready($conn)) {
    $row = mysqli_fetch_assoc(mysqli_query($conn, "SELECT file_path, original_name FROM admission_documents WHERE id = " . intval($_GET['id'])));
    if ($row) { $path = $row['file_path']; $name = $row['original_name'] ?: basename($row['file_path']); }
} elseif (isset($_GET['legacy'])) {
    $row = mysqli_fetch_assoc(mysqli_query($conn, "SELECT documents FROM admissions WHERE id = " . intval($_GET['legacy'])));
    if ($row && $row['documents'] !== '') { $path = $row['documents']; $name = basename($row['documents']); }
}

// Only ever serve files from the two applicant upload folders
$root = realpath(dirname(__DIR__));
$full = $path ? realpath($root . '/' . $path) : false;
$allowed = [realpath($root . '/uploads/applications'), realpath($root . '/uploads/documents')];
$inside = false;
foreach ($allowed as $dir) {
    if ($dir && $full && strpos($full, $dir . DIRECTORY_SEPARATOR) === 0) { $inside = true; break; }
}
if (!$full || !$inside || !is_file($full)) {
    http_response_code(404);
    exit('File not found');
}

$mime = (new finfo(FILEINFO_MIME_TYPE))->file($full);
if (!in_array($mime, ['application/pdf', 'image/jpeg', 'image/png'], true)) {
    $mime = 'application/octet-stream';
}
$disposition = !empty($_GET['download']) || $mime === 'application/octet-stream' ? 'attachment' : 'inline';
$safe_name = preg_replace('/[^A-Za-z0-9._ -]/', '_', $name);

header('Content-Type: ' . $mime);
header('Content-Length: ' . filesize($full));
header('Content-Disposition: ' . $disposition . '; filename="' . $safe_name . '"');
header('X-Content-Type-Options: nosniff');
header('Cache-Control: private, no-store');
readfile($full);
