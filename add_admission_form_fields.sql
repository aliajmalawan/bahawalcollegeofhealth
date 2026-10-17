-- Online Admission Form: extra applicant details + multiple document uploads.
-- TIP: cpanel_sync_migration_2026_10.sql includes this change and can be re-run safely (it skips anything already applied).
-- Run once in phpMyAdmin on each database (local + live cPanel).
-- If a line errors with "Duplicate column name" / "already exists", it has already
-- been applied — safe to ignore and continue.
--
-- Until this is run, admission.php keeps working with its original fields.

ALTER TABLE admissions ADD COLUMN gender ENUM('male','female') NULL DEFAULT NULL AFTER father_name;
ALTER TABLE admissions ADD COLUMN date_of_birth DATE NULL DEFAULT NULL AFTER gender;
ALTER TABLE admissions ADD COLUMN guardian_phone VARCHAR(20) NULL DEFAULT NULL AFTER phone;
ALTER TABLE admissions ADD COLUMN admission_session VARCHAR(50) NULL DEFAULT NULL AFTER course_id;
ALTER TABLE admissions ADD COLUMN result_awaited TINYINT(1) NOT NULL DEFAULT 0 AFTER marks_percentage;

-- One row per uploaded file. Files live in uploads/applications/ (web access denied)
-- and are served to logged-in admins only via AdminCP/admission_file.php.
CREATE TABLE IF NOT EXISTS admission_documents (
  id INT(11) NOT NULL AUTO_INCREMENT,
  admission_id INT(11) NOT NULL,
  doc_type ENUM('photo','cnic','academic','other') NOT NULL,
  file_path VARCHAR(255) NOT NULL,
  original_name VARCHAR(255) DEFAULT NULL,
  mime_type VARCHAR(100) DEFAULT NULL,
  file_size INT(11) DEFAULT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY admission_id (admission_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
