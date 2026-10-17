-- Adds an optional per-program "Admission Information" field shown on course.php
-- TIP: cpanel_sync_migration_2026_10.sql includes this change and can be re-run safely (it skips anything already applied).
-- (AdminCP > Academics > Courses). Run once in phpMyAdmin on each database (local + live cPanel).
-- If it errors with "Duplicate column name", it has already been applied — safe to ignore.

ALTER TABLE courses ADD COLUMN admission_info TEXT NULL DEFAULT NULL AFTER eligibility;
