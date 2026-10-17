<?php
require_once 'includes/config.php';
$page_title = 'Clinical Training & Hospital Network';
$page_description = 'Explore the hospitals and clinical training sites where Bahawal College of Health Sciences students gain supervised, hands-on clinical experience.';

$partners = [];
$pr = mysqli_query($conn, "SELECT * FROM clinical_partners WHERE status='active' ORDER BY display_order ASC, id ASC");
if ($pr && mysqli_num_rows($pr) > 0) {
    while ($row = mysqli_fetch_assoc($pr)) {
        $partners[] = $row;
    }
}
$has_partners = count($partners) > 0;

// Newline-separated admin fields -> clean list
function ctLines($text) {
    return array_values(array_filter(array_map('trim', preg_split('/\R/', (string)$text))));
}

// Prepare each card; program filter chips are built only from what admins entered.
// Training details are shown only for partnerships an admin has marked as verified.
$ct_programs = [];
$ct_verified_count = 0;
foreach ($partners as &$p) {
    $p['_facilities'] = ctLines($p['facilities'] ?? '');
    $p['_programs']   = ctLines($p['programs'] ?? '');
    $p['_verified']   = !empty($p['is_verified']);
    $p['_details']    = $p['_verified'] ? ctLines($p['training_details'] ?? '') : [];
    $p['_slugs']      = [];
    foreach ($p['_programs'] as $prog) {
        $slug = trim(strtolower(preg_replace('/[^A-Za-z0-9]+/', '-', $prog)), '-');
        if ($slug === '') continue;
        $p['_slugs'][] = $slug;
        $ct_programs[$slug] = $prog;
    }
    if ($p['_verified']) $ct_verified_count++;
}
unset($p);
asort($ct_programs, SORT_NATURAL | SORT_FLAG_CASE);
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
.ct2-hero-stats { display:flex; gap:12px; flex-wrap:wrap; margin-top:20px; position:relative; z-index:1; }
.ct2-hero-stat {
    display:inline-flex; align-items:center; gap:8px;
    background:rgba(255,255,255,0.08); border:1px solid rgba(255,255,255,0.15);
    color:rgba(255,255,255,0.85); padding:6px 14px; border-radius:50px; font-size:12.5px; font-weight:600;
}
.ct2-hero-stat strong { color:#fff; font-size:14px; }
.ct2-hero-stat i { color:var(--accent-color); }

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
.ct2-sh p { color:var(--text-light); font-size:14px; margin:0 auto; max-width:560px; line-height:1.6; }

/* --- Filter chips --- */
.ct2-filter { display:flex; flex-wrap:wrap; justify-content:center; gap:8px; margin:-14px 0 30px; }
.ct2-chip {
    padding:7px 16px; border-radius:50px; cursor:pointer;
    border:1px solid rgba(23,22,91,0.2); background:#fff;
    color:var(--text-light); font-size:12.5px; font-weight:600;
    transition:all 0.25s ease;
}
.ct2-chip:hover { border-color:var(--primary-color); color:var(--primary-color); }
.ct2-chip.active { background:var(--primary-color); border-color:var(--primary-color); color:#fff; }

/* --- Hospital cards --- */
.ct2-grid { display:grid; grid-template-columns:repeat(2,minmax(0,1fr)); gap:24px; }
@media (max-width:900px) { .ct2-grid { grid-template-columns:1fr; } }

.ct2-card {
    background:#fff; border-radius:18px;
    border:1px solid rgba(23,22,91,0.1);
    overflow:hidden;
    display:flex; flex-direction:column;
    transition:transform 0.3s ease, box-shadow 0.3s ease;
}
.ct2-card:hover { transform:translateY(-5px); box-shadow:0 16px 40px rgba(23,22,91,0.12); }

.ct2-banner {
    position:relative; height:170px;
    background:linear-gradient(135deg,var(--primary-color),#0D1048);
    display:flex; align-items:center; justify-content:center;
}
.ct2-banner img { width:100%; height:100%; object-fit:cover; display:block; }
.ct2-banner > i { color:rgba(255,255,255,0.18); font-size:64px; }
.ct2-banner::after {
    content:''; position:absolute; inset:0;
    background:linear-gradient(180deg,transparent 45%,rgba(13,16,72,0.55));
    pointer-events:none;
}
.ct2-badge {
    position:absolute; top:14px; right:14px; z-index:2;
    display:inline-flex; align-items:center; gap:6px;
    padding:5px 12px; border-radius:50px;
    font-size:10.5px; font-weight:700; letter-spacing:0.6px; text-transform:uppercase;
    background:#16A34A; color:#fff; box-shadow:0 4px 14px rgba(22,163,74,0.35);
}

.ct2-card-head { padding:0 22px; margin-top:-34px; position:relative; z-index:2; }
.ct2-card-logo {
    width:68px; height:68px; border-radius:16px;
    background:#fff; border:3px solid #fff;
    box-shadow:0 6px 18px rgba(23,22,91,0.18);
    display:flex; align-items:center; justify-content:center; overflow:hidden;
}
.ct2-card-logo img { width:100%; height:100%; object-fit:contain; }
.ct2-card-logo i { color:var(--primary-color); font-size:26px; }
.ct2-card-title { padding:12px 22px 0; }
.ct2-card-title h3 { color:var(--text-dark); font-size:17px; font-weight:800; margin:0 0 5px; line-height:1.3; }
.ct2-loc { color:var(--text-light); font-size:12.5px; display:flex; align-items:center; gap:6px; flex-wrap:wrap; line-height:1.5; }
.ct2-loc i { color:var(--accent-color); }

.ct2-card-body { padding:16px 22px 20px; flex:1; display:flex; flex-direction:column; gap:16px; }
.ct2-card-body p.ct2-desc { color:var(--text-light); font-size:13px; line-height:1.7; margin:0; }

.ct2-subhead {
    font-size:11px; font-weight:700; letter-spacing:0.8px; text-transform:uppercase;
    color:var(--primary-color); margin:0 0 8px; display:flex; align-items:center; gap:6px;
}
.ct2-fac { display:grid; grid-template-columns:repeat(2,minmax(0,1fr)); gap:6px 14px; }
@media (max-width:500px) { .ct2-fac { grid-template-columns:1fr; } }
.ct2-list { display:flex; flex-direction:column; gap:5px; }
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

.ct2-details {
    background:#F0FDF4; border:1px solid rgba(22,163,74,0.22);
    border-radius:12px; padding:13px 15px;
}
.ct2-details .ct2-subhead { color:#15803D; }
.ct2-details .ct2-list-item i { color:#16A34A; }

.ct2-card-foot {
    padding:14px 22px 18px; margin-top:auto;
    border-top:1px solid rgba(23,22,91,0.07);
    display:flex; gap:18px; flex-wrap:wrap;
}
.ct2-website {
    display:inline-flex; align-items:center; gap:6px;
    color:var(--primary-color); font-size:12.5px; font-weight:700;
    text-decoration:none;
}
.ct2-website:hover { color:var(--accent-color); }

.ct2-disclaimer {
    max-width:760px; margin:34px auto 0; text-align:center;
    font-size:12px; color:var(--text-light); line-height:1.7;
}
.ct2-disclaimer i { color:var(--primary-color); }
.ct2-filter-empty { grid-column:1/-1; text-align:center; color:var(--text-light); font-size:14px; padding:30px; display:none; }

/* --- Empty state --- */
.ct2-empty {
    grid-column:1/-1;
    text-align:center; padding:60px 30px;
    background:#fff; border-radius:18px; border:1px solid rgba(23,22,91,0.1);
}
.ct2-empty i { font-size:48px; color:var(--border-color); margin-bottom:16px; display:block; }
.ct2-empty h3 { color:var(--text-dark); font-size:18px; margin:0 0 8px; }
.ct2-empty p { color:var(--text-light); font-size:13.5px; margin:0; max-width:420px; margin:0 auto; }

@media (max-width:600px) {
    .ct2-hero h1 { font-size:28px; }
    .ct2-card-head, .ct2-card-title, .ct2-card-body, .ct2-card-foot { padding-left:16px; padding-right:16px; }
}
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
        <p>Hands-on clinical exposure is central to health sciences education. Explore the hospitals and clinical facilities where our students receive supervised practical training.</p>
        <?php if ($has_partners): ?>
        <div class="ct2-hero-stats">
            <span class="ct2-hero-stat"><i class="fas fa-hospital"></i> <strong><?php echo count($partners); ?></strong> Training <?php echo count($partners) === 1 ? 'Site' : 'Sites'; ?></span>
            <?php if ($ct_verified_count): ?>
            <span class="ct2-hero-stat"><i class="fas fa-circle-check"></i> <strong><?php echo $ct_verified_count; ?></strong> Verified <?php echo $ct_verified_count === 1 ? 'Partner' : 'Partners'; ?></span>
            <?php endif; ?>
        </div>
        <?php endif; ?>
    </div>
</section>

<!-- HOSPITAL LIST -->
<section class="ct2-section">
    <div class="container">
        <div class="ct2-sh">
            <div class="ct2-sh-badge"><i class="fas fa-hand-holding-medical" style="font-size:9px;"></i> Hospital List</div>
            <h2>Hospitals &amp; <span>Clinical Training Sites</span></h2>
            <p>Hospital locations, available training facilities and the programs that train at each site.<?php if ($ct_verified_count): ?> Sites marked <strong style="color:#16A34A;">Verified Partner</strong> have a partnership confirmed by the college.<?php endif; ?></p>
        </div>

        <?php if (count($ct_programs) > 1): ?>
        <div class="ct2-filter" role="group" aria-label="Filter hospitals by program">
            <button type="button" class="ct2-chip active" data-filter="all">All Programs</button>
            <?php foreach ($ct_programs as $slug => $label): ?>
            <button type="button" class="ct2-chip" data-filter="<?php echo htmlspecialchars($slug); ?>"><?php echo htmlspecialchars($label); ?></button>
            <?php endforeach; ?>
        </div>
        <?php endif; ?>

        <div class="ct2-grid" id="ct2Grid">
            <?php if ($has_partners): ?>
                <?php foreach ($partners as $p):
                    $name = htmlspecialchars($p['hospital_name']);
                    $map  = !empty($p['location']) ? 'https://www.google.com/maps/search/?api=1&query=' . rawurlencode($p['hospital_name'] . ', ' . $p['location']) : '';
                    $site = (!empty($p['website']) && preg_match('#^https?://#i', $p['website'])) ? $p['website'] : '';
                ?>
                <article class="ct2-card" data-programs="<?php echo htmlspecialchars(implode(' ', $p['_slugs'])); ?>">
                    <div class="ct2-banner">
                        <?php if (!empty($p['image'])): ?>
                            <img src="<?php echo htmlspecialchars($p['image']); ?>" alt="<?php echo $name; ?>" loading="lazy">
                        <?php else: ?>
                            <i class="fas fa-hospital" aria-hidden="true"></i>
                        <?php endif; ?>
                        <?php if ($p['_verified']): ?>
                        <span class="ct2-badge"><i class="fas fa-circle-check"></i> Verified Partner</span>
                        <?php endif; ?>
                    </div>
                    <div class="ct2-card-head">
                        <div class="ct2-card-logo">
                            <?php if (!empty($p['logo'])): ?>
                                <img src="<?php echo htmlspecialchars($p['logo']); ?>" alt="<?php echo $name; ?> logo" loading="lazy">
                            <?php else: ?>
                                <i class="fas fa-hospital"></i>
                            <?php endif; ?>
                        </div>
                    </div>
                    <div class="ct2-card-title">
                        <h3><?php echo $name; ?></h3>
                        <?php if (!empty($p['location'])): ?>
                        <div class="ct2-loc"><i class="fas fa-location-dot"></i> <span><?php echo htmlspecialchars($p['location']); ?></span></div>
                        <?php endif; ?>
                    </div>
                    <div class="ct2-card-body">
                        <?php if (!empty($p['description'])): ?>
                        <p class="ct2-desc"><?php echo nl2br(htmlspecialchars($p['description'])); ?></p>
                        <?php endif; ?>

                        <?php if (!empty($p['_facilities'])): ?>
                        <div>
                            <div class="ct2-subhead"><i class="fas fa-stethoscope"></i> Clinical Training Facilities</div>
                            <div class="ct2-fac">
                                <?php foreach ($p['_facilities'] as $f): ?>
                                <div class="ct2-list-item"><i class="fas fa-check-circle"></i> <?php echo htmlspecialchars($f); ?></div>
                                <?php endforeach; ?>
                            </div>
                        </div>
                        <?php endif; ?>

                        <?php if (!empty($p['_programs'])): ?>
                        <div>
                            <div class="ct2-subhead"><i class="fas fa-user-graduate"></i> Programs / Departments</div>
                            <div class="ct2-tags">
                                <?php foreach ($p['_programs'] as $prog): ?>
                                <span class="ct2-tag"><?php echo htmlspecialchars($prog); ?></span>
                                <?php endforeach; ?>
                            </div>
                        </div>
                        <?php endif; ?>

                        <?php if (!empty($p['_details'])): ?>
                        <div class="ct2-details">
                            <div class="ct2-subhead"><i class="fas fa-clipboard-list"></i> Training Details</div>
                            <div class="ct2-list">
                                <?php foreach ($p['_details'] as $d): ?>
                                <div class="ct2-list-item"><i class="fas fa-circle-check"></i> <?php echo htmlspecialchars($d); ?></div>
                                <?php endforeach; ?>
                            </div>
                        </div>
                        <?php endif; ?>
                    </div>
                    <?php if ($map || $site): ?>
                    <div class="ct2-card-foot">
                        <?php if ($map): ?>
                        <a href="<?php echo htmlspecialchars($map); ?>" target="_blank" rel="noopener" class="ct2-website"><i class="fas fa-map-location-dot"></i> View on Map</a>
                        <?php endif; ?>
                        <?php if ($site): ?>
                        <a href="<?php echo htmlspecialchars($site); ?>" target="_blank" rel="noopener" class="ct2-website">
                            Visit Website <i class="fas fa-arrow-up-right-from-square" style="font-size:10px;"></i>
                        </a>
                        <?php endif; ?>
                    </div>
                    <?php endif; ?>
                </article>
                <?php endforeach; ?>
                <div class="ct2-filter-empty" id="ct2FilterEmpty">No hospitals are listed for this program yet.</div>
            <?php else: ?>
                <div class="ct2-empty">
                    <i class="fas fa-hospital"></i>
                    <h3>Clinical Training Network — Coming Soon</h3>
                    <p>We're finalizing our hospital and clinical training arrangements. They will be listed here once confirmed.</p>
                </div>
            <?php endif; ?>
        </div>

        <?php if ($has_partners): ?>
        <p class="ct2-disclaimer">
            <i class="fas fa-circle-info"></i>
            Clinical placements are arranged by the college according to each program's requirements and site availability.
            For current placement details, please <a href="contact.php">contact the college</a>.
        </p>
        <?php endif; ?>
    </div>
</section>

<?php if (count($ct_programs) > 1): ?>
<script>
(function () {
    var chips = document.querySelectorAll('.ct2-chip');
    var cards = document.querySelectorAll('#ct2Grid .ct2-card');
    var empty = document.getElementById('ct2FilterEmpty');
    chips.forEach(function (chip) {
        chip.addEventListener('click', function () {
            var f = chip.dataset.filter, shown = 0;
            chips.forEach(function (c) { c.classList.toggle('active', c === chip); });
            cards.forEach(function (card) {
                var match = f === 'all' || (' ' + card.dataset.programs + ' ').indexOf(' ' + f + ' ') !== -1;
                card.style.display = match ? '' : 'none';
                if (match) shown++;
            });
            if (empty) empty.style.display = shown ? 'none' : 'block';
        });
    });
})();
</script>
<?php endif; ?>

<?php include 'includes/footer.php'; ?>
