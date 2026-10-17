<?php
// Dynamically generated XML sitemap — always reflects the current domain
// via SITE_URL (see includes/config.php), so it needs no manual editing
// after deployment. Search engines fetch this at /sitemap.php; robots.txt
// points to it.
require_once 'includes/config.php';

header('Content-Type: application/xml; charset=utf-8');

$pages = [
    ['url' => 'index.php', 'priority' => '1.0', 'changefreq' => 'weekly'],
    ['url' => 'about.php', 'priority' => '0.8', 'changefreq' => 'monthly'],
    ['url' => 'mission-vision.php', 'priority' => '0.6', 'changefreq' => 'yearly'],
    ['url' => 'core-values.php', 'priority' => '0.6', 'changefreq' => 'yearly'],
    ['url' => 'leadership.php', 'priority' => '0.6', 'changefreq' => 'monthly'],
    ['url' => 'chairman-message.php', 'priority' => '0.5', 'changefreq' => 'yearly'],
    ['url' => 'principal-message.php', 'priority' => '0.5', 'changefreq' => 'yearly'],
    ['url' => 'accreditation.php', 'priority' => '0.5', 'changefreq' => 'yearly'],
    ['url' => 'foundation.php', 'priority' => '0.5', 'changefreq' => 'monthly'],
    ['url' => 'our-projects.php', 'priority' => '0.5', 'changefreq' => 'monthly'],
    ['url' => 'our-networks.php', 'priority' => '0.5', 'changefreq' => 'monthly'],
    ['url' => 'courses.php', 'priority' => '0.9', 'changefreq' => 'monthly'],
    ['url' => 'faculty.php', 'priority' => '0.8', 'changefreq' => 'monthly'],
    ['url' => 'clinical-training.php', 'priority' => '0.6', 'changefreq' => 'monthly'],
    ['url' => 'examination.php', 'priority' => '0.6', 'changefreq' => 'monthly'],
    ['url' => 'campuses.php', 'priority' => '0.7', 'changefreq' => 'monthly'],
    ['url' => 'admission.php', 'priority' => '0.9', 'changefreq' => 'monthly'],
    ['url' => 'scholarships.php', 'priority' => '0.7', 'changefreq' => 'monthly'],
    ['url' => 'fee-calculator.php', 'priority' => '0.6', 'changefreq' => 'monthly'],
    ['url' => 'eligibility-checker.php', 'priority' => '0.6', 'changefreq' => 'monthly'],
    ['url' => 'downloads.php', 'priority' => '0.5', 'changefreq' => 'monthly'],
    ['url' => 'activities.php', 'priority' => '0.6', 'changefreq' => 'monthly'],
    ['url' => 'events.php', 'priority' => '0.7', 'changefreq' => 'weekly'],
    ['url' => 'news.php', 'priority' => '0.7', 'changefreq' => 'weekly'],
    ['url' => 'notifications.php', 'priority' => '0.5', 'changefreq' => 'weekly'],
    ['url' => 'alumni.php', 'priority' => '0.6', 'changefreq' => 'monthly'],
    ['url' => 'gallery.php', 'priority' => '0.6', 'changefreq' => 'monthly'],
    ['url' => 'contact.php', 'priority' => '0.7', 'changefreq' => 'yearly'],
];

// Individual project detail pages (only those with a details write-up)
$sm_projects = mysqli_query($conn, "SELECT id FROM projects WHERE visibility='active' AND details IS NOT NULL AND TRIM(details) <> '' ORDER BY display_order ASC");
if ($sm_projects) {
    while ($row = mysqli_fetch_assoc($sm_projects)) {
        $pages[] = ['url' => 'project.php?id=' . (int)$row['id'], 'priority' => '0.6', 'changefreq' => 'monthly'];
    }
}

// Individual program detail pages
$sm_courses = mysqli_query($conn, "SELECT id FROM courses WHERE status='active' ORDER BY display_order ASC");
if ($sm_courses) {
    while ($row = mysqli_fetch_assoc($sm_courses)) {
        $pages[] = ['url' => 'course.php?id=' . (int)$row['id'], 'priority' => '0.8', 'changefreq' => 'monthly'];
    }
}

$base = rtrim(SITE_URL, '/');
echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
<?php foreach ($pages as $p): ?>
    <url>
        <loc><?php echo htmlspecialchars($base . '/' . $p['url']); ?></loc>
        <changefreq><?php echo $p['changefreq']; ?></changefreq>
        <priority><?php echo $p['priority']; ?></priority>
    </url>
<?php endforeach; ?>
</urlset>
