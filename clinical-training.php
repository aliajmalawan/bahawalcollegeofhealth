<?php
require_once 'includes/config.php';
$page_title = 'Clinical Training & Hospital Network';
$page_description = 'Explore the hospital network and clinical training partnerships that give Bahawal College of Health Sciences students hands-on experience.';

$partners = [];
$pr = mysqli_query($conn, "SELECT * FROM clinical_partners WHERE status='active' ORDER BY display_order ASC, id ASC");
if ($pr && mysqli_num_rows($pr) > 0) {
    while ($row = mysqli_fetch_assoc($pr)) {
        $partners[] = $row;
    }
}
$has_partners = count($partners) > 0;
?>
<?php include 'includes/header.php'; ?>

<style>
/* ===== CLINICAL TRAINING PAGE ===== */

/* --- Hero --- */
.ct2-hero {
    background: linear-gradient(135deg,#0D1048 0%,#17165B 55%,#0D1048 100%);
    padding: 62px 0 50px;
    position: relative; overflow: hidden;
}
.ct2-hero::after {
    content:'';
    position:absolute; bottom:-1px; left:0; right:0;
    height:40px;
    background:#F5F9FC;
    clip-path:ellipse(55% 100% at 50% 100%);
}
.ct2-breadcrumb {
    display:flex; align-items:center; gap:8px;
    font-size:12px; color:rgba(255,255,255,0.5); margin-bottom:18px;
    position:relative; z-index:1;
}
.ct2-breadcrumb a { color:rgba(255,255,255,0.6); text-decoration:none; }
.ct2-breadcrumb a:hover { color:var(--accent-color); }
.ct2-hero-badge {
    display:inline-flex; align-items:center; gap:7px;
    background:rgba(9,169,217,0.14); border:1px solid rgba(9,169,217,0.35);
    color:var(--accent-color); padding:6px 18px; border-radius:50px;
    font-size:10.5px; font-weight:700; letter-spacing:2px;
    text-transform:uppercase; margin-bottom:16px;
    position:relative; z-index:1;
}
.ct2-hero h1 {
    font-size:38px; font-weight:800; color:#fff;
    margin:0 0 12px; line-height:1.15;
    position:relative; z-index:1;
}
.ct2-hero h1 span { color:var(--accent-color); }
.ct2-hero p {
    color:rgba(255,255,255,0.72); font-size:15px; margin:0; max-width:560px; line-height:1.7;
    position:relative; z-index:1;
}

/* --- Section header --- */
.ct2-section { padding:56px 0 64px; background:#F5F9FC; }
.ct2-sh { text-align:center; margin-bottom:40px; }
.ct2-sh-badge {
    display:inline-flex; align-items:center; gap:7px;
    background:rgba(23,22,91,0.08); border:1px solid rgba(23,22,91,0.22);
    color:var(--primary-color); padding:6px 16px; border-radius:50px;
    font-size:10.5px; font-weight:700; letter-spacing:2px;
    text-transform:uppercase; margin-bottom:12px;
}
.ct2-sh h2 { font-size:28px; font-weight:800; color:var(--text-dark); margin:0 0 8px; }
.ct2-sh h2 span { color:var(--primary-color); }
.ct2-sh p { color:var(--text-light); font-size:14px; margin:0 auto; max-width:520px; }

/* --- Partner cards --- */
.ct2-grid { display:grid; grid-template-columns:repeat(2,1fr); gap:24px; }
@media (max-width:900px) { .ct2-grid { grid-template-columns:1fr; } }

.ct2-card {
    background:#fff; border-radius:18px;
    border:1px solid rgba(23,22,91,0.1);
    overflow:hidden;
    display:flex; flex-direction:column;
    transition:transform 0.3s ease, box-shadow 0.3s ease;
}
.ct2-card:hover { transform:translateY(-5px); box-shadow:0 16px 40px rgba(23,22,91,0.12); }

.ct2-card-head {
    display:flex; align-items:center; gap:14px;
    padding:20px 22px;
    background:linear-gradient(135deg,var(--primary-color),#0D1048);
}
.ct2-card-logo {
    width:52px; height:52px; border-radius:12px;
    background:rgba(255,255,255,0.12);
    display:flex; align-items:center; justify-content:center;
    flex-shrink:0; overflow:hidden;
}
.ct2-card-logo img { width:100%; height:100%; object-fit:cover; }
.ct2-card-logo i { color:#fff; font-size:22px; }
.ct2-card-head h3 { color:#fff; font-size:16px; font-weight:800; margin:0 0 3px; line-height:1.3; }
.ct2-card-head .ct2-loc { color:rgba(255,255,255,0.7); font-size:12px; display:flex; align-items:center; gap:5px; }

.ct2-card-body { padding:18px 22px 22px; flex:1; display:flex; flex-direction:column; gap:14px; }
.ct2-card-body p.ct2-desc { color:var(--text-light); font-size:13px; line-height:1.7; margin:0; }

.ct2-subhead {
    font-size:11px; font-weight:700; letter-spacing:0.8px; text-transform:uppercase;
    color:var(--primary-color); margin:0 0 8px;
}
.ct2-list { display:flex; flex-direction:column; gap:6px; }
.ct2-list-item {
    display:flex; align-items:flex-start; gap:8px;
    font-size:12.5px; color:var(--text-dark); line-height:1.5;
}
.ct2-list-item i { color:var(--accent-color); font-size:11px; margin-top:3px; flex-shrink:0; }

.ct2-tags { display:flex; flex-wrap:wrap; gap:7px; }
.ct2-tag {
    background:rgba(9,169,217,0.08); border:1px solid rgba(9,169,217,0.25);
    color:#078FB8; padding:4px 11px; border-radius:6px;
    font-size:11.5px; font-weight:600;
}

.ct2-card-foot {
    padding:0 22px 20px; margin-top:auto;
}
.ct2-website {
    display:inline-flex; align-items:center; gap:6px;
    color:var(--primary-color); font-size:12.5px; font-weight:700;
    text-decoration:none;
}
.ct2-website:hover { color:var(--accent-color); }

/* --- Empty state --- */
.ct2-empty {
    grid-column:1/-1;
    text-align:center; padding:60px 30px;
    background:#fff; border-radius:18px; border:1px solid rgba(23,22,91,0.1);
}
.ct2-empty i { font-size:48px; color:var(--border-color); margin-bottom:16px; display:block; }
.ct2-empty h3 { color:var(--text-dark); font-size:18px; margin:0 0 8px; }
.ct2-empty p { color:var(--text-light); font-size:13.5px; margin:0; max-width:420px; margin:0 auto; }
</style>

<!-- HERO -->
<section class="ct2-hero">
    <div class="container" style="position:relative;z-index:2;">
        <div class="ct2-breadcrumb">
            <a href="index.php"><i class="fas fa-home" style="font-size:11px;"></i> Home</a>
            <span><i class="fas fa-chevron-right" style="font-size:9px;"></i></span>
            <span>Clinical Training</span>
        </div>
        <div class="ct2-hero-badge">
            <i class="fas fa-hospital"></i> Hospital Network
        </div>
        <h1>Clinical Training &amp; <span>Hospital Network</span></h1>
        <p>Hands-on clinical exposure is central to health sciences education. Below are the hospitals and clinical facilities we have a verified training partnership with.</p>
    </div>
</section>

<!-- PARTNERS -->
<section class="ct2-section">
    <div class="container">
        <div class="ct2-sh">
            <div class="ct2-sh-badge"><i class="fas fa-hand-holding-medical" style="font-size:9px;"></i> Our Partners</div>
            <h2>Verified Clinical <span>Training Partners</span></h2>
            <p>Real hospitals and facilities where our students gain practical, supervised clinical experience.</p>
        </div>

        <div class="ct2-grid">
            <?php if ($has_partners): ?>
                <?php foreach ($partners as $p):
                    $facilities = array_values(array_filter(array_map('trim', explode("\n", $p['facilities'] ?? ''))));
                    $programs   = array_values(array_filter(array_map('trim', explode("\n", $p['programs'] ?? ''))));
                ?>
                <div class="ct2-card">
                    <div class="ct2-card-head">
                        <div class="ct2-card-logo">
                            <?php if (!empty($p['logo'])): ?>
                                <img src="<?php echo htmlspecialchars($p['logo']); ?>" alt="<?php echo htmlspecialchars($p['hospital_name']); ?>" loading="lazy">
                            <?php else: ?>
                                <i class="fas fa-hospital"></i>
                            <?php endif; ?>
                        </div>
                        <div>
                            <h3><?php echo htmlspecialchars($p['hospital_name']); ?></h3>
                            <?php if (!empty($p['location'])): ?>
                            <div class="ct2-loc"><i class="fas fa-location-dot"></i> <?php echo htmlspecialchars($p['location']); ?></div>
                            <?php endif; ?>
                        </div>
                    </div>
                    <div class="ct2-card-body">
                        <?php if (!empty($p['description'])): ?>
                        <p class="ct2-desc"><?php echo htmlspecialchars($p['description']); ?></p>
                        <?php endif; ?>

                        <?php if (!empty($facilities)): ?>
                        <div>
                            <div class="ct2-subhead">Training Facilities</div>
                            <div class="ct2-list">
                                <?php foreach ($facilities as $f): ?>
                                <div class="ct2-list-item"><i class="fas fa-check-circle"></i> <?php echo htmlspecialchars($f); ?></div>
                                <?php endforeach; ?>
                            </div>
                        </div>
                        <?php endif; ?>

                        <?php if (!empty($programs)): ?>
                        <div>
                            <div class="ct2-subhead">Relevant Programs</div>
                            <div class="ct2-tags">
                                <?php foreach ($programs as $prog): ?>
                                <span class="ct2-tag"><?php echo htmlspecialchars($prog); ?></span>
                                <?php endforeach; ?>
                            </div>
                        </div>
                        <?php endif; ?>
                    </div>
                    <?php if (!empty($p['website'])): ?>
                    <div class="ct2-card-foot">
                        <a href="<?php echo htmlspecialchars($p['website']); ?>" target="_blank" rel="noopener" class="ct2-website">
                            Visit Website <i class="fas fa-arrow-up-right-from-square" style="font-size:10px;"></i>
                        </a>
                    </div>
                    <?php endif; ?>
                </div>
                <?php endforeach; ?>
            <?php else: ?>
                <div class="ct2-empty">
                    <i class="fas fa-hospital"></i>
                    <h3>Clinical Training Network — Coming Soon</h3>
                    <p>We're finalizing our verified hospital and clinical training partnerships. This page will list them here as they're confirmed.</p>
                </div>
            <?php endif; ?>
        </div>
    </div>
</section>

<?php include 'includes/footer.php'; ?>
