<?php
require_once 'includes/config.php';
$page_title = 'Our Campuses';
$page_description = 'Find Bahawal College of Health Sciences campus locations across Pakistan, complete with addresses, contact numbers and directions.';

$campuses = getCampuses();
$main_campus = getMainCampus();
$camp_stats = getCampusStats();
?>
<?php include 'includes/header.php'; ?>

<style>
/* ===== CAMPUSES PAGE ===== */
:root {
    --primary-color: #17165B;
    --accent-color:  #09A9D9;
    --text-dark:     #1F2937;
    --bg-light:      #EAF7FB;
}

/* --- Hero --- */
.camp-hero {
    background: linear-gradient(135deg,#0D1048 0%,#17165B 55%,#0D1048 100%);
    padding: 62px 0 50px;
    position: relative; overflow: hidden;
}
.camp-hero::before {
    content:'';
    position:absolute; inset:0;
    background:url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none'%3E%3Cg fill='%23ffffff' fill-opacity='0.03'%3E%3Ccircle cx='30' cy='30' r='20'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
    pointer-events:none;
}
.camp-hero::after {
    content:'';
    position:absolute; bottom:-1px; left:0; right:0;
    height:40px;
    background:#F5F9FC;
    clip-path:ellipse(55% 100% at 50% 100%);
}
.camp-breadcrumb {
    display:flex; align-items:center; gap:8px;
    font-size:13px; color:rgba(255,255,255,0.65);
    margin-bottom:18px;
}
.camp-breadcrumb a { color:rgba(255,255,255,0.65); text-decoration:none; }
.camp-breadcrumb a:hover { color:var(--accent-color); }
.camp-breadcrumb .cur { color:var(--accent-color); }
.camp-hero-badge {
    display:inline-flex; align-items:center; gap:7px;
    background:rgba(9,169,217,0.18);
    border:1px solid rgba(9,169,217,0.35);
    color:#18B9E8;
    font-size:12px; font-weight:600; letter-spacing:.6px; text-transform:uppercase;
    padding:5px 14px; border-radius:20px;
    margin-bottom:14px;
}
.camp-hero h1 {
    font-size:36px; font-weight:800; color:#fff;
    line-height:1.2; margin:0 0 10px;
}
.camp-hero h1 span {
    background:linear-gradient(90deg,var(--accent-color),#18B9E8);
    -webkit-background-clip:text; background-clip:text; -webkit-text-fill-color:transparent;
}
.camp-hero p { color:rgba(255,255,255,0.72); font-size:15px; max-width:520px; margin:0; }

/* --- Stats Bar --- */
.camp-stats {
    background:linear-gradient(135deg,var(--primary-color),#0D1048);
    padding:36px 0;
}
.camp-stats-grid {
    display:grid; grid-template-columns:repeat(4,1fr);
    gap:1px; background:rgba(255,255,255,0.12);
    border-radius:16px; overflow:hidden;
}
@media(max-width:640px){ .camp-stats-grid{ grid-template-columns:repeat(2,1fr); } }
.camp-stat {
    background:rgba(255,255,255,0.06);
    padding:24px 16px; text-align:center;
    transition:background .25s ease;
}
.camp-stat:hover { background:rgba(255,255,255,0.12); }
.camp-stat-num {
    font-size:28px; font-weight:800;
    background:linear-gradient(90deg,var(--accent-color),#18B9E8);
    -webkit-background-clip:text; background-clip:text; -webkit-text-fill-color:transparent;
    display:block; line-height:1; margin-bottom:6px;
}
.camp-stat-lbl { color:rgba(255,255,255,0.75); font-size:13px; font-weight:500; }

/* --- Section --- */
.camp-section {
    background:#F5F9FC;
    padding:60px 0 70px;
}
.camp-section-head {
    text-align:center; margin-bottom:48px;
}
.camp-section-badge {
    display:inline-flex; align-items:center; gap:7px;
    background:rgba(23,22,91,0.08);
    border:1px solid rgba(23,22,91,0.18);
    color:var(--primary-color);
    font-size:11px; font-weight:700; letter-spacing:.6px; text-transform:uppercase;
    padding:5px 14px; border-radius:20px;
    margin-bottom:14px;
}
.camp-section-head h2 {
    font-size:30px; font-weight:800; color:var(--text-dark);
    line-height:1.25; margin:0 0 10px;
}
.camp-section-head h2 span {
    background:linear-gradient(90deg,var(--primary-color),var(--accent-color));
    -webkit-background-clip:text; background-clip:text; -webkit-text-fill-color:transparent;
}
.camp-section-head p { color:#64748B; font-size:15px; max-width:520px; margin:0 auto; line-height:1.7; }

/* --- Campus Grid --- */
.camp-grid {
    display:grid; grid-template-columns:repeat(2,1fr);
    gap:28px;
}
@media(max-width:860px){ .camp-grid{ grid-template-columns:1fr; } }

/* --- Campus Card --- */
.camp-card {
    background:#fff;
    border-radius:20px;
    overflow:hidden;
    box-shadow:0 6px 28px rgba(0,0,0,0.07);
    border:1px solid rgba(23,22,91,0.08);
    opacity:0; transform:translateY(28px);
    transition:opacity .5s ease, transform .5s ease, box-shadow .3s ease;
    position:relative;
}
.camp-card.camp-visible {
    opacity:1; transform:translateY(0);
}
.camp-card:hover {
    box-shadow:0 20px 56px rgba(23,22,91,0.14);
    transform:translateY(-6px);
}
.camp-card::before {
    content:'';
    position:absolute; top:0; left:0; right:0; height:3px;
    background:var(--card-gradient, linear-gradient(90deg,#17165B,#09A9D9));
    transform:scaleX(0); transform-origin:left;
    transition:transform .35s ease;
}
.camp-card:hover::before { transform:scaleX(1); }

/* Card Header */
.camp-card-header {
    padding:28px 28px 20px;
    display:flex; align-items:flex-start; gap:18px;
}
.camp-card-icon {
    width:60px; height:60px; border-radius:16px; flex-shrink:0;
    display:flex; align-items:center; justify-content:center;
    font-size:24px; color:#fff;
}
.camp-card-meta { flex:1; }
.camp-card-badge {
    display:inline-flex; align-items:center;
    font-size:10px; font-weight:700; letter-spacing:.5px; text-transform:uppercase;
    padding:3px 10px; border-radius:10px; color:#fff;
    margin-bottom:8px;
}
.camp-card-name {
    font-size:20px; font-weight:800; color:var(--text-dark);
    line-height:1.2; margin:0 0 4px;
}
.camp-card-area {
    display:flex; align-items:center; gap:6px;
    color:#64748B; font-size:13px;
}

/* Card Info Row */
.camp-card-info {
    padding:0 28px 20px;
    display:flex; gap:8px; flex-wrap:wrap;
}
.camp-info-pill {
    display:inline-flex; align-items:center; gap:6px;
    background:rgba(23,22,91,0.06);
    border:1px solid rgba(23,22,91,0.12);
    color:var(--text-light); font-size:12px; font-weight:500;
    padding:5px 12px; border-radius:20px;
}
.camp-info-pill i { color:var(--primary-color); font-size:11px; }

/* Card Divider */
.camp-card-divider {
    height:1px; background:rgba(23,22,91,0.08);
    margin:0 28px;
}

/* Facilities */
.camp-card-facilities {
    padding:18px 28px 20px;
}
.camp-fac-label {
    font-size:11px; font-weight:700; color:var(--text-light); letter-spacing:.5px; text-transform:uppercase;
    margin-bottom:12px;
}
.camp-fac-list {
    display:flex; flex-wrap:wrap; gap:8px;
}
.camp-fac-tag {
    display:inline-flex; align-items:center; gap:5px;
    background:#EAF7FB; color:var(--primary-color);
    font-size:12px; font-weight:500;
    padding:4px 12px; border-radius:8px;
    border:1px solid rgba(23,22,91,0.12);
}
.camp-fac-tag i { font-size:10px; }

/* Card Footer */
.camp-card-footer {
    padding:18px 28px;
    background:rgba(23,22,91,0.03);
    border-top:1px solid rgba(23,22,91,0.08);
    display:flex; align-items:center; justify-content:space-between; gap:12px; flex-wrap:wrap;
}
.camp-contact-links { display:flex; gap:10px; }
.camp-contact-link {
    display:inline-flex; align-items:center; gap:6px;
    color:#64748B; font-size:12px; text-decoration:none;
    padding:6px 12px; border-radius:8px;
    background:rgba(23,22,91,0.06);
    border:1px solid rgba(23,22,91,0.1);
    transition:all .2s ease;
}
.camp-contact-link:hover { background:var(--primary-color); color:#fff; border-color:var(--primary-color); }
.camp-visit-btn {
    display:inline-flex; align-items:center; gap:7px;
    background:var(--primary-color); color:#fff;
    font-size:13px; font-weight:600;
    padding:9px 20px; border-radius:10px;
    text-decoration:none;
    box-shadow:0 4px 14px rgba(23,22,91,0.25);
    transition:all .25s ease;
}
.camp-visit-btn:hover { background:#0D1048; transform:translateY(-2px); color:#fff; }

/* --- Location Section --- */
.camp-location {
    background:#fff;
    padding:60px 0 70px;
}
.camp-location-grid {
    display:grid; grid-template-columns:1fr 1.1fr;
    gap:40px; align-items:start;
}
@media(max-width:860px){ .camp-location-grid{ grid-template-columns:1fr; } }
.camp-location-left {}
.camp-location-badge {
    display:inline-flex; align-items:center; gap:7px;
    background:rgba(23,22,91,0.08);
    border:1px solid rgba(23,22,91,0.18);
    color:var(--primary-color);
    font-size:11px; font-weight:700; letter-spacing:.6px; text-transform:uppercase;
    padding:5px 14px; border-radius:20px;
    margin-bottom:16px;
}
.camp-location-left h2 {
    font-size:28px; font-weight:800; color:var(--text-dark);
    line-height:1.3; margin:0 0 12px;
}
.camp-location-left h2 span {
    background:linear-gradient(90deg,var(--primary-color),var(--accent-color));
    -webkit-background-clip:text; background-clip:text; -webkit-text-fill-color:transparent;
}
.camp-location-left p { color:#64748B; font-size:14px; line-height:1.75; margin:0 0 24px; }
.camp-loc-list { list-style:none; padding:0; margin:0 0 28px; display:flex; flex-direction:column; gap:14px; }
.camp-loc-item {
    display:flex; align-items:flex-start; gap:14px;
}
.camp-loc-icon {
    width:38px; height:38px; border-radius:10px; flex-shrink:0;
    background:rgba(23,22,91,0.08);
    display:flex; align-items:center; justify-content:center;
    color:var(--primary-color); font-size:15px;
}
.camp-loc-text strong { display:block; font-size:14px; font-weight:700; color:var(--text-dark); margin-bottom:2px; }
.camp-loc-text span   { font-size:13px; color:#64748B; }
.camp-direction-btn {
    display:inline-flex; align-items:center; gap:8px;
    background:var(--primary-color); color:#fff;
    padding:12px 26px; border-radius:10px;
    font-size:14px; font-weight:600;
    text-decoration:none;
    box-shadow:0 6px 20px rgba(23,22,91,0.3);
    transition:all .25s ease;
}
.camp-direction-btn:hover { background:#0D1048; transform:translateY(-2px); color:#fff; }
.camp-map {
    border-radius:20px; overflow:hidden;
    box-shadow:0 12px 40px rgba(0,0,0,0.1);
    border:1px solid rgba(23,22,91,0.1);
    height:380px;
}
.camp-map iframe { width:100%; height:100%; border:0; display:block; }

/* --- CTA --- */
.camp-cta {
    background:linear-gradient(135deg,var(--primary-color),#09A9D9,#0D1048);
    padding:52px 0;
    position:relative; overflow:hidden;
}
.camp-cta::before {
    content:'';
    position:absolute; inset:0;
    background:url("data:image/svg+xml,%3Csvg width='80' height='80' viewBox='0 0 80 80' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none'%3E%3Cg fill='%23ffffff' fill-opacity='0.03'%3E%3Ccircle cx='40' cy='40' r='30'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
    pointer-events:none;
}
.camp-cta-inner {
    position:relative;
    display:flex; align-items:center; gap:48px; flex-wrap:wrap;
}
.camp-cta-left { flex:1 1 320px; }
.camp-cta-badge {
    display:inline-flex; align-items:center; gap:6px;
    background:rgba(9,169,217,0.18);
    border:1px solid rgba(9,169,217,0.35);
    color:#18B9E8;
    font-size:11px; font-weight:700; letter-spacing:.6px; text-transform:uppercase;
    padding:4px 12px; border-radius:20px; margin-bottom:12px;
}
.camp-cta-left h2 { font-size:26px; font-weight:800; color:#fff; line-height:1.25; margin:0 0 8px; }
.camp-cta-left p   { color:rgba(255,255,255,0.72); font-size:14px; margin:0; line-height:1.6; }
.camp-cta-right { display:flex; align-items:center; gap:14px; flex-wrap:wrap; }
.camp-cta-btn-primary {
    display:inline-flex; align-items:center; gap:8px;
    background:var(--accent-color); color:#FFFFFF;
    padding:13px 28px; border-radius:10px;
    font-size:14px; font-weight:700; text-decoration:none; white-space:nowrap;
    box-shadow:0 6px 20px rgba(9,169,217,0.35);
    transition:all .25s ease;
}
.camp-cta-btn-primary:hover { background:#078FB8; transform:translateY(-2px); color:#FFFFFF; }
.camp-cta-btn-outline {
    display:inline-flex; align-items:center; gap:8px;
    background:rgba(255,255,255,0.1);
    border:1.5px solid rgba(255,255,255,0.3);
    color:#fff; padding:12px 26px; border-radius:10px;
    font-size:14px; font-weight:600; text-decoration:none; white-space:nowrap;
    backdrop-filter:blur(4px);
    transition:all .25s ease;
}
.camp-cta-btn-outline:hover { background:rgba(255,255,255,0.18); transform:translateY(-2px); color:#fff; }

@media(max-width:768px){
    .camp-hero { padding:50px 0 42px; }
    .camp-hero h1 { font-size:28px; }
    .camp-card-header { flex-direction:column; gap:12px; }
    .camp-cta-inner { gap:28px; }
    .camp-cta-left h2 { font-size:22px; }
}
</style>

<!-- HERO -->
<section class="camp-hero">
    <div class="container" style="position:relative;z-index:2;">
        <div class="camp-breadcrumb">
            <a href="index.php"><i class="fas fa-home" style="font-size:11px;"></i> Home</a>
            <span><i class="fas fa-chevron-right" style="font-size:9px;"></i></span>
            <span class="cur">Campuses</span>
        </div>
        <div class="camp-hero-badge">
            <i class="fas fa-map-marker-alt"></i> Our Locations
        </div>
        <h1>Our <span>Campuses</span> Across Pakistan</h1>
        <p>Multiple campuses, one vision — delivering quality education to students across Pakistan.</p>
    </div>
</section>

<!-- STATS BAR -->
<section class="camp-stats">
    <div class="container">
        <div class="camp-stats-grid">
            <?php foreach ($camp_stats as $cs): ?>
            <div class="camp-stat">
                <span class="camp-stat-num"><?php echo htmlspecialchars($cs['number']); ?></span>
                <span class="camp-stat-lbl"><?php echo htmlspecialchars($cs['label']); ?></span>
            </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>

<!-- CAMPUSES GRID -->
<section class="camp-section">
    <div class="container">
        <div class="camp-section-head">
            <div class="camp-section-badge"><i class="fas fa-location-dot"></i> All Locations</div>
            <h2>Find a Campus <span>Near You</span></h2>
            <p>Each campus is equipped with modern facilities and experienced faculty to ensure the best learning environment.</p>
        </div>

        <div class="camp-grid">
            <?php foreach ($campuses as $i => $c):
                $gradient = 'linear-gradient(135deg,' . htmlspecialchars($c['color_from']) . ',' . htmlspecialchars($c['color_to']) . ')';
                $facilities = array_filter(array_map('trim', explode(',', $c['facilities'] ?? '')));
            ?>
            <div class="camp-card" style="--card-gradient:<?php echo $gradient; ?>; transition-delay:<?php echo $i * 100; ?>ms;">

                <div class="camp-card-header">
                    <div class="camp-card-icon" style="background:<?php echo $gradient; ?>;">
                        <i class="fas <?php echo htmlspecialchars($c['icon']); ?>"></i>
                    </div>
                    <div class="camp-card-meta">
                        <div class="camp-card-badge" style="background:<?php echo htmlspecialchars($c['badge_color']); ?>;">
                            <?php echo htmlspecialchars($c['badge']); ?>
                        </div>
                        <div class="camp-card-name"><?php echo htmlspecialchars($c['name']); ?></div>
                        <div class="camp-card-area">
                            <i class="fas fa-location-dot" style="color:var(--primary-color);font-size:11px;"></i>
                            <?php echo htmlspecialchars($c['area']); ?>
                        </div>
                    </div>
                </div>

                <?php if (!empty($c['students']) || !empty($c['programs']) || !empty($c['since_year'])): ?>
                <div class="camp-card-info">
                    <?php if (!empty($c['students'])): ?><span class="camp-info-pill"><i class="fas fa-users"></i> <?php echo htmlspecialchars($c['students']); ?> Students</span><?php endif; ?>
                    <?php if (!empty($c['programs'])): ?><span class="camp-info-pill"><i class="fas fa-book-open"></i> <?php echo htmlspecialchars($c['programs']); ?> Programs</span><?php endif; ?>
                    <?php if (!empty($c['since_year'])): ?><span class="camp-info-pill"><i class="fas fa-calendar"></i> Est. <?php echo htmlspecialchars($c['since_year']); ?></span><?php endif; ?>
                </div>

                <div class="camp-card-divider"></div>
                <?php endif; ?>

                <?php if (!empty($facilities)): ?>
                <div class="camp-card-facilities">
                    <div class="camp-fac-label">Facilities</div>
                    <div class="camp-fac-list">
                        <?php foreach ($facilities as $fac): ?>
                        <span class="camp-fac-tag">
                            <i class="fas fa-check-circle"></i>
                            <?php echo htmlspecialchars($fac); ?>
                        </span>
                        <?php endforeach; ?>
                    </div>
                </div>
                <?php endif; ?>

                <div class="camp-card-footer">
                    <div class="camp-contact-links">
                        <a href="tel:<?php echo str_replace(' ','',$c['phone']); ?>" class="camp-contact-link">
                            <i class="fas fa-phone-alt"></i> <?php echo htmlspecialchars($c['phone']); ?>
                        </a>
                    </div>
                    <a href="https://maps.google.com/maps?q=<?php echo htmlspecialchars($c['map_query']); ?>" target="_blank" class="camp-visit-btn">
                        <i class="fas fa-directions"></i> Get Directions
                    </a>
                </div>

            </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>

<!-- LOCATION SECTION -->
<section class="camp-location">
    <div class="container">
        <?php if ($main_campus): ?>
        <div class="camp-location-grid">
            <div class="camp-location-left">
                <div class="camp-location-badge"><i class="fas fa-map-pin"></i> <?php echo htmlspecialchars($main_campus['name']); ?></div>
                <h2>Visit Our <span><?php echo htmlspecialchars($main_campus['name']); ?></span></h2>
                <p>Our <?php echo htmlspecialchars(strtolower($main_campus['name'])); ?> in <?php echo htmlspecialchars($main_campus['area']); ?> is the heart of <?php echo getSiteName(); ?>. Come visit us and see our facilities firsthand.</p>
                <ul class="camp-loc-list">
                    <li class="camp-loc-item">
                        <div class="camp-loc-icon"><i class="fas fa-location-dot"></i></div>
                        <div class="camp-loc-text">
                            <strong>Address</strong>
                            <span><?php echo htmlspecialchars($main_campus['area']); ?>, Pakistan</span>
                        </div>
                    </li>
                    <li class="camp-loc-item">
                        <div class="camp-loc-icon"><i class="fas fa-phone-alt"></i></div>
                        <div class="camp-loc-text">
                            <strong>Phone</strong>
                            <span><?php echo htmlspecialchars($main_campus['phone']); ?></span>
                        </div>
                    </li>
                    <?php if (!empty($main_campus['email'])): ?>
                    <li class="camp-loc-item">
                        <div class="camp-loc-icon"><i class="fas fa-envelope"></i></div>
                        <div class="camp-loc-text">
                            <strong>Email</strong>
                            <span><?php echo htmlspecialchars($main_campus['email']); ?></span>
                        </div>
                    </li>
                    <?php endif; ?>
                    <li class="camp-loc-item">
                        <div class="camp-loc-icon"><i class="fas fa-clock"></i></div>
                        <div class="camp-loc-text">
                            <strong>Office Hours</strong>
                            <span><?php echo htmlspecialchars(getOfficeHours()); ?></span>
                        </div>
                    </li>
                </ul>
                <a href="https://maps.google.com/maps?q=<?php echo htmlspecialchars($main_campus['map_query']); ?>" target="_blank" class="camp-direction-btn">
                    <i class="fas fa-directions"></i> Open in Google Maps
                </a>
            </div>
            <div class="camp-map">
                <iframe
                    src="https://maps.google.com/maps?q=<?php echo htmlspecialchars($main_campus['map_query']); ?>&output=embed&z=14"
                    allowfullscreen loading="lazy"
                    referrerpolicy="no-referrer-when-downgrade">
                </iframe>
            </div>
        </div>
        <?php endif; ?>
    </div>
</section>

<!-- CTA -->
<section class="camp-cta">
    <div class="container">
        <div class="camp-cta-inner">
            <div class="camp-cta-left">
                <div class="camp-cta-badge"><i class="fas fa-graduation-cap"></i> Enroll Today</div>
                <h2>Choose Your Campus &amp; Start Learning</h2>
                <p>Apply for admission at the campus nearest to you and begin your journey towards a bright future.</p>
            </div>
            <div class="camp-cta-right">
                <a href="admission.php" class="camp-cta-btn-primary">
                    <i class="fas fa-paper-plane"></i> Apply Now
                </a>
                <a href="contact.php" class="camp-cta-btn-outline">
                    <i class="fas fa-phone-alt"></i> Contact Us
                </a>
            </div>
        </div>
    </div>
</section>

<script>
/* Staggered entrance animations */
const campCards = document.querySelectorAll('.camp-card');
const io = new IntersectionObserver(entries => {
    entries.forEach(e => {
        if (e.isIntersecting) {
            const delay = parseInt(e.target.style.transitionDelay) || 0;
            setTimeout(() => e.target.classList.add('camp-visible'), delay);
            io.unobserve(e.target);
        }
    });
}, { threshold: 0.08 });
campCards.forEach(c => io.observe(c));
</script>

<?php include 'includes/footer.php'; ?>
