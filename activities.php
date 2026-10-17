<?php
require_once 'includes/config.php';
$page_title = 'Extra-Curricular Activities';
$page_description = 'Discover extra-curricular activities, sports, seminars and student societies at Bahawal College of Health Sciences.';

$category_meta = [
    'sports'      => ['label' => 'Sports',      'icon' => 'fa-futbol',            'color' => '#09A9D9', 'bg' => 'rgba(9,169,217,0.1)'],
    'seminar'     => ['label' => 'Seminars',    'icon' => 'fa-chalkboard-user',   'color' => '#17165B', 'bg' => 'rgba(23,22,91,0.08)'],
    'workshop'    => ['label' => 'Workshops',   'icon' => 'fa-toolbox',           'color' => '#0D1048', 'bg' => 'rgba(13,16,72,0.1)'],
    'competition' => ['label' => 'Competitions','icon' => 'fa-trophy',            'color' => '#18B9E8', 'bg' => 'rgba(24,185,232,0.12)'],
    'cultural'    => ['label' => 'Cultural',    'icon' => 'fa-masks-theater',     'color' => '#17165B', 'bg' => 'rgba(23,22,91,0.08)'],
    'community'   => ['label' => 'Community',   'icon' => 'fa-hand-holding-heart','color' => '#09A9D9', 'bg' => 'rgba(9,169,217,0.1)'],
    'general'     => ['label' => 'General',     'icon' => 'fa-calendar-day',      'color' => '#64748B', 'bg' => 'rgba(100,116,139,0.1)'],
];

$activities = [];
$ar = mysqli_query($conn, "SELECT * FROM events WHERE status='active' ORDER BY event_date DESC, id DESC");
if ($ar) {
    while ($row = mysqli_fetch_assoc($ar)) {
        $activities[] = $row;
    }
}
$has_activities = count($activities) > 0;

// Upcoming (soonest first) vs past (most recent first)
$today = date('Y-m-d');
$upcoming = array_values(array_filter($activities, function ($a) use ($today) { return $a['event_date'] >= $today; }));
$past     = array_values(array_filter($activities, function ($a) use ($today) { return $a['event_date'] < $today; }));
usort($upcoming, function ($x, $y) { return strcmp($x['event_date'], $y['event_date']) ?: ($x['id'] <=> $y['id']); });

$societies = [];
$sr = mysqli_query($conn, "SELECT * FROM student_societies WHERE status='active' ORDER BY display_order ASC, id ASC");
if ($sr) {
    while ($row = mysqli_fetch_assoc($sr)) {
        $societies[] = $row;
    }
}
$has_societies = count($societies) > 0;

// Only show filter chips for categories that actually have at least one real activity (with counts)
$present_categories = [];
foreach ($activities as $a) {
    $present_categories[$a['category']] = ($present_categories[$a['category']] ?? 0) + 1;
}

// One card, used for both the upcoming and past lists
function ecaCard($a, $category_meta, $is_upcoming) {
    $meta = $category_meta[$a['category']] ?? $category_meta['general'];
    $desc = trim((string) $a['description']);
    $long = mb_strlen($desc) > 180 || substr_count($desc, "\n") > 2;
    ob_start(); ?>
    <article class="eca-card" data-category="<?php echo htmlspecialchars($a['category']); ?>" data-id="<?php echo (int) $a['id']; ?>">
        <div class="eca-card-img" style="background:linear-gradient(135deg,<?php echo $meta['color']; ?>,#0D1048);">
            <?php if (!empty($a['image'])): ?>
                <img src="<?php echo htmlspecialchars($a['image']); ?>" alt="<?php echo htmlspecialchars($a['title']); ?>" loading="lazy">
            <?php else: ?>
                <i class="fas <?php echo $meta['icon']; ?>"></i>
            <?php endif; ?>
            <?php if ($is_upcoming): ?><span class="eca-upcoming-flag"><i class="fas fa-bell"></i> Upcoming</span><?php endif; ?>
        </div>
        <div class="eca-card-body">
            <span class="eca-cat-tag" style="background:<?php echo $meta['bg']; ?>;color:<?php echo $meta['color']; ?>;"><i class="fas <?php echo $meta['icon']; ?>"></i> <?php echo $meta['label']; ?></span>
            <h3><?php echo htmlspecialchars($a['title']); ?></h3>
            <div class="eca-meta">
                <span><i class="fas fa-calendar-days"></i> <?php echo date('d M Y', strtotime($a['event_date'])); ?></span>
                <?php if (!empty($a['time'])): ?><span><i class="fas fa-clock"></i> <?php echo htmlspecialchars($a['time']); ?></span><?php endif; ?>
                <?php if (!empty($a['location'])): ?><span><i class="fas fa-location-dot"></i> <?php echo htmlspecialchars($a['location']); ?></span><?php endif; ?>
            </div>
            <?php if ($desc !== ''): ?>
            <p class="eca-desc<?php echo $long ? ' eca-clamp' : ''; ?>"><?php echo nl2br(htmlspecialchars($desc)); ?></p>
            <?php endif; ?>
            <?php if ($long || !empty($a['image'])): ?>
            <button type="button" class="eca-more" data-open="<?php echo (int) $a['id']; ?>"><?php echo $long ? 'Read more' : 'View'; ?> <i class="fas fa-arrow-right"></i></button>
            <?php endif; ?>
        </div>
    </article>
    <?php return ob_get_clean();
}
?>
<?php include 'includes/header.php'; ?>

<style>
/* ===== EXTRA-CURRICULAR ACTIVITIES PAGE ===== */

/* --- Hero --- */
.eca-hero {
    background: linear-gradient(135deg,#0D1048 0%,#17165B 55%,#0D1048 100%);
    padding: 62px 0 50px;
    position: relative; overflow: hidden;
}
.eca-hero::after {
    content:'';
    position:absolute; bottom:-1px; left:0; right:0;
    height:40px;
    background:#F5F9FC;
    clip-path:ellipse(55% 100% at 50% 100%);
}
.eca-breadcrumb {
    display:flex; align-items:center; gap:8px;
    font-size:12px; color:rgba(255,255,255,0.5); margin-bottom:18px;
    position:relative; z-index:1;
}
.eca-breadcrumb a { color:rgba(255,255,255,0.6); text-decoration:none; }
.eca-breadcrumb a:hover { color:var(--accent-color); }
.eca-hero-badge {
    display:inline-flex; align-items:center; gap:7px;
    background:rgba(9,169,217,0.14); border:1px solid rgba(9,169,217,0.35);
    color:var(--accent-color); padding:6px 18px; border-radius:50px;
    font-size:10.5px; font-weight:700; letter-spacing:2px;
    text-transform:uppercase; margin-bottom:16px;
    position:relative; z-index:1;
}
.eca-hero h1 {
    font-size:38px; font-weight:800; color:#fff;
    margin:0 0 12px; line-height:1.15;
    position:relative; z-index:1;
}
.eca-hero h1 span { color:var(--accent-color); }
.eca-hero p {
    color:rgba(255,255,255,0.72); font-size:15px; margin:0; max-width:600px; line-height:1.7;
    position:relative; z-index:1;
}

/* --- Filter chips --- */
.eca-section { padding:48px 0; background:#F5F9FC; }
.eca-filters { display:flex; flex-wrap:wrap; gap:10px; justify-content:center; margin-bottom:36px; }
.eca-chip {
    display:inline-flex; align-items:center; gap:7px;
    padding:8px 18px; border-radius:50px; border:1.5px solid rgba(23,22,91,0.15);
    background:#fff; color:var(--text-dark);
    font-size:12.5px; font-weight:700; cursor:pointer;
    transition:all 0.2s ease; font-family:var(--font);
}
.eca-chip:hover { border-color:var(--primary-color); }
.eca-chip.active { background:var(--primary-color); border-color:var(--primary-color); color:#fff; }

/* --- Activity cards --- */
.eca-grid { display:grid; grid-template-columns:repeat(3,1fr); gap:24px; }
@media (max-width:900px) { .eca-grid { grid-template-columns:1fr; } }

.eca-card {
    background:#fff; border-radius:16px; border:1px solid rgba(23,22,91,0.1);
    overflow:hidden; display:flex; flex-direction:column;
    transition:transform 0.3s ease, box-shadow 0.3s ease;
}
.eca-card:hover { transform:translateY(-5px); box-shadow:0 16px 40px rgba(23,22,91,0.12); }
.eca-card-img { width:100%; height:160px; display:flex; align-items:center; justify-content:center; overflow:hidden; }
.eca-card-img img { width:100%; height:100%; object-fit:cover; }
.eca-card-img i { font-size:32px; color:#fff; }
.eca-card-body { padding:20px 22px 22px; flex:1; display:flex; flex-direction:column; }
.eca-cat-tag {
    display:inline-flex; align-items:center; gap:6px; align-self:flex-start;
    padding:4px 12px; border-radius:20px; font-size:10.5px; font-weight:700;
    text-transform:uppercase; letter-spacing:0.4px; margin-bottom:10px;
}
.eca-card h3 { font-size:16px; font-weight:800; color:var(--text-dark); margin:0 0 8px; line-height:1.35; }
.eca-meta { font-size:11.5px; color:var(--text-light); display:flex; flex-wrap:wrap; gap:12px; margin-bottom:10px; }
.eca-meta span { display:flex; align-items:center; gap:5px; }
.eca-desc { color:var(--text-light); font-size:13px; line-height:1.7; margin:0; }

/* --- Societies section --- */
.eca-soc-grid { display:grid; grid-template-columns:repeat(3,1fr); gap:22px; }
@media (max-width:900px) { .eca-soc-grid { grid-template-columns:repeat(2,1fr); } }
@media (max-width:600px) { .eca-soc-grid { grid-template-columns:1fr; } }
.eca-soc-card {
    background:#fff; border-radius:16px; border:1px solid rgba(23,22,91,0.1);
    padding:22px; text-align:center;
    transition:transform 0.3s ease, box-shadow 0.3s ease;
}
.eca-soc-card:hover { transform:translateY(-4px); box-shadow:0 14px 34px rgba(23,22,91,0.1); }
.eca-soc-logo {
    width:58px; height:58px; border-radius:14px; margin:0 auto 14px; overflow:hidden;
    background:linear-gradient(135deg,var(--primary-color),#0D1048);
    display:flex; align-items:center; justify-content:center;
}
.eca-soc-logo img { width:100%; height:100%; object-fit:cover; }
.eca-soc-logo i { color:#fff; font-size:22px; }
.eca-soc-card h4 { font-size:14.5px; font-weight:800; color:var(--text-dark); margin:0 0 4px; }
.eca-soc-focus { font-size:11.5px; color:var(--accent-color); font-weight:700; margin-bottom:8px; }
.eca-soc-card p.eca-soc-desc { color:var(--text-light); font-size:12.5px; line-height:1.6; margin:0 0 8px; }
.eca-soc-meeting { font-size:11px; color:var(--text-dark); display:flex; align-items:center; justify-content:center; gap:5px; }
.eca-soc-meeting i { color:var(--primary-color); }

/* --- Empty states --- */
.eca-empty {
    grid-column:1/-1; text-align:center; padding:60px 30px;
    background:#fff; border-radius:18px; border:1px solid rgba(23,22,91,0.1);
}
.eca-empty i { font-size:44px; color:var(--border-color); margin-bottom:16px; display:block; }
.eca-empty h3 { color:var(--text-dark); font-size:18px; margin:0 0 8px; }
.eca-empty p { color:var(--text-light); font-size:13.5px; margin:0 auto; max-width:440px; line-height:1.7; }

/* --- Upcoming / past, counts, read more, details dialog --- */
.eca-group-title { display:flex; align-items:center; gap:10px; font-size:20px; font-weight:800; color:var(--text-dark); margin:0 0 18px; }
.eca-group-title i { color:var(--primary-color); font-size:17px; }
.eca-group-title small { font-size:12px; font-weight:700; color:var(--text-light); background:rgba(23,22,91,0.07); border-radius:50px; padding:2px 10px; }
.eca-group + .eca-group { margin-top:46px; }
.eca-chip .eca-count { background:rgba(23,22,91,0.08); color:var(--primary-color); border-radius:50px; padding:0 7px; font-size:10.5px; font-weight:700; margin-left:2px; }
.eca-chip.active .eca-count { background:rgba(255,255,255,0.22); color:#fff; }
.eca-chip-link { text-decoration:none; }
.eca-card-img { position:relative; }
.eca-card-img .eca-upcoming-flag i { font-size:10px; color:#fff; opacity:1; }
.eca-upcoming-flag { position:absolute; top:12px; left:12px; display:inline-flex; align-items:center; gap:5px; background:#F59E0B; color:#fff; font-size:10.5px; font-weight:700; letter-spacing:0.5px; text-transform:uppercase; padding:4px 10px; border-radius:50px; }
.eca-clamp { display:-webkit-box; -webkit-line-clamp:4; -webkit-box-orient:vertical; overflow:hidden; }
.eca-more { margin-top:10px; background:none; border:none; padding:0; cursor:pointer; font-family:inherit; font-size:13px; font-weight:700; color:var(--primary-color); display:inline-flex; align-items:center; gap:6px; }
.eca-more:hover { gap:9px; }
.eca-dialog { margin:auto; border:none; border-radius:18px; padding:0; width:min(720px, calc(100vw - 32px)); max-height:calc(100vh - 40px); box-shadow:0 30px 80px rgba(0,0,0,0.35); }
.eca-dialog::backdrop { background:rgba(13,16,72,0.6); }
.eca-dialog img { width:100%; max-height:380px; object-fit:cover; display:block; }
.eca-dialog-body { padding:22px 24px 26px; }
.eca-dialog-body h3 { font-size:21px; font-weight:800; color:var(--text-dark); margin:10px 0 8px; }
.eca-dialog-body p { color:var(--text-light); font-size:14px; line-height:1.8; margin:12px 0 0; }
.eca-dialog-close { position:absolute; top:12px; right:12px; width:36px; height:36px; border-radius:50%; border:none; background:rgba(0,0,0,0.55); color:#fff; cursor:pointer; font-size:15px; }
.eca-dialog-close:hover { background:rgba(0,0,0,0.75); }
@media (max-width:600px) { .eca-dialog-body { padding:18px 16px 22px; } .eca-group-title { font-size:18px; } }
</style>

<!-- HERO -->
<section class="eca-hero">
    <div class="container" style="position:relative;z-index:2;">
        <div class="eca-breadcrumb">
            <a href="index.php"><i class="fas fa-home" style="font-size:11px;"></i> Home</a>
            <span><i class="fas fa-chevron-right" style="font-size:9px;"></i></span>
            <span>Extra-Curricular Activities</span>
        </div>
        <div class="eca-hero-badge">
            <i class="fas fa-star"></i> Beyond the Classroom
        </div>
        <h1>Extra-Curricular <span>Activities</span></h1>
        <p>Sports, seminars, workshops, competitions, cultural and community activities, and the student societies at <?php echo htmlspecialchars(getSiteName()); ?>.</p>
    </div>
</section>

<!-- ACTIVITIES -->
<section class="eca-section">
    <div class="container">

        <?php if ($has_activities): ?>
        <div class="eca-filters" id="ecaFilters">
            <button type="button" class="eca-chip active" data-filter="all">All Activities <span class="eca-count"><?php echo count($activities); ?></span></button>
            <?php foreach ($category_meta as $key => $meta): if (!isset($present_categories[$key])) continue; ?>
            <button type="button" class="eca-chip" data-filter="<?php echo $key; ?>"><i class="fas <?php echo $meta['icon']; ?>" style="font-size:10.5px;"></i> <?php echo $meta['label']; ?> <span class="eca-count"><?php echo $present_categories[$key]; ?></span></button>
            <?php endforeach; ?>
            <?php if ($has_societies): ?>
            <a href="#societies" class="eca-chip eca-chip-link"><i class="fas fa-people-group" style="font-size:10.5px;"></i> Student Societies <span class="eca-count"><?php echo count($societies); ?></span></a>
            <?php endif; ?>
        </div>

        <?php foreach (['upcoming' => ['Upcoming Activities', 'fa-calendar-plus', $upcoming], 'past' => ['Past Activities', 'fa-clock-rotate-left', $past]] as $gkey => $grp): if (!$grp[2]) continue; ?>
        <div class="eca-group" data-group="<?php echo $gkey; ?>">
            <h2 class="eca-group-title"><i class="fas <?php echo $grp[1]; ?>"></i> <?php echo $grp[0]; ?> <small><?php echo count($grp[2]); ?></small></h2>
            <div class="eca-grid">
                <?php foreach ($grp[2] as $a) echo ecaCard($a, $category_meta, $gkey === 'upcoming'); ?>
            </div>
        </div>
        <?php endforeach; ?>
        <?php else: ?>
        <div class="eca-grid">
            <div class="eca-empty">
                <i class="fas fa-star"></i>
                <h3>Activities — Coming Soon</h3>
                <p>Sports days, seminars, workshops, competitions, cultural and community activities will be listed here as they're scheduled.</p>
            </div>
        </div>
        <?php endif; ?>
    </div>
</section>

<!-- STUDENT SOCIETIES -->
<section class="eca-section" id="societies" style="background:#fff;scroll-margin-top:20px;">
    <div class="container">
        <div style="text-align:center;margin-bottom:34px;">
            <div class="eca-chip active" style="display:inline-flex;cursor:default;margin-bottom:12px;"><i class="fas fa-people-group" style="font-size:10.5px;"></i> Student Societies</div>
            <h2 style="font-size:26px;font-weight:800;color:var(--text-dark);margin:0 0 8px;">Student <span style="color:var(--primary-color);">Societies &amp; Clubs</span></h2>
            <p style="color:var(--text-light);font-size:14px;margin:0;">Student-run societies and clubs currently active on campus.</p>
        </div>

        <div class="eca-soc-grid">
            <?php if ($has_societies): ?>
                <?php foreach ($societies as $s): ?>
                <div class="eca-soc-card">
                    <div class="eca-soc-logo">
                        <?php if (!empty($s['image'])): ?>
                            <img src="<?php echo htmlspecialchars($s['image']); ?>" alt="<?php echo htmlspecialchars($s['name']); ?>" loading="lazy">
                        <?php else: ?>
                            <i class="fas <?php echo htmlspecialchars($s['icon'] ?: 'fa-people-group'); ?>"></i>
                        <?php endif; ?>
                    </div>
                    <h4><?php echo htmlspecialchars($s['name']); ?></h4>
                    <?php if (!empty($s['focus_area'])): ?><div class="eca-soc-focus"><?php echo htmlspecialchars($s['focus_area']); ?></div><?php endif; ?>
                    <?php if (!empty($s['description'])): ?><p class="eca-soc-desc"><?php echo nl2br(htmlspecialchars($s['description'])); ?></p><?php endif; ?>
                    <?php if (!empty($s['meeting_info'])): ?><div class="eca-soc-meeting"><i class="fas fa-clock"></i> <?php echo htmlspecialchars($s['meeting_info']); ?></div><?php endif; ?>
                </div>
                <?php endforeach; ?>
            <?php else: ?>
                <div class="eca-empty">
                    <i class="fas fa-people-group"></i>
                    <h3>Student Societies — Coming Soon</h3>
                    <p>Our student societies and clubs will be listed here as they're added.</p>
                </div>
            <?php endif; ?>
        </div>
    </div>
</section>

<?php if ($has_activities): ?>
<dialog class="eca-dialog" id="ecaDialog" aria-labelledby="ecaDialogTitle">
    <button type="button" class="eca-dialog-close" aria-label="Close" onclick="this.closest('dialog').close()"><i class="fas fa-xmark"></i></button>
    <div id="ecaDialogContent"></div>
</dialog>
<script>
(function() {
    var chips = document.querySelectorAll('#ecaFilters .eca-chip[data-filter]');
    var groups = document.querySelectorAll('.eca-group');

    function applyFilter(filter) {
        chips.forEach(function(c) { c.classList.toggle('active', c.dataset.filter === filter); });
        groups.forEach(function(g) {
            var shown = 0;
            g.querySelectorAll('.eca-card').forEach(function(card) {
                var on = filter === 'all' || card.dataset.category === filter;
                card.style.display = on ? '' : 'none';
                if (on) shown++;
            });
            g.style.display = shown ? '' : 'none';
        });
        // Shareable link, e.g. activities.php?category=sports
        if (window.history && history.replaceState) {
            var url = new URL(window.location.href);
            if (filter === 'all') url.searchParams.delete('category'); else url.searchParams.set('category', filter);
            history.replaceState(null, '', url.pathname + url.search + url.hash);
        }
    }
    chips.forEach(function(chip) { chip.addEventListener('click', function() { applyFilter(chip.dataset.filter); }); });
    var start = new URLSearchParams(window.location.search).get('category');
    if (start && document.querySelector('#ecaFilters .eca-chip[data-filter="' + start.replace(/[^a-z]/g, '') + '"]')) applyFilter(start.replace(/[^a-z]/g, ''));

    // Details dialog: built from the card itself (full description is already in the page)
    var dlg = document.getElementById('ecaDialog'), box = document.getElementById('ecaDialogContent');
    document.addEventListener('click', function(e) {
        var btn = e.target.closest('.eca-more');
        if (!btn) return;
        var card = btn.closest('.eca-card');
        var img = card.querySelector('.eca-card-img img');
        var desc = card.querySelector('.eca-desc');
        box.innerHTML = (img ? '<img src="' + img.getAttribute('src') + '" alt="">' : '') +
            '<div class="eca-dialog-body">' + card.querySelector('.eca-cat-tag').outerHTML +
            '<h3 id="ecaDialogTitle">' + card.querySelector('h3').innerHTML + '</h3>' +
            card.querySelector('.eca-meta').outerHTML + (desc ? '<p>' + desc.innerHTML + '</p>' : '') + '</div>';
        if (dlg.showModal) dlg.showModal(); else dlg.setAttribute('open', '');
    });
    dlg.addEventListener('click', function(e) { if (e.target === dlg) dlg.close(); });
})();
</script>
<?php endif; ?>

<?php include 'includes/footer.php'; ?>
