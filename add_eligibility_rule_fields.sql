-- Eligibility Checker: optional passing-year limit and program-specific requirements
-- TIP: cpanel_sync_migration_2026_10.sql includes this change and can be re-run safely (it skips anything already applied).
-- per rule (AdminCP > Eligibility Rules). Run once in phpMyAdmin on each database (local + live cPanel).
-- If a line errors with "Duplicate column name", it has already been applied — safe to ignore.
--
-- Both default to NULL, so existing rules behave exactly as before until an admin fills them in.

ALTER TABLE eligibility_rules ADD COLUMN max_years_since_passing INT(11) NULL DEFAULT NULL AFTER min_percentage;
ALTER TABLE eligibility_rules ADD COLUMN requirements TEXT NULL DEFAULT NULL AFTER max_years_since_passing;
