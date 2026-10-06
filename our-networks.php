<?php
require_once 'includes/config.php';
$page_title = 'Our Networks';
$page_description = 'See the hospitals and institutional partners in the Bahawal College of Health Sciences professional network.';

// Partner Hospitals & Clinical Training Network — reuses the same verified
// data already managed under Clinical Training (no duplicate admin entry).
$hospitals = [];
$hr = mysqli_query($conn, "SELECT * FROM clinical_partners WHERE status='active' ORDER BY display_order ASC, id ASC");
if ($hr) {
    while ($row = mysqli_fetch_assoc($hr)) {
        $hospitals[] = $row;
    }
}

// Academic Partners / Affiliated Institutions / Industry & Professional Partners
$network = ['academic' => [], 'affiliated_institution' => [], 'industry_professional' => []];
$nr = mysqli_query($conn, "SELECT * FROM network_partners WHERE status='active' ORDER BY display_order ASC, id ASC");
if ($nr) {
    while ($row = mysqli_fetch_assoc($nr)) {
        if (isset($network[$row['category']])) {
            $network[$row['category']][] = $row;
        }
    }
}

$section_meta = [
    'academic'              => ['badge' => 'Academic Network',  'title' => 'Academic <span>Partners</span>',              'sub' => 'Universities and academic bodies we work with on curriculum, examinations, or degree affiliation.', 'icon' => 'fa-building-columns', 'empty' => 'We\'re finalizing our verified academic partnerships. This section will list them here as they\'re confirmed.'],
    'affiliated_institution' => ['badge' => 'Affiliations',      'title' => 'Affiliated <span>Institutions</span>',        'sub' => 'Boards, councils and institutions we are formally affiliated or registered with.', 'icon' => 'fa-landmark', 'empty' => 'We\'re finalizing our verified institutional affiliations. This section will list them here as they\'re confirmed.'],
    'industry_professional' => ['badge' => 'Industry Network',   'title' => 'Industry &amp; <span>Professional Partners</span>', 'sub' => 'Organizations and professional bodies connected to student placement, internships or professional development.', 'icon' => 'fa-handshake', 'empty' => 'We\'re finalizing our verified industry and professional partnerships. This section will list them here as they\'re confirmed.'],
];
?>
<?php include 'includes/header.php'; ?>

<style>
/* ===== OUR NETWORKS PAGE ===== */

/* --- Hero --- */
.onw-hero {
    background: linear-gradient(135deg,#0D1048 0%,#17165B 55%,#0D1048 100%);
    padding: 62px 0 50px;
    position: relative; overflow: hidden;
}
.onw-hero::after {
    content:'';
    position:absolute; bottom:-1px; left:0; right:0;
    height:40px;
    background:#F5F9FC;
    clip-path:ellipse(55% 100% at 50% 100%);
}
.onw-breadcrumb {
    display:flex; align-items:center; gap:8px;
    font-size:12px; color:rgba(255,255,255,0.5); margin-bottom:18px;
    position:relative; z-index:1;
}
.onw-breadcrumb a { color:rgba(255,255,255,0.6); text-decoration:none; }
.onw-breadcrumb a:hover { color:var(--accent-color); }
.onw-hero-badge {
    display:inline-flex; align-items:center; gap:7px;
    background:rgba(9,169,217,0.14); border:1px solid rgba(9,169,217,0.35);
    color:var(--accent-color); padding:6px 18px; border-radius:50px;
    font-size:10.5px; font-weight:700; letter-spacing:2px;
    text-transform:uppercase; margin-bottom:16px;
    position:relative; z-index:1;
}
.onw-hero h1 {
    font-size:38px; font-weight:800; color:#fff;
    margin:0 0 12px; line-height:1.15;
    position:relative; z-index:1;
}
.onw-hero h1 span { color:var(--accent-color); }
.onw-hero p {
    color:rgba(255,255,255,0.72); font-size:15px; margin:0; max-width:600px; line-height:1.7;
    position:relative; z-index:1;
}

/* --- Section --- */
.onw-section { padding:48px 0; background:#F5F9FC; }
.onw-section.onw-alt { background:#fff; }
.onw-sh { text-align:center; margin-bottom:34px; }
.onw-sh-badge {
    display:inline-flex; align-items:center; gap:7px;
    background:rgba(23,22,91,0.08); border:1px solid rgba(23,22,91,0.22);
    color:var(--primary-color); padding:6px 16px; border-radius:50px;
    font-size:10.5px; font-weight:700; letter-spacing:2px;
    text-transform:uppercase; margin-bottom:12px;
}
.onw-sh h2 { font-size:26px; font-weight:800; color:var(--text-dark); margin:0 0 8px; }
.onw-sh h2 span { color:var(--primary-color); }
.onw-sh p { color:var(--text-light); font-size:14px; margin:0 auto; max-width:540px; }

/* --- Hospital strip (compact cards, links out to full Clinical Training page) --- */
.onw-hgrid { display:grid; grid-template-columns:repeat(3,1fr); gap:20px; }
@media (max-width:900px) { .onw-hgrid { grid-template-columns:repeat(2,1fr); } }
@media (max-width:600px) { .onw-hgrid { grid-template-columns:1fr; } }

.onw-hcard {
    background:#fff; border-radius:14px; border:1px solid rgba(23,22,91,0.1);
    padding:18px 20px; display:flex; align-items:center; gap:14px;
    transition:transform 0.3s ease, box-shadow 0.3s ease;
}
.onw-hcard:hover { transform:translateY(-3px); box-shadow:0 12px 30px rgba(23,22,91,0.1); }
.onw-hcard-logo {
    width:46px; height:46px; border-radius:10px; flex-shrink:0;
    background:rgba(23,22,91,0.08); display:flex; align-items:center; justify-content:center; overflow:hidden;
}
.onw-hcard-logo img { width:100%; height:100%; object-fit:cover; }
.onw-hcard-logo i { color:var(--primary-color); font-size:18px; }
.onw-hcard h4 { font-size:13.5px; font-weight:800; color:var(--text-dark); margin:0 0 3px; line-height:1.3; }
.onw-hcard .onw-loc { font-size:11.5px; color:var(--text-light); display:flex; align-items:center; gap:5px; }

.onw-more-link { text-align:center; margin-top:26px; }
.onw-more-link a {
    display:inline-flex; align-items:center; gap:8px;
    color:var(--primary-color); font-weight:700; font-size:13px; text-decoration:none;
}
.onw-more-link a:hover { color:var(--accent-color); }

/* --- Generic partner cards (Academic / Affiliated / Industry) --- */
.onw-grid { display:grid; grid-template-columns:repeat(3,1fr); gap:22px; }
@media (max-width:900px) { .onw-grid { grid-template-columns:repeat(2,1fr); } }
@media (max-width:600px) { .onw-grid { grid-template-columns:1fr; } }

.onw-card {
    background:#fff; border-radius:16px; border:1px solid rgba(23,22,91,0.1);
    padding:22px 22px 24px; text-align:center;
    transition:transform 0.3s ease, box-shadow 0.3s ease;
}
.onw-card:hover { transform:translateY(-4px); box-shadow:0 14px 34px rgba(23,22,91,0.1); }
.onw-card-logo {
    width:60px; height:60px; border-radius:14px; margin:0 auto 14px;
    background:linear-gradient(135deg,var(--primary-color),#0D1048);
    display:flex; align-items:center; justify-content:center; overflow:hidden;
}
.onw-card-logo img { width:100%; height:100%; object-fit:cover; }
.onw-card-logo i { color:#fff; font-size:22px; }
.onw-card h4 { font-size:14.5px; font-weight:800; color:var(--text-dark); margin:0 0 4px; }
.onw-card .onw-loc { font-size:11.5px; color:var(--text-light); margin-bottom:8px; }
.onw-card p.onw-desc { color:var(--text-light); font-size:12.5px; line-height:1.6; margin:0 0 10px; }
.onw-card a.onw-website {
    display:inline-flex; align-items:center; gap:6px;
    color:var(--primary-color); font-size:12px; font-weight:700; text-decoration:none;
}
.onw-card a.onw-website:hover { color:var(--accent-color); }

/* --- Empty state --- */
.onw-empty {
    grid-column:1/-1;
    text-align:center; padding:44px 30px;
    background:#fff; border-radius:16px; border:1px solid rgba(23,22,91,0.1);
}
.onw-alt .onw-empty { background:#F5F9FC; }
.onw-empty i { font-size:38px; color:var(--border-color); margin-bottom:14px; display:block; }
.onw-empty p { color:var(--text-light); font-size:13px; margin:0 auto; max-width:420px; }
</style>

<!-- HERO -->
<section class="onw-hero">
    <div class="container" style="position:relative;z-index:2;">
        <div class="onw-breadcrumb">
            <a href="index.php"><i class="fas fa-home" style="font-size:11px;"></i> Home</a>
            <span><i class="fas fa-chevron-right" style="font-size:9px;"></i></span>
            <span>Our Networks</span>
        </div>
        <div class="onw-hero-badge">
            <i class="fas fa-diagram-project"></i> Verified Partnerships
        </div>
        <h1>Our <span>Networks</span></h1>
        <p>Bahawal College of Health Sciences works with a verified network of hospitals, academic bodies, affiliated institutions and industry partners to support quality clinical training, education and career development.</p>
    </div>
</section>

<!-- PARTNER HOSPITALS / CLINICAL TRAINING -->
<section class="onw-section">
    <div class="container">
        <div class="onw-sh">
            <div class="onw-sh-badge"><i class="fas fa-hospital" style="font-size:9px;"></i> Partner Hospitals</div>
            <h2>Clinical Training <span>Network</span></h2>
            <p>Hospitals and clinical facilities where our students gain hands-on, supervised training.</p>
        </div>

        <?php if (count($hospitals) > 0): ?>
        <div class="onw-hgrid">
            <?php foreach ($hospitals as $h): ?>
            <div class="onw-hcard">
                <div class="onw-hcard-logo">
                    <?php if (!empty($h['logo'])): ?>
                        <img src="<?php echo htmlspecialchars($h['logo']); ?>" alt="<?php echo htmlspecialchars($h['hospital_name']); ?>" loading="lazy">
                    <?php else: ?>
                        <i class="fas fa-hospital"></i>
                    <?php endif; ?>
                </div>
                <div>
                    <h4><?php echo htmlspecialchars($h['hospital_name']); ?></h4>
                    <?php if (!empty($h['location'])): ?>
                    <div class="onw-loc"><i class="fas fa-location-dot"></i> <?php echo htmlspecialchars($h['location']); ?></div>
                    <?php endif; ?>
                </div>
            </div>
            <?php endforeach; ?>
        </div>
        <div class="onw-more-link">
            <a href="clinical-training.php">View Full Clinical Training Details <i class="fas fa-arrow-right"></i></a>
        </div>
        <?php else: ?>
        <div class="onw-hgrid">
            <div class="onw-empty">
                <i class="fas fa-hospital"></i>
                <p>We're finalizing our verified hospital and clinical training partnerships. This section will list them here as they're confirmed.</p>
            </div>
        </div>
        <?php endif; ?>
    </div>
</section>

<!-- ACADEMIC / AFFILIATED / INDUSTRY SECTIONS -->
<?php $alt = true; foreach ($network as $cat => $items): $meta = $section_meta[$cat]; $alt = !$alt; ?>
<section class="onw-section <?php echo $alt ? 'onw-alt' : ''; ?>">
    <div class="container">
        <div class="onw-sh">
            <div class="onw-sh-badge"><i class="fas <?php echo $meta['icon']; ?>" style="font-size:9px;"></i> <?php echo $meta['badge']; ?></div>
            <h2><?php echo $meta['title']; ?></h2>
            <p><?php echo $meta['sub']; ?></p>
        </div>

        <div class="onw-grid">
            <?php if (count($items) > 0): ?>
                <?php foreach ($items as $p): ?>
                <div class="onw-card">
                    <div class="onw-card-logo">
                        <?php if (!empty($p['logo'])): ?>
                            <img src="<?php echo htmlspecialchars($p['logo']); ?>" alt="<?php echo htmlspecialchars($p['name']); ?>" loading="lazy">
                        <?php else: ?>
                            <i class="fas <?php echo $meta['icon']; ?>"></i>
                        <?php endif; ?>
                    </div>
                    <h4><?php echo htmlspecialchars($p['name']); ?></h4>
                    <?php if (!empty($p['location'])): ?>
                    <div class="onw-loc"><i class="fas fa-location-dot"></i> <?php echo htmlspecialchars($p['location']); ?></div>
                    <?php endif; ?>
                    <?php if (!empty($p['description'])): ?>
                    <p class="onw-desc"><?php echo htmlspecialchars($p['description']); ?></p>
                    <?php endif; ?>
                    <?php if (!empty($p['website'])): ?>
                    <a href="<?php echo htmlspecialchars($p['website']); ?>" target="_blank" rel="noopener" class="onw-website">Visit Website <i class="fas fa-arrow-up-right-from-square" style="font-size:9px;"></i></a>
                    <?php endif; ?>
                </div>
                <?php endforeach; ?>
            <?php else: ?>
                <div class="onw-empty">
                    <i class="fas <?php echo $meta['icon']; ?>"></i>
                    <p><?php echo $meta['empty']; ?></p>
                </div>
            <?php endif; ?>
        </div>
    </div>
</section>
<?php endforeach; ?>

<?php include 'includes/footer.php'; ?>
