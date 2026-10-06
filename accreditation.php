<?php
require_once 'includes/config.php';
$page_title = 'Affiliations & Accreditation';
$page_description = 'View the affiliations and accreditations held by Bahawal College of Health Sciences, recognized by leading educational and health authorities.';

$records = [];
$rr = mysqli_query($conn, "SELECT * FROM accreditations WHERE visibility='active' ORDER BY display_order ASC, id ASC");
if ($rr) {
    while ($row = mysqli_fetch_assoc($rr)) {
        $records[] = $row;
    }
}
$has_records = count($records) > 0;

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
            <i class="fas fa-certificate"></i> Verified Records
        </div>
        <h1>Affiliations &amp; <span>Accreditation</span></h1>
        <p>Our verified accreditation and affiliation status with regulatory bodies, councils and academic institutions — shown transparently, including records still pending or under review.</p>
    </div>
</section>

<!-- RECORDS -->
<section class="acc-section">
    <div class="container">

        <?php if ($has_records): ?>
        <div class="acc-legend">
            <?php foreach ($status_meta as $meta): ?>
            <span class="acc-legend-item" style="background:<?php echo $meta['bg']; ?>;color:<?php echo $meta['color']; ?>;"><i class="fas <?php echo $meta['icon']; ?>"></i> <?php echo $meta['label']; ?></span>
            <?php endforeach; ?>
        </div>
        <?php endif; ?>

        <div class="acc-grid">
            <?php if ($has_records): ?>
                <?php foreach ($records as $r):
                    $meta = $status_meta[$r['status']];
                    $validity_text = '';
                    if ($r['status'] === 'pending') {
                        $validity_text = 'Application under review';
                    } elseif (!empty($r['valid_from']) && !empty($r['valid_until'])) {
                        $validity_text = 'Valid: ' . date('M Y', strtotime($r['valid_from'])) . ' – ' . date('M Y', strtotime($r['valid_until']));
                    } elseif (!empty($r['valid_until'])) {
                        $validity_text = 'Valid until ' . date('M Y', strtotime($r['valid_until']));
                    } elseif (!empty($r['valid_from'])) {
                        $validity_text = 'Valid from ' . date('M Y', strtotime($r['valid_from']));
                    }
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
                        <p class="acc-desc"><?php echo htmlspecialchars($r['description']); ?></p>
                        <?php endif; ?>

                        <?php if ($validity_text): ?>
                        <div class="acc-validity"><i class="fas fa-calendar-check"></i> <?php echo htmlspecialchars($validity_text); ?></div>
                        <?php endif; ?>

                        <?php if (!empty($r['website'])): ?>
                        <a href="<?php echo htmlspecialchars($r['website']); ?>" target="_blank" rel="noopener" class="acc-website">Verify / View Source <i class="fas fa-arrow-up-right-from-square" style="font-size:9px;"></i></a>
                        <?php endif; ?>
                    </div>
                </div>
                <?php endforeach; ?>
            <?php else: ?>
                <div class="acc-placeholder">
                    <i class="fas fa-certificate"></i>
                    <h3>Accreditation Records — To Be Published</h3>
                    <p>This section is ready to display our verified affiliations and accreditation status. Records will appear here as they are added and confirmed by the college administration — nothing is shown until it's been verified.</p>
                </div>
            <?php endif; ?>
        </div>
    </div>
</section>

<?php include 'includes/footer.php'; ?>
