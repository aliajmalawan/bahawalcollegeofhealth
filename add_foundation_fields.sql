-- Bahawal Welfare Foundation page: activity images + tagging projects as Foundation projects.
-- TIP: cpanel_sync_migration_2026_10.sql includes this change and can be re-run safely (it skips anything already applied).
-- Run once in phpMyAdmin on each database (local + live cPanel).
-- If a line errors with "Duplicate column name", it has already been applied — safe to ignore.
--
-- Foundation contact details and the photo-gallery category are stored in `settings`
-- (AdminCP > Bahawal Welfare Foundation > Page Content) and need no schema change.

ALTER TABLE foundation_activities ADD COLUMN image VARCHAR(255) NULL DEFAULT NULL AFTER icon;
ALTER TABLE projects ADD COLUMN is_foundation TINYINT(1) NOT NULL DEFAULT 0 AFTER category;
