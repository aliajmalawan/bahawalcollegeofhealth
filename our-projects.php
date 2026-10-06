<?php
require_once 'includes/config.php';
$page_title = 'Our Projects';
$page_description = 'Explore ongoing community and welfare projects led by Bahawal College of Health Sciences and its affiliated foundation.';

$groups = ['ongoing' => [], 'upcoming' => [], 'completed' => []];
$pr = mysqli_query($conn, "SELECT * FROM projects WHERE visibility='active' ORDER BY display_order ASC, project_date DESC, id DESC");
if ($pr) {
    while ($row = mysqli_fetch_assoc($pr)) {
        if (isset($groups[$row['status']])) {
            $groups[$row['status']][] = $row;
        }
    }
}
$has_any = count($groups['ongoing']) + count($groups['upcoming']) + count($groups['completed']) > 0;

$status_meta = [
    'ongoing'   => ['label' => 'Ongoing Projects',   'badge' => 'In Progress', 'icon' => 'fa-spinner',       'color' => '#09A9D9', 'bg' => 'rgba(9,169,217,0.1)',  'sub' => 'Projects and initiatives currently underway.'],
    'upcoming'  => ['label' => 'Upcoming Projects',  'badge' => 'Coming Up',   'icon' => 'fa-calendar-plus', 'color' => '#F59E0B', 'bg' => 'rgba(245,158,11,0.1)', 'sub' => 'Planned projects and initiatives on the horizon.'],
    'completed' => ['label' => 'Completed Projects', 'badge' => 'Delivered',   'icon' => 'fa-circle-check',  'color' => '#16A34A', 'bg' => 'rgba(22,163,74,0.1)',  'sub' => 'Successfully completed projects and their outcomes.'],
];
?>
<?php include 'includes/header.php'; ?>

<style>
/* ===== OUR PROJECTS PAGE ===== */

/* --- Hero --- */
.prj-hero {
    background: linear-gradient(135deg,#0D1048 0%,#17165B 55%,#0D1048 100%);
    padding: 62px 0 50px;
    position: relative; overflow: hidden;
}
.prj-hero::after {
    content:'';
    position:absolute; bottom:-1px; left:0; right:0;
    height:40px;
    background:#F5F9FC;
    clip-path:ellipse(55% 100% at 50% 100%);
}
.prj-breadcrumb {
    display:flex; align-items:center; gap:8px;
    font-size:12px; color:rgba(255,255,255,0.5); margin-bottom:18px;
    position:relative; z-index:1;
}
.prj-breadcrumb a { color:rgba(255,255,255,0.6); text-decoration:none; }
.prj-breadcrumb a:hover { color:var(--accent-color); }
.prj-hero-badge {
    display:inline-flex; align-items:center; gap:7px;
    background:rgba(9,169,217,0.14); border:1px solid rgba(9,169,217,0.35);
    color:var(--accent-color); padding:6px 18px; border-radius:50px;
    font-size:10.5px; font-weight:700; letter-spacing:2px;
    text-transform:uppercase; margin-bottom:16px;
    position:relative; z-index:1;
}
.prj-hero h1 {
    font-size:38px; font-weight:800; color:#fff;
    margin:0 0 12px; line-height:1.15;
    position:relative; z-index:1;
}
.prj-hero h1 span { color:var(--accent-color); }
.prj-hero p {
    color:rgba(255,255,255,0.72); font-size:15px; margin:0; max-width:580px; line-height:1.7;
    position:relative; z-index:1;
}

/* --- Section --- */
.prj-section { padding:48px 0; background:#F5F9FC; }
.prj-section.prj-alt { background:#fff; }
.prj-sh { text-align:center; margin-bottom:34px; }
.prj-sh-badge {
    display:inline-flex; align-items:center; gap:7px;
    padding:6px 16px; border-radius:50px; border:1px solid;
    font-size:10.5px; font-weight:700; letter-spacing:2px;
    text-transform:uppercase; margin-bottom:12px;
}
.prj-sh h2 { font-size:26px; font-weight:800; color:var(--text-dark); margin:0 0 8px; }
.prj-sh p { color:var(--text-light); font-size:14px; margin:0 auto; max-width:520px; }

/* --- Cards --- */
.prj-grid { display:grid; grid-template-columns:repeat(3,1fr); gap:24px; }
@media (max-width:900px) { .prj-grid { grid-template-columns:1fr; } }

.prj-card {
    background:#fff; border-radius:16px; border:1px solid rgba(23,22,91,0.1);
    overflow:hidden; display:flex; flex-direction:column;
    transition:transform 0.3s ease, box-shadow 0.3s ease;
}
.prj-card:hover { transform:translateY(-5px); box-shadow:0 16px 40px rgba(23,22,91,0.12); }

.prj-card-img { width:100%; height:170px; background:linear-gradient(135deg,var(--primary-color),#0D1048); display:flex; align-items:center; justify-content:center; overflow:hidden; }
.prj-card-img img { width:100%; height:100%; object-fit:cover; }
.prj-card-img i { color:rgba(255,255,255,0.55); font-size:34px; }

.prj-card-body { padding:20px 22px 22px; flex:1; display:flex; flex-direction:column; }
.prj-tags { display:flex; align-items:center; flex-wrap:wrap; gap:8px; margin-bottom:12px; }
.prj-status-tag { display:inline-flex; align-items:center; gap:5px; padding:4px 11px; border-radius:20px; font-size:10.5px; font-weight:700; text-transform:uppercase; letter-spacing:0.4px; }
.prj-cat-tag { background:rgba(23,22,91,0.07); color:var(--primary-color); padding:4px 11px; border-radius:20px; font-size:11px; font-weight:600; }

.prj-card h3 { font-size:16px; font-weight:800; color:var(--text-dark); margin:0 0 8px; line-height:1.35; }
.prj-date { font-size:11.5px; color:var(--text-light); display:flex; align-items:center; gap:6px; margin-bottom:10px; }
.prj-desc { color:var(--text-light); font-size:13px; line-height:1.7; margin:0 0 12px; }

.prj-details { display:none; font-size:12.5px; color:var(--text-dark); line-height:1.7; background:#F5F9FC; border-radius:10px; padding:12px 14px; margin-bottom:12px; white-space:pre-line; }
.prj-toggle {
    margin-top:auto; align-self:flex-start;
    display:inline-flex; align-items:center; gap:6px;
    background:none; border:none; padding:0; cursor:pointer;
    color:var(--primary-color); font-size:12.5px; font-weight:700; font-family:var(--font);
}
.prj-toggle:hover { color:var(--accent-color); }
.prj-toggle i { transition:transform 0.25s ease; font-size:10px; }
.prj-toggle.open i { transform:rotate(180deg); }

/* --- Empty state --- */
.prj-empty {
    grid-column:1/-1;
    text-align:center; padding:44px 30px;
    background:#fff; border-radius:16px; border:1px solid rgba(23,22,91,0.1);
}
.prj-alt .prj-empty { background:#F5F9FC; }
.prj-empty i { font-size:38px; color:var(--border-color); margin-bottom:14px; display:block; }
.prj-empty p { color:var(--text-light); font-size:13px; margin:0 auto; max-width:420px; }

/* --- Page-wide empty state --- */
.prj-page-empty {
    text-align:center; padding:70px 30px;
    background:#fff; border-radius:18px; border:1px solid rgba(23,22,91,0.1);
}
.prj-page-empty i { font-size:52px; color:var(--border-color); margin-bottom:18px; display:block; }
.prj-page-empty h3 { color:var(--text-dark); font-size:19px; margin:0 0 8px; }
.prj-page-empty p { color:var(--text-light); font-size:14px; margin:0 auto; max-width:440px; }
</style>

<!-- HERO -->
<section class="prj-hero">
    <div class="container" style="position:relative;z-index:2;">
        <div class="prj-breadcrumb">
            <a href="index.php"><i class="fas fa-home" style="font-size:11px;"></i> Home</a>
            <span><i class="fas fa-chevron-right" style="font-size:9px;"></i></span>
            <span>Our Projects</span>
        </div>
        <div class="prj-hero-badge">
            <i class="fas fa-diagram-project"></i> Showcase
        </div>
        <h1>Our <span>Projects</span></h1>
        <p>A look at the real research, community health and student-led initiatives we're running, planning and have delivered.</p>
    </div>
</section>

<?php if (!$has_any): ?>
<section class="prj-section">
    <div class="container">
        <div class="prj-page-empty">
            <i class="fas fa-diagram-project"></i>
            <h3>Projects Showcase — Coming Soon</h3>
            <p>We're putting together our project showcase. Real ongoing, upcoming and completed projects will be listed here as they're added.</p>
        </div>
    </div>
</section>
<?php else: ?>
<?php $alt = true; foreach (['ongoing', 'upcoming', 'completed'] as $status):
    $items = $groups[$status];
    $meta = $status_meta[$status];
    $alt = !$alt;
?>
<section class="prj-section <?php echo $alt ? 'prj-alt' : ''; ?>">
    <div class="container">
        <div class="prj-sh">
            <div class="prj-sh-badge" style="color:<?php echo $meta['color']; ?>;border-color:<?php echo $meta['color']; ?>44;background:<?php echo $meta['bg']; ?>;"><i class="fas <?php echo $meta['icon']; ?>" style="font-size:9px;"></i> <?php echo $meta['badge']; ?></div>
            <h2><?php echo $meta['label']; ?></h2>
            <p><?php echo $meta['sub']; ?></p>
        </div>

        <div class="prj-grid">
            <?php if (count($items) > 0): ?>
                <?php foreach ($items as $i => $p):
                    $uid = $status . '-' . $i;
                ?>
                <div class="prj-card">
                    <div class="prj-card-img">
                        <?php if (!empty($p['image'])): ?>
                            <img src="<?php echo htmlspecialchars($p['image']); ?>" alt="<?php echo htmlspecialchars($p['title']); ?>" loading="lazy">
                        <?php else: ?>
                            <i class="fas fa-diagram-project"></i>
                        <?php endif; ?>
                    </div>
                    <div class="prj-card-body">
                        <div class="prj-tags">
                            <span class="prj-status-tag" style="background:<?php echo $meta['bg']; ?>;color:<?php echo $meta['color']; ?>;"><?php echo ucfirst($status); ?></span>
                            <?php if (!empty($p['category'])): ?>
                            <span class="prj-cat-tag"><?php echo htmlspecialchars($p['category']); ?></span>
                            <?php endif; ?>
                        </div>
                        <h3><?php echo htmlspecialchars($p['title']); ?></h3>
                        <?php if (!empty($p['project_date'])): ?>
                        <div class="prj-date"><i class="fas fa-calendar-days"></i> <?php echo date('d M Y', strtotime($p['project_date'])); ?></div>
                        <?php endif; ?>
                        <?php if (!empty($p['description'])): ?>
                        <p class="prj-desc"><?php echo htmlspecialchars($p['description']); ?></p>
                        <?php endif; ?>

                        <?php if (!empty($p['details'])): ?>
                        <div class="prj-details" id="prj-details-<?php echo $uid; ?>"><?php echo htmlspecialchars($p['details']); ?></div>
                        <button type="button" class="prj-toggle" onclick="prjToggle('<?php echo $uid; ?>', this)">
                            <span>View Details</span> <i class="fas fa-chevron-down"></i>
                        </button>
                        <?php endif; ?>
                    </div>
                </div>
                <?php endforeach; ?>
            <?php else: ?>
                <div class="prj-empty">
                    <i class="fas <?php echo $meta['icon']; ?>"></i>
                    <p>No <?php echo strtolower($status); ?> projects listed right now.</p>
                </div>
            <?php endif; ?>
        </div>
    </div>
</section>
<?php endforeach; ?>
<?php endif; ?>

<script>
function prjToggle(uid, btn) {
    var panel = document.getElementById('prj-details-' + uid);
    var open = panel.style.display === 'block';
    panel.style.display = open ? 'none' : 'block';
    btn.classList.toggle('open', !open);
    btn.querySelector('span').textContent = open ? 'View Details' : 'Hide Details';
}
</script>

<?php include 'includes/footer.php'; ?>
