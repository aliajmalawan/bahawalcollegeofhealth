-- =====================================================================
-- cPanel DATABASE SYNC (October 2026) — run this on your LIVE database
-- =====================================================================
-- Combines every schema change from the October 2026 feature work into one
-- file. It ONLY ADDS what is missing (13 optional columns + 1 table); it
-- never changes, overwrites or deletes existing records.
--
-- Unlike the individual add_*.sql files, every step here checks first and
-- skips itself if already applied, so phpMyAdmin never stops on a
-- "Duplicate column" error. Safe to run any number of times, on a database
-- where none, some or all of the changes are already present.
--
-- HOW TO RUN:
--   1. cPanel -> phpMyAdmin -> select your website database
--   2. SQL tab -> paste this whole file -> Go
--
-- Covers: add_course_admission_info.sql, add_clinical_training_fields.sql,
-- add_eligibility_rule_fields.sql, add_admission_form_fields.sql,
-- add_foundation_fields.sql. (The optional menu change is separate:
-- restructure_navigation.sql.)
-- =====================================================================

-- Helper pattern for each column: build the ALTER only if the column is missing.

-- ── Programs: per-program admission information (course.php) ──
SET @sql = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE courses ADD COLUMN admission_info TEXT NULL DEFAULT NULL AFTER eligibility', 'DO 0')
            FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'courses' AND COLUMN_NAME = 'admission_info');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- ── Clinical training: hospital photo, verified training details, verified flag ──
SET @sql = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE clinical_partners ADD COLUMN image VARCHAR(255) NULL DEFAULT NULL AFTER logo', 'DO 0')
            FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'clinical_partners' AND COLUMN_NAME = 'image');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;
SET @sql = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE clinical_partners ADD COLUMN training_details TEXT NULL DEFAULT NULL AFTER programs', 'DO 0')
            FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'clinical_partners' AND COLUMN_NAME = 'training_details');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;
SET @sql = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE clinical_partners ADD COLUMN is_verified TINYINT(1) NOT NULL DEFAULT 0 AFTER training_details', 'DO 0')
            FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'clinical_partners' AND COLUMN_NAME = 'is_verified');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- ── Eligibility rules: passing-year limit + program-specific requirements ──
SET @sql = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE eligibility_rules ADD COLUMN max_years_since_passing INT(11) NULL DEFAULT NULL AFTER min_percentage', 'DO 0')
            FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'eligibility_rules' AND COLUMN_NAME = 'max_years_since_passing');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;
SET @sql = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE eligibility_rules ADD COLUMN requirements TEXT NULL DEFAULT NULL AFTER max_years_since_passing', 'DO 0')
            FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'eligibility_rules' AND COLUMN_NAME = 'requirements');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- ── Online admission form: extra applicant details ──
SET @sql = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE admissions ADD COLUMN gender ENUM(''male'',''female'') NULL DEFAULT NULL AFTER father_name', 'DO 0')
            FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'admissions' AND COLUMN_NAME = 'gender');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;
SET @sql = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE admissions ADD COLUMN date_of_birth DATE NULL DEFAULT NULL AFTER gender', 'DO 0')
            FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'admissions' AND COLUMN_NAME = 'date_of_birth');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;
SET @sql = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE admissions ADD COLUMN guardian_phone VARCHAR(20) NULL DEFAULT NULL AFTER phone', 'DO 0')
            FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'admissions' AND COLUMN_NAME = 'guardian_phone');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;
SET @sql = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE admissions ADD COLUMN admission_session VARCHAR(50) NULL DEFAULT NULL AFTER course_id', 'DO 0')
            FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'admissions' AND COLUMN_NAME = 'admission_session');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;
SET @sql = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE admissions ADD COLUMN result_awaited TINYINT(1) NOT NULL DEFAULT 0 AFTER marks_percentage', 'DO 0')
            FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'admissions' AND COLUMN_NAME = 'result_awaited');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- ── Online admission form: one row per uploaded document (the only new table) ──
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

-- ── Welfare Foundation: activity images + tagging projects as Foundation projects ──
SET @sql = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE foundation_activities ADD COLUMN image VARCHAR(255) NULL DEFAULT NULL AFTER icon', 'DO 0')
            FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'foundation_activities' AND COLUMN_NAME = 'image');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;
SET @sql = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE projects ADD COLUMN is_foundation TINYINT(1) NOT NULL DEFAULT 0 AFTER category', 'DO 0')
            FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'projects' AND COLUMN_NAME = 'is_foundation');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- Done. AdminCP > Dashboard shows "Database: up to date" once everything is applied.
