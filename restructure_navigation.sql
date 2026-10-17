-- =====================================================================
-- Main navigation restructure (AdminCP > Menu Builder data)
-- =====================================================================
-- Reduces the top bar from 9 to 7 items with grouped dropdowns:
--   Home | About | Academics | Admissions | Our Institute | Student Life | Contact
-- Campuses and Gallery move into the About and Student Life dropdowns.
--
-- Safe to run more than once. Items are matched by page URL (not ID), so it
-- also works on a live database whose IDs differ. Existing items are moved and
-- relabelled; only missing ones are added. Nothing is deleted — the old
-- top-level "Campuses" item is just set to inactive.
-- Run in phpMyAdmin (SQL tab) on each database. Afterwards everything can
-- still be fine-tuned in AdminCP > Menu Builder.
-- =====================================================================

-- 1. Top-level items
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Our Institute', 'fa-building-columns', 'our-networks.php', NULL, 0, 5, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE parent_id IS NULL AND label='Our Institute');
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Home', 'fa-house', 'index.php', NULL, 0, 1, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE parent_id IS NULL AND url='index.php');
SET @home = (SELECT id FROM menu_items WHERE parent_id IS NULL AND url='index.php' ORDER BY id LIMIT 1);
UPDATE menu_items SET label='Home', icon='fa-house', display_order=1, status='active' WHERE id=@home;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'About', 'fa-circle-info', 'about.php', NULL, 0, 2, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE parent_id IS NULL AND url='about.php');
SET @about = (SELECT id FROM menu_items WHERE parent_id IS NULL AND url='about.php' ORDER BY id LIMIT 1);
UPDATE menu_items SET label='About', icon='fa-circle-info', display_order=2, status='active' WHERE id=@about;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Academics', 'fa-book-open', 'courses.php', NULL, 0, 3, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE parent_id IS NULL AND url='courses.php');
SET @acad = (SELECT id FROM menu_items WHERE parent_id IS NULL AND url='courses.php' ORDER BY id LIMIT 1);
UPDATE menu_items SET label='Academics', icon='fa-book-open', display_order=3, status='active' WHERE id=@acad;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Admissions', 'fa-file-pen', 'admission.php', NULL, 0, 4, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE parent_id IS NULL AND url='admission.php');
SET @adm = (SELECT id FROM menu_items WHERE parent_id IS NULL AND url='admission.php' ORDER BY id LIMIT 1);
UPDATE menu_items SET label='Admissions', icon='fa-file-pen', display_order=4, status='active' WHERE id=@adm;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Our Institute', 'fa-building-columns', 'our-networks.php', NULL, 0, 5, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE parent_id IS NULL AND label='Our Institute');
SET @inst = (SELECT id FROM menu_items WHERE parent_id IS NULL AND label='Our Institute' ORDER BY id LIMIT 1);
UPDATE menu_items SET label='Our Institute', icon='fa-building-columns', display_order=5, status='active' WHERE id=@inst;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Student Life', 'fa-layer-group', 'activities.php', NULL, 0, 6, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE parent_id IS NULL AND url='events.php');
SET @life = (SELECT id FROM menu_items WHERE parent_id IS NULL AND url='events.php' ORDER BY id LIMIT 1);
UPDATE menu_items SET label='Student Life', icon='fa-layer-group', display_order=6, status='active' WHERE id=@life;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Contact', 'fa-headset', 'contact.php', NULL, 0, 7, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE parent_id IS NULL AND url='contact.php');
SET @contact = (SELECT id FROM menu_items WHERE parent_id IS NULL AND url='contact.php' ORDER BY id LIMIT 1);
UPDATE menu_items SET label='Contact', icon='fa-headset', display_order=7, status='active' WHERE id=@contact;

-- 2. Gallery: the top-level item becomes a Student Life child
SET @gallery_top = (SELECT id FROM menu_items WHERE parent_id IS NULL AND url='gallery.php' ORDER BY id LIMIT 1);
UPDATE menu_items SET parent_id=@life WHERE id=@gallery_top AND NOT EXISTS (SELECT 1 FROM (SELECT id FROM menu_items WHERE parent_id IS NOT NULL AND url='gallery.php') t);
UPDATE menu_items SET status='inactive' WHERE id=@gallery_top AND parent_id IS NULL;

-- 3. Dropdown items (move/relabel existing, add missing)
UPDATE menu_items SET parent_id=@about, label='About B.C.H.S', icon='fa-university', display_order=1, status='active' WHERE url='about.php' AND parent_id IS NOT NULL;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'About B.C.H.S', 'fa-university', 'about.php', @about, 0, 1, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE url='about.php' AND parent_id IS NOT NULL);
UPDATE menu_items SET parent_id=@about, label='Mission & Vision', icon='fa-compass', display_order=2, status='active' WHERE url='mission-vision.php' AND parent_id IS NOT NULL;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Mission & Vision', 'fa-compass', 'mission-vision.php', @about, 0, 2, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE url='mission-vision.php' AND parent_id IS NOT NULL);
UPDATE menu_items SET parent_id=@about, label='Core Values', icon='fa-heart', display_order=3, status='active' WHERE url='core-values.php' AND parent_id IS NOT NULL;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Core Values', 'fa-heart', 'core-values.php', @about, 0, 3, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE url='core-values.php' AND parent_id IS NOT NULL);
UPDATE menu_items SET parent_id=@about, label='Leadership', icon='fa-users', display_order=4, status='active' WHERE url='leadership.php' AND parent_id IS NOT NULL;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Leadership', 'fa-users', 'leadership.php', @about, 0, 4, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE url='leadership.php' AND parent_id IS NOT NULL);
UPDATE menu_items SET parent_id=@about, label='Chairman''s Message', icon='fa-user-tie', display_order=5, status='active' WHERE url='chairman-message.php' AND parent_id IS NOT NULL;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Chairman''s Message', 'fa-user-tie', 'chairman-message.php', @about, 0, 5, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE url='chairman-message.php' AND parent_id IS NOT NULL);
UPDATE menu_items SET parent_id=@about, label='Principal''s Message', icon='fa-user-graduate', display_order=6, status='active' WHERE url='principal-message.php' AND parent_id IS NOT NULL;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Principal''s Message', 'fa-user-graduate', 'principal-message.php', @about, 0, 6, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE url='principal-message.php' AND parent_id IS NOT NULL);
UPDATE menu_items SET parent_id=@about, label='Affiliations & Accreditation', icon='fa-certificate', display_order=7, status='active' WHERE url='accreditation.php' AND parent_id IS NOT NULL;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Affiliations & Accreditation', 'fa-certificate', 'accreditation.php', @about, 0, 7, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE url='accreditation.php' AND parent_id IS NOT NULL);
UPDATE menu_items SET parent_id=@about, label='Our Campuses', icon='fa-location-dot', display_order=8, status='active' WHERE url='campuses.php' AND parent_id IS NOT NULL;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Our Campuses', 'fa-location-dot', 'campuses.php', @about, 0, 8, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE url='campuses.php' AND parent_id IS NOT NULL);

UPDATE menu_items SET parent_id=@acad, label='Programs & Courses', icon='fa-book-open', display_order=1, status='active' WHERE url='courses.php' AND parent_id IS NOT NULL;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Programs & Courses', 'fa-book-open', 'courses.php', @acad, 0, 1, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE url='courses.php' AND parent_id IS NOT NULL);
UPDATE menu_items SET parent_id=@acad, label='Faculty', icon='fa-chalkboard-user', display_order=2, status='active' WHERE url='faculty.php' AND parent_id IS NOT NULL;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Faculty', 'fa-chalkboard-user', 'faculty.php', @acad, 0, 2, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE url='faculty.php' AND parent_id IS NOT NULL);
UPDATE menu_items SET parent_id=@acad, label='Clinical Training', icon='fa-hospital', display_order=3, status='active' WHERE url='clinical-training.php' AND parent_id IS NOT NULL;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Clinical Training', 'fa-hospital', 'clinical-training.php', @acad, 0, 3, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE url='clinical-training.php' AND parent_id IS NOT NULL);
UPDATE menu_items SET parent_id=@acad, label='Examination', icon='fa-file-alt', display_order=4, status='active' WHERE url='examination.php' AND parent_id IS NOT NULL;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Examination', 'fa-file-alt', 'examination.php', @acad, 0, 4, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE url='examination.php' AND parent_id IS NOT NULL);

UPDATE menu_items SET parent_id=@adm, label='Apply Online', icon='fa-file-pen', display_order=1, status='active' WHERE url='admission.php' AND parent_id IS NOT NULL;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Apply Online', 'fa-file-pen', 'admission.php', @adm, 0, 1, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE url='admission.php' AND parent_id IS NOT NULL);
UPDATE menu_items SET parent_id=@adm, label='Eligibility Checker', icon='fa-clipboard-check', display_order=2, status='active' WHERE url='eligibility-checker.php' AND parent_id IS NOT NULL;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Eligibility Checker', 'fa-clipboard-check', 'eligibility-checker.php', @adm, 0, 2, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE url='eligibility-checker.php' AND parent_id IS NOT NULL);
UPDATE menu_items SET parent_id=@adm, label='Fee Calculator', icon='fa-calculator', display_order=3, status='active' WHERE url='fee-calculator.php' AND parent_id IS NOT NULL;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Fee Calculator', 'fa-calculator', 'fee-calculator.php', @adm, 0, 3, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE url='fee-calculator.php' AND parent_id IS NOT NULL);
UPDATE menu_items SET parent_id=@adm, label='Scholarships', icon='fa-award', display_order=4, status='active' WHERE url='scholarships.php' AND parent_id IS NOT NULL;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Scholarships', 'fa-award', 'scholarships.php', @adm, 0, 4, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE url='scholarships.php' AND parent_id IS NOT NULL);
UPDATE menu_items SET parent_id=@adm, label='Downloads', icon='fa-download', display_order=5, status='active' WHERE url='downloads.php' AND parent_id IS NOT NULL;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Downloads', 'fa-download', 'downloads.php', @adm, 0, 5, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE url='downloads.php' AND parent_id IS NOT NULL);
UPDATE menu_items SET parent_id=@adm, label='Notifications', icon='fa-bullhorn', display_order=6, status='active' WHERE url='notifications.php' AND parent_id IS NOT NULL;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Notifications', 'fa-bullhorn', 'notifications.php', @adm, 0, 6, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE url='notifications.php' AND parent_id IS NOT NULL);

UPDATE menu_items SET parent_id=@inst, label='Our Networks', icon='fa-diagram-project', display_order=1, status='active' WHERE url='our-networks.php' AND parent_id IS NOT NULL;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Our Networks', 'fa-diagram-project', 'our-networks.php', @inst, 0, 1, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE url='our-networks.php' AND parent_id IS NOT NULL);
UPDATE menu_items SET parent_id=@inst, label='Our Projects', icon='fa-lightbulb', display_order=2, status='active' WHERE url='our-projects.php' AND parent_id IS NOT NULL;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Our Projects', 'fa-lightbulb', 'our-projects.php', @inst, 0, 2, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE url='our-projects.php' AND parent_id IS NOT NULL);
UPDATE menu_items SET parent_id=@inst, label='Welfare Foundation', icon='fa-hand-holding-heart', display_order=3, status='active' WHERE url='foundation.php' AND parent_id IS NOT NULL;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Welfare Foundation', 'fa-hand-holding-heart', 'foundation.php', @inst, 0, 3, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE url='foundation.php' AND parent_id IS NOT NULL);

UPDATE menu_items SET parent_id=@life, label='Extra-Curricular Activities', icon='fa-star', display_order=1, status='active' WHERE url='activities.php' AND parent_id IS NOT NULL;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Extra-Curricular Activities', 'fa-star', 'activities.php', @life, 0, 1, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE url='activities.php' AND parent_id IS NOT NULL);
UPDATE menu_items SET parent_id=@life, label='Events', icon='fa-calendar-alt', display_order=2, status='active' WHERE url='events.php' AND parent_id IS NOT NULL;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Events', 'fa-calendar-alt', 'events.php', @life, 0, 2, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE url='events.php' AND parent_id IS NOT NULL);
UPDATE menu_items SET parent_id=@life, label='News', icon='fa-newspaper', display_order=3, status='active' WHERE url='news.php' AND parent_id IS NOT NULL;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'News', 'fa-newspaper', 'news.php', @life, 0, 3, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE url='news.php' AND parent_id IS NOT NULL);
UPDATE menu_items SET parent_id=@life, label='Gallery', icon='fa-images', display_order=4, status='active' WHERE url='gallery.php' AND parent_id IS NOT NULL;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Gallery', 'fa-images', 'gallery.php', @life, 0, 4, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE url='gallery.php' AND parent_id IS NOT NULL);
UPDATE menu_items SET parent_id=@life, label='Campus Portal', icon='fa-sign-in-alt', display_order=5, status='active' WHERE url='campus-portal.php' AND parent_id IS NOT NULL;
INSERT INTO menu_items (label, icon, url, parent_id, open_new_tab, display_order, status) SELECT 'Campus Portal', 'fa-sign-in-alt', 'campus-portal.php', @life, 0, 5, 'active' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE url='campus-portal.php' AND parent_id IS NOT NULL);

-- 4. Retire the old top-level Campuses item (its links now live under About / Student Life).
--    Any other custom links still under it are moved to About so nothing disappears.
SET @campuses_top = (SELECT id FROM menu_items WHERE parent_id IS NULL AND url='campuses.php' ORDER BY id LIMIT 1);
UPDATE menu_items SET parent_id=@about WHERE parent_id=@campuses_top;
UPDATE menu_items SET status='inactive' WHERE id=@campuses_top;
