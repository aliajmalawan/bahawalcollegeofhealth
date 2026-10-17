-- Clinical Training page: hospital photo, verified training details and a
-- TIP: cpanel_sync_migration_2026_10.sql includes this change and can be re-run safely (it skips anything already applied).
-- "verified partnership" flag (AdminCP > Clinical Training).
-- Run once in phpMyAdmin on each database (local + live cPanel).
-- If a line errors with "Duplicate column name", it has already been applied — safe to ignore.
--
-- is_verified defaults to 0 so no existing hospital is shown as a "Verified Partner"
-- until an admin confirms the partnership and ticks the box.

ALTER TABLE clinical_partners ADD COLUMN image VARCHAR(255) NULL DEFAULT NULL AFTER logo;
ALTER TABLE clinical_partners ADD COLUMN training_details TEXT NULL DEFAULT NULL AFTER programs;
ALTER TABLE clinical_partners ADD COLUMN is_verified TINYINT(1) NOT NULL DEFAULT 0 AFTER training_details;
