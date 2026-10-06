<?php
/**
 * Shared AdminCP sidebar — included on every admin page so navigation stays
 * fixed and identical everywhere. Expects $conn / SITE_NAME (from config.php)
 * and an active session; highlights the current page automatically.
 */
require_once __DIR__ . '/csrf.php';
$__current_page = basename($_SERVER['SCRIPT_NAME']);

$__nav_items = [
    ['analytics.php',          'fa-chart-line',       'Website Analytics'],
    ['dashboard.php',          'fa-tachometer-alt',   'Dashboard'],
    ['manage_home.php',        'fa-home',             'Home Page'],
    ['manage_about.php',       'fa-info-circle',      'About'],
    ['manage_foundation.php',  'fa-hand-holding-heart', 'Welfare Foundation'],
    ['manage_academics.php',   'fa-graduation-cap',   'Academics'],
    ['manage_clinical_training.php', 'fa-hospital',   'Clinical Training'],
    ['manage_networks.php',    'fa-diagram-project',  'Our Networks'],
    ['manage_projects.php',    'fa-lightbulb',        'Our Projects'],
    ['manage_accreditation.php', 'fa-certificate',    'Affiliations & Accreditation'],
    ['manage_scholarships.php', 'fa-award',           'Scholarships'],
    ['manage_eligibility.php', 'fa-clipboard-check',  'Eligibility Checker'],
    ['manage_erp.php',         'fa-network-wired',    'ERP Integration'],
    ['manage_admission.php',   'fa-user-graduate',    'Admission'],
    ['manage_students.php',    'fa-id-card',          'Students'],
    ['manage_contact.php',     'fa-envelope',         'Contact'],
    ['manage_student_life.php','fa-users',            'Student Life'],
    ['manage_gallery.php',     'fa-images',           'Gallery'],
    ['menu_builder.php',       'fa-bars',             'Menu Builder'],
];
?>
<div class="sidebar">
    <div class="sidebar-header">
        <h2><?php echo htmlspecialchars(getSiteName()); ?></h2>
        <p>Admin Panel</p>
    </div>

    <div class="sidebar-menu">
        <?php foreach ($__nav_items as [$href, $icon, $label]): ?>
        <a href="<?php echo $href; ?>" class="<?php echo $__current_page === $href ? 'active' : ''; ?>">
            <i class="fas <?php echo $icon; ?>"></i>
            <span><?php echo $label; ?></span>
        </a>
        <?php endforeach; ?>
    </div>

    <div class="menu-divider"></div>

    <div class="sidebar-menu" style="padding-top: 0;">
        <a href="settings.php" class="<?php echo $__current_page === 'settings.php' ? 'active' : ''; ?>">
            <i class="fas fa-cog"></i>
            <span>Settings</span>
        </a>
        <a href="theme_manager.php" class="<?php echo $__current_page === 'theme_manager.php' ? 'active' : ''; ?>">
            <i class="fas fa-palette"></i>
            <span>Theme Manager</span>
        </a>
    </div>

    <div class="menu-divider"></div>

    <div class="logout-section">
        <a href="logout.php">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </a>
    </div>
</div>
<script>
// CSRF protection for GET-based action links (delete/toggle/approve/etc.):
// every same-page link whose href starts with "?" gets the current session's
// CSRF token appended automatically, so no individual link markup needs to
// change. Read-only navigation links (?edit=, ?tab=...) get the token too —
// harmless, since the server only checks it for actual mutating actions.
(function() {
    var token = <?php echo json_encode(csrf_token()); ?>;
    window.__CSRF_TOKEN = token;

    function rewriteLinks() {
        document.querySelectorAll('a[href^="?"]').forEach(function(a) {
            var href = a.getAttribute('href');
            if (href.indexOf('csrf_token=') !== -1) return;
            var sep = href.length > 1 ? '&' : '';
            a.setAttribute('href', href + sep + 'csrf_token=' + encodeURIComponent(token));
        });
    }
    // The sidebar (and this script) is included near the TOP of <body>, before
    // the rest of the page's own content — including the actual delete/toggle
    // links — has been parsed. Wait for the full DOM before rewriting them.
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', rewriteLinks);
    } else {
        rewriteLinks();
    }
})();
</script>
