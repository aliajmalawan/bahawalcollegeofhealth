<?php
/**
 * Website setup checklist for AdminCP > Dashboard.
 * Reports (1) optional database updates that haven't been run yet and
 * (2) content that is missing or looks like placeholder/test data, each with
 * a link to the admin screen where it is fixed. Read-only — changes nothing.
 */

function getSetupChecklist($conn) {
    $one = function ($sql) use ($conn) {
        $r = mysqli_query($conn, $sql);
        $row = $r ? mysqli_fetch_row($r) : null;
        return $row ? (int) $row[0] : 0;
    };
    $tableExists = function ($t) use ($conn) {
        $r = mysqli_query($conn, "SHOW TABLES LIKE '" . mysqli_real_escape_string($conn, $t) . "'");
        return $r && mysqli_num_rows($r) > 0;
    };

    // ---------- 1. database updates ----------
    $schema = [
        'Program admission information'           => [['courses', 'admission_info']],
        'Clinical training photo, details & verified flag' => [['clinical_partners', 'image'], ['clinical_partners', 'training_details'], ['clinical_partners', 'is_verified']],
        'Eligibility passing year & requirements' => [['eligibility_rules', 'max_years_since_passing'], ['eligibility_rules', 'requirements']],
        'Admission form fields & documents'       => [['admissions', 'gender'], ['admissions', 'date_of_birth'], ['admissions', 'guardian_phone'], ['admissions', 'admission_session'], ['admissions', 'result_awaited']],
        'Foundation activity images & projects'   => [['foundation_activities', 'image'], ['projects', 'is_foundation']],
    ];
    $pending = [];
    foreach ($schema as $label => $cols) {
        foreach ($cols as $c) {
            if (!dbColumnExists($conn, $c[0], $c[1])) { $pending[] = $label; break; }
        }
    }
    if (!$tableExists('admission_documents') && !in_array('Admission form fields & documents', $pending, true)) {
        $pending[] = 'Admission form fields & documents';
    }

    // ---------- 2. content ----------
    $items = []; // [level: warn|todo, text, link]
    $add = function ($level, $text, $link) use (&$items) { $items[] = [$level, $text, $link]; };

    // Possible placeholder / test records (shown publicly)
    $ph = "('xyz','abc','test','name','n/a','na','tbd','lorem ipsum')";
    foreach (['chairman' => 'Chairman', 'principal' => 'Principal'] as $role => $label) {
        $l = getMessageLeader($role);
        if (!$l) {
            $add('todo', "No active $label in Leadership — the $label's Message page shows a placeholder.", 'manage_home.php?tab=leadership');
        } elseif (in_array(strtolower(trim($l['name'])), ['xyz', 'abc', 'test', 'name', 'n/a', 'na', 'tbd'], true) || mb_strlen(trim($l['name'])) < 3) {
            $add('warn', "$label's name is \"" . $l['name'] . "\" — this looks like a placeholder and is shown on the homepage and $label's Message page.", 'manage_home.php?tab=leadership');
        }
    }
    $r = mysqli_query($conn, "SELECT name, designation FROM faculty WHERE status='active' AND (LOWER(designation) IN ('developer','test','tester') OR LOWER(name) IN $ph OR LOWER(designation) LIKE '%test%' OR LOWER(name) LIKE 'test %')");
    if ($r) { while ($f = mysqli_fetch_assoc($r)) { $add('warn', 'Faculty member "' . $f['name'] . '" (' . ($f['designation'] ?: 'no designation') . ') may be a test record — it is shown on the public Faculty page.', 'manage_academics.php?tab=faculty'); } }

    foreach (['faculty_stat3' => 'Faculty page', 'faculty_stat4' => 'Faculty page'] as $key => $where) {
        $v = trim(getSetting($key . '_number', ''));
        if ($v !== '') $add('warn', "$where stat \"" . $v . ' ' . getSetting($key . '_label', '') . '" is shown publicly — please confirm it is accurate.', 'manage_academics.php?tab=faculty');
    }

    if (is_dir(dirname(__DIR__) . '/uploads/documents')) {
        $legacy = count(glob(dirname(__DIR__) . '/uploads/documents/*.{pdf,jpg,jpeg,png}', GLOB_BRACE) ?: []);
        if ($legacy > 0) $add('warn', "$legacy older applicant document(s) are in uploads/documents/, which can be opened by URL. New uploads are stored privately.", 'manage_admission.php?tab=applications');
    }

    // Missing content
    $courses = $one("SELECT COUNT(*) FROM courses WHERE status='active'");
    $no_fee = $one("SELECT COUNT(*) FROM courses WHERE status='active' AND admission_fee IS NULL AND initial_fee IS NULL AND semester_fee IS NULL AND total_fee IS NULL");
    if ($courses === 0) $add('todo', 'No active programs.', 'manage_academics.php?tab=courses');
    elseif ($no_fee) $add('todo', "$no_fee of $courses programs have no fees entered — they show \"contact admission office\".", 'manage_academics.php?tab=courses');
    $no_rules = $one("SELECT COUNT(*) FROM courses c WHERE c.status='active' AND NOT EXISTS (SELECT 1 FROM eligibility_rules e WHERE e.course_id = c.id AND e.status='active')");
    if ($courses && $no_rules) $add('todo', "$no_rules of $courses programs have no eligibility rules — the checker marks them \"Requires Review\".", 'manage_eligibility.php');

    if (!$one("SELECT COUNT(*) FROM faculty WHERE status='active'")) $add('todo', 'No faculty profiles published.', 'manage_academics.php?tab=faculty');
    if (!$one("SELECT COUNT(*) FROM clinical_partners WHERE status='active'")) $add('todo', 'No hospitals / clinical training sites added.', 'manage_clinical_training.php');
    if (!$one("SELECT COUNT(*) FROM accreditations WHERE visibility='active'")) $add('todo', 'No affiliation / accreditation records published.', 'manage_accreditation.php');
    if (!$one("SELECT COUNT(*) FROM scholarships WHERE status='active'")) $add('todo', 'No scholarships besides the merit formula (need-based and others).', 'manage_scholarships.php');
    if (!$one("SELECT COUNT(*) FROM network_partners WHERE status='active'")) $add('todo', 'No academic / affiliated / professional partners on Our Networks.', 'manage_networks.php');
    if (!$one("SELECT COUNT(*) FROM projects WHERE visibility='active'")) $add('todo', 'No projects on Our Projects.', 'manage_projects.php');
    if (!$one("SELECT COUNT(*) FROM events WHERE status='active'")) $add('todo', 'No extra-curricular activities / events.', 'manage_student_life.php?tab=events');
    if (!$one("SELECT COUNT(*) FROM student_societies WHERE status='active'")) $add('todo', 'No student societies.', 'manage_student_life.php?tab=societies');
    if (trim(getSetting('foundation_purpose', '')) === '' && !$one("SELECT COUNT(*) FROM foundation_activities WHERE status='active'")) $add('todo', 'Welfare Foundation page has no content yet.', 'manage_foundation.php');

    usort($items, function ($a, $b) { return ($a[0] === 'warn' ? 0 : 1) - ($b[0] === 'warn' ? 0 : 1); });
    return ['pending' => $pending, 'items' => $items];
}
