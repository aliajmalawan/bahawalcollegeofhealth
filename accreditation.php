<?php
require_once 'includes/config.php';
$page_title = 'Affiliations & Accreditation';
$page_description = 'Affiliation and accreditation records of Bahawal College of Health Sciences, including status, related programs and validity.';

$records = [];
$rr = mysqli_query($conn, "SELECT * FROM accreditations WHERE visibility='active' ORDER BY display_order ASC, id ASC");
if ($rr) {
    while ($row = mysqli_fetch_assoc($rr)) {
        $records[] = $row;
    }
}
$has_records = count($records) > 0;
$today = date('Y-m-d');

// A record whose validity date has passed is never shown as current, whatever its saved status
foreach ($records as &$rec) {
    $rec['_lapsed'] = !empty($rec['valid_until']) && $rec['valid_until'] < $today && in_array($rec['status'], ['accredited', 'provisional'], true);
    $rec['_status'] = $rec['_lapsed'] ? 'expired' : $rec['status'];
}
unset($rec);

// Program affiliations already recorded on each program (AdminCP > Academics > Courses),
// shown so this page agrees with the program pages. Skipped when an accreditation
// record above already covers the same organization.
$program_affiliations = [];
$pa = mysqli_query($conn, "SELECT id, name, affiliation FROM courses WHERE status='active' AND affiliation IS NOT NULL AND TRIM(affiliation) <> '' ORDER BY display_order ASC, name ASC");
if ($pa) {
    $orgs = array_map(function ($r) { return strtolower(trim($r['organization_name'])); }, $records);
    while ($row = mysqli_fetch_assoc($pa)) {
        $aff = trim($row['affiliation']);
        $covered = false;
        foreach ($orgs as $o) {
            if ($o !== '' && (stripos($aff, $o) !== false || stripos($o, strtolower($aff)) !== false)) { $covered = true; break; }
        }
        if (!$covered) $program_affiliations[$aff][] = $row;
    }
}

// Admin-editable page text (AdminCP > Affiliations & Accreditation > Page Text)
$acc_intro = getSetting('acc_intro_text', 'Our affiliation and accreditation status with regulatory bodies, councils and academic institutions — shown transparently, including records still pending or under review.');
$acc_placeholder_title = getSetting('acc_placeholder_title', 'Accreditation Records — To Be Published');
$acc_placeholder_text = getSetting('acc_placeholder_text', 'Details of our affiliations and accreditation will be published here once they have been confirmed by the college administration.');

function accUrl($url) {
    $url = trim((string) $url);
    return preg_match('#^https?://[^\s]+$#i', $url) ? $url : '';
}

$status_meta = [
    'accredited'  => ['label' => 'Accredited',            'color' => '#16A34A', 'bg' => 'rgba(22,163,74,0.1)',  'icon' => 'fa-circle-check'],
    'provisional' => ['label' => 'Provisional',            'color' => '#F59E0B', 'bg' => 'rgba(245,158,11,0.1)', 'icon' => 'fa-triangle-exclamation'],
    'pending'     => ['label' => 'Pending / Under Review', 'color' => '#09A9D9', 'bg' => 'rgba(9,169,217,0.1)',  'icon' => 'fa-hourglass-half'],
    'expired'     => ['label' => 'Expired',                'color' => '#DC2626', 'bg' => 'rgba(220,38,38,0.1)',  'icon' => 'fa-circle-xmark'],
];
?>
<?php include 'includes/header.php'; ?>

<style>
/* ===== AFFILIATIONS & ACCREDITATION PAGE ===== */

/* --- Hero --- */
.acc-hero {
    background: linear-gradient(135deg,#0D1048 0%,#17165B 55%,#0D1048 100%);
    padding: 62px 0 50px;
    position: relative; overflow: hidden;
}
.acc-hero::after {
    content:'';
    position:absolute; bottom:-1px; left:0; right:0;
    height:40px;
    background:#F5F9FC;
    clip-path:ellipse(55% 100% at 50% 100%);
}
.acc-breadcrumb {
    display:flex; align-items:center; gap:8px;
    font-size:12px; color:rgba(255,255,255,0.5); margin-bottom:18px;
    position:relative; z-index:1;
}
.acc-breadcrumb a { color:rgba(255,255,255,0.6); text-decoration:none; }
.acc-breadcrumb a:hover { color:var(--accent-color); }
.acc-hero-badge {
    display:inline-flex; align-items:center; gap:7px;
    background:rgba(9,169,217,0.14); border:1px solid rgba(9,169,217,0.35);
    color:var(--accent-color); padding:6px 18px; border-radius:50px;
    font-size:10.5px; font-weight:700; letter-spacing:2px;
    text-transform:uppercase; margin-bottom:16px;
    position:relative; z-index:1;
}
.acc-hero h1 {
    font-size:38px; font-weight:800; color:#fff;
    margin:0 0 12px; line-height:1.15;
    position:relative; z-index:1;
}
.acc-hero h1 span { color:var(--accent-color); }
.acc-hero p {
    color:rgba(255,255,255,0.72); font-size:15px; margin:0; max-width:600px; line-height:1.7;
    position:relative; z-index:1;
}

/* --- Section --- */
.acc-section { padding:52px 0 64px; background:#F5F9FC; }

/* --- Status legend --- */
.acc-legend { display:flex; flex-wrap:wrap; gap:10px; justify-content:center; margin-bottom:40px; }
.acc-legend-item {
    display:inline-flex; align-items:center; gap:7px;
    padding:6px 14px; border-radius:20px;
    font-size:11.5px; font-weight:700;
}
.acc-legend-item i { font-size:10px; }

/* --- Cards --- */
.acc-grid { display:grid; grid-template-columns:repeat(2,1fr); gap:24px; }
@media (max-width:900px) { .acc-grid { grid-template-columns:1fr; } }

.acc-card {
    background:#fff; border-radius:16px; border:1px solid rgba(23,22,91,0.1);
    padding:24px 26px; display:flex; gap:18px;
    transition:transform 0.3s ease, box-shadow 0.3s ease;
}
.acc-card:hover { transform:translateY(-4px); box-shadow:0 14px 36px rgba(23,22,91,0.1); }

.acc-card-logo {
    width:58px; height:58px; border-radius:14px; flex-shrink:0;
    background:rgba(23,22,91,0.06);
    display:flex; align-items:center; justify-content:center; overflow:hidden;
}
.acc-card-logo img { width:100%; height:100%; object-fit:cover; }
.acc-card-logo i { color:var(--primary-color); font-size:22px; }

.acc-card-body { flex:1; min-width:0; }
.acc-card-top { display:flex; align-items:flex-start; justify-content:space-between; gap:10px; flex-wrap:wrap; margin-bottom:6px; }
.acc-org { font-size:15.5px; font-weight:800; color:var(--text-dark); line-height:1.35; }
.acc-title { font-size:12.5px; color:var(--text-light); margin:2px 0 8px; }
.acc-status-pill { display:inline-flex; align-items:center; gap:6px; padding:4px 11px; border-radius:20px; font-size:10.5px; font-weight:700; white-space:nowrap; }

.acc-program-tag {
    display:inline-block; background:rgba(9,169,217,0.08); border:1px solid rgba(9,169,217,0.25);
    color:#078FB8; padding:3px 10px; border-radius:6px; font-size:11px; font-weight:600; margin-bottom:10px;
}

.acc-desc { color:var(--text-light); font-size:12.5px; line-height:1.7; margin:0 0 10px; }

.acc-validity {
    display:flex; align-items:center; gap:6px;
    font-size:11.5px; color:var(--text-dark); font-weight:600;
    margin-bottom:8px;
}
.acc-validity i { color:var(--accent-color); font-size:11px; }

.acc-website {
    display:inline-flex; align-items:center; gap:6px;
    color:var(--primary-color); font-size:12px; font-weight:700; text-decoration:none;
}
.acc-website:hover { color:var(--accent-color); }

/* --- CMS-ready placeholder / empty state --- */
.acc-placeholder {
    grid-column:1/-1;
    text-align:center; padding:60px 30px;
    background:#fff; border-radius:18px; border:1px dashed rgba(23,22,91,0.25);
}
.acc-placeholder i { font-size:44px; color:var(--border-color); margin-bottom:16px; display:block; }
.acc-placeholder h3 { color:var(--text-dark); font-size:18px; margin:0 0 8px; }
.acc-placeholder p { color:var(--text-light); font-size:13.5px; margin:0 auto; max-width:460px; line-height:1.7; }

.acc-validity.acc-lapsed { color:#DC2626; }
.acc-note { text-align:center; font-size:12px; color:var(--text-light); max-width:680px; margin:30px auto 0; line-height:1.7; }
.acc-note i { color:var(--primary-color); }
.acc-progaff { margin-top:46px; }
.acc-progaff-head { text-align:center; margin-bottom:22px; }
.acc-progaff-head h2 { font-size:22px; font-weight:800; color:var(--text-dark); margin:0 0 6px; }
.acc-progaff-head p { font-size:13.5px; color:var(--text-light); margin:0 auto; max-width:560px; }
.acc-progaff-grid { display:grid; grid-template-columns:repeat(auto-fill,minmax(300px,1fr)); gap:16px; }
.acc-progaff-card { background:#fff; border:1px solid rgba(23,22,91,0.1); border-radius:16px; padding:18px 20px; display:flex; gap:14px; }
.acc-progaff-ico { width:44px; height:44px; border-radius:12px; background:rgba(23,22,91,0.08); color:var(--primary-color); display:flex; align-items:center; justify-content:center; font-size:18px; flex-shrink:0; }
.acc-progaff-card h4 { margin:0 0 4px; font-size:14.5px; font-weight:800; color:var(--text-dark); line-height:1.35; }
.acc-progaff-card small { display:block; font-size:11px; color:var(--text-light); text-transform:uppercase; letter-spacing:0.6px; font-weight:700; margin-bottom:6px; }
.acc-progaff-card a { display:inline-block; font-size:12px; font-weight:600; color:#078FB8; background:rgba(9,169,217,0.08); border:1px solid rgba(9,169,217,0.22); border-radius:6px; padding:2px 9px; margin:3px 4px 0 0; text-decoration:none; }
.acc-progaff-card a:hover { background:rgba(9,169,217,0.15); }
</style>

<!-- HERO -->
<section class="acc-hero">
    <div class="container" style="position:relative;z-index:2;">
        <div class="acc-breadcrumb">
            <a href="index.php"><i class="fas fa-home" style="font-size:11px;"></i> Home</a>
            <span><i class="fas fa-chevron-right" style="font-size:9px;"></i></span>
            <span>Affiliations &amp; Accreditation</span>
        </div>
        <div class="acc-hero-badge">
            <i class="fas fa-certificate"></i> Transparency
        </div>
        <h1>Affiliations &amp; <span>Accreditation</span></h1>
        <p><?php echo htmlspecialchars($acc_intro); ?></p>
    </div>
</section>

<!-- RECORDS -->
<section class="acc-section">
    <div class="container">

        <?php if ($has_records): ?>
        <div class="acc-legend">
            <?php $used = array_unique(array_column($records, '_status')); foreach ($status_meta as $sk => $meta): if (!in_array($sk, $used, true)) continue; ?>
            <span class="acc-legend-item" style="background:<?php echo $meta['bg']; ?>;color:<?php echo $meta['color']; ?>;"><i class="fas <?php echo $meta['icon']; ?>"></i> <?php echo $meta['label']; ?></span>
            <?php endforeach; ?>
        </div>
        <?php endif; ?>

        <div class="acc-grid">
            <?php if ($has_records): ?>
                <?php foreach ($records as $r):
                    $meta = $status_meta[$r['_status']] ?? $status_meta['pending'];
                    $validity_text = '';
                    $fmt = function ($d) { return date('d M Y', strtotime($d)); };
                    if ($r['status'] === 'pending') {
                        $validity_text = 'Application under review';
                    } elseif ($r['_lapsed']) {
                        $validity_text = 'Validity ended on ' . $fmt($r['valid_until']) . ' — renewal status to be confirmed';
                    } elseif (!empty($r['valid_from']) && !empty($r['valid_until'])) {
                        $validity_text = 'Valid: ' . $fmt($r['valid_from']) . ' – ' . $fmt($r['valid_until']);
                    } elseif (!empty($r['valid_until'])) {
                        $validity_text = 'Valid until ' . $fmt($r['valid_until']);
                    } elseif (!empty($r['valid_from'])) {
                        $validity_text = 'Valid from ' . $fmt($r['valid_from']);
                    }
                    $site = accUrl($r['website']);
                ?>
                <div class="acc-card">
                    <div class="acc-card-logo">
                        <?php if (!empty($r['logo'])): ?>
                            <img src="<?php echo htmlspecialchars($r['logo']); ?>" alt="<?php echo htmlspecialchars($r['organization_name']); ?>" loading="lazy">
                        <?php else: ?>
                            <i class="fas fa-certificate"></i>
                        <?php endif; ?>
                    </div>
                    <div class="acc-card-body">
                        <div class="acc-card-top">
                            <div>
                                <div class="acc-org"><?php echo htmlspecialchars($r['organization_name']); ?></div>
                                <?php if (!empty($r['title'])): ?>
                                <div class="acc-title"><?php echo htmlspecialchars($r['title']); ?></div>
                                <?php endif; ?>
                            </div>
                            <span class="acc-status-pill" style="background:<?php echo $meta['bg']; ?>;color:<?php echo $meta['color']; ?>;"><i class="fas <?php echo $meta['icon']; ?>"></i> <?php echo $meta['label']; ?></span>
                        </div>

                        <?php if (!empty($r['program'])): ?>
                        <div><span class="acc-program-tag"><?php echo htmlspecialchars($r['program']); ?></span></div>
                        <?php endif; ?>

                        <?php if (!empty($r['description'])): ?>
                        <p class="acc-desc"><?php echo nl2br(htmlspecialchars($r['description'])); ?></p>
                        <?php endif; ?>

                        <?php if ($validity_text): ?>
                        <div class="acc-validity<?php echo $r['_lapsed'] ? ' acc-lapsed' : ''; ?>"><i class="fas <?php echo $r['_lapsed'] ? 'fa-calendar-xmark' : 'fa-calendar-check'; ?>"></i> <?php echo htmlspecialchars($validity_text); ?></div>
                        <?php endif; ?>

                        <?php if ($site): ?>
                        <a href="<?php echo htmlspecialchars($site); ?>" target="_blank" rel="noopener" class="acc-website">Verify / View Source <i class="fas fa-arrow-up-right-from-square" style="font-size:9px;"></i></a>
                        <?php endif; ?>
                    </div>
                </div>
                <?php endforeach; ?>
            <?php elseif (!$program_affiliations): ?>
                <div class="acc-placeholder">
                    <i class="fas fa-certificate"></i>
                    <h3><?php echo htmlspecialchars($acc_placeholder_title); ?></h3>
                    <p><?php echo nl2br(htmlspecialchars($acc_placeholder_text)); ?></p>
                </div>
            <?php endif; ?>
        </div>

        <?php if ($program_affiliations): ?>
        <div class="acc-progaff">
            <div class="acc-progaff-head">
                <h2>Program <span style="color:var(--primary-color);">Affiliations</span></h2>
                <p>University affiliations as listed for each of our programs.</p>
            </div>
            <div class="acc-progaff-grid">
                <?php foreach ($program_affiliations as $aff => $progs): ?>
                <div class="acc-progaff-card">
                    <div class="acc-progaff-ico"><i class="fas fa-building-columns"></i></div>
                    <div>
                        <small>Affiliated with</small>
                        <h4><?php echo htmlspecialchars($aff); ?></h4>
                        <?php foreach ($progs as $pg): ?><a href="course.php?id=<?php echo (int) $pg['id']; ?>"><?php echo htmlspecialchars($pg['name']); ?></a><?php endforeach; ?>
                    </div>
                </div>
                <?php endforeach; ?>
            </div>
        </div>
        <?php endif; ?>

        <?php if ($has_records || $program_affiliations): ?>
        <p class="acc-note"><i class="fas fa-circle-info"></i> Only records confirmed by the college administration are listed. For verification, please contact the college or the relevant organization directly.</p>
        <?php endif; ?>
    </div>
</section>

<?php include 'includes/footer.php'; ?>
