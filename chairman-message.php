<?php
require_once 'includes/config.php';
$page_title = "Chairman's Message";
$page_description = "Read a message from the Chairman of Bahawal College of Health Sciences on our vision for quality health sciences education.";

// Reuses the existing Leadership CMS (AdminCP > Home Page > Leadership) — no separate
// admin section to duplicate. We identify the Chairman by designation/role containing
// "chairman", matching how the entry is already tagged in the real leadership data.
$chairman = mysqli_fetch_assoc(mysqli_query($conn, "
    SELECT * FROM leadership
    WHERE status = 'active' AND (LOWER(designation) LIKE '%chairman%' OR LOWER(role_title) LIKE '%chairman%')
    ORDER BY display_order ASC LIMIT 1
"));
?>
<?php include 'includes/header.php'; ?>

<style>
/* ===== CHAIRMAN'S MESSAGE PAGE ===== */

.chm-hero {
    background: linear-gradient(135deg,#0D1048 0%,#17165B 55%,#0D1048 100%);
    padding: 62px 0 50px;
    position: relative; overflow: hidden;
}
.chm-hero::after {
    content:'';
    position:absolute; bottom:-1px; left:0; right:0;
    height:40px;
    background:#F5F9FC;
    clip-path:ellipse(55% 100% at 50% 100%);
}
.chm-breadcrumb {
    display:flex; align-items:center; gap:8px;
    font-size:12px; color:rgba(255,255,255,0.5); margin-bottom:18px;
    position:relative; z-index:1;
}
.chm-breadcrumb a { color:rgba(255,255,255,0.6); text-decoration:none; }
.chm-breadcrumb a:hover { color:var(--accent-color); }
.chm-hero-badge {
    display:inline-flex; align-items:center; gap:7px;
    background:rgba(9,169,217,0.14); border:1px solid rgba(9,169,217,0.35);
    color:var(--accent-color); padding:6px 18px; border-radius:50px;
    font-size:10.5px; font-weight:700; letter-spacing:2px;
    text-transform:uppercase; margin-bottom:16px;
    position:relative; z-index:1;
}
.chm-hero h1 {
    font-size:38px; font-weight:800; color:#fff;
    margin:0 0 12px; line-height:1.15;
    position:relative; z-index:1;
}
.chm-hero h1 span { color:var(--accent-color); }
.chm-hero p {
    color:rgba(255,255,255,0.72); font-size:15px; margin:0; max-width:560px; line-height:1.7;
    position:relative; z-index:1;
}

.chm-section { padding:52px 0 64px; background:#F5F9FC; }

/* --- Message card --- */
.chm-card {
    background:#fff; border-radius:24px; border:1px solid rgba(23,22,91,0.1);
    box-shadow:0 10px 40px rgba(23,22,91,0.08);
    overflow:hidden; display:grid; grid-template-columns:320px 1fr;
    max-width:1000px; margin:0 auto;
}
@media (max-width:800px) { .chm-card { grid-template-columns:1fr; } }

.chm-photo-side {
    background:linear-gradient(160deg,var(--primary-color) 0%,#0D1048 100%);
    display:flex; flex-direction:column; align-items:center; justify-content:center;
    padding:44px 32px; text-align:center;
}
.chm-photo-wrap { position:relative; margin-bottom:22px; }
.chm-photo {
    width:170px; height:170px; border-radius:50%; object-fit:cover; object-position:center top;
    border:4px solid rgba(255,255,255,0.25); display:block;
}
.chm-photo-placeholder {
    width:170px; height:170px; border-radius:50%;
    background:rgba(255,255,255,0.1); display:flex; align-items:center; justify-content:center;
    font-size:64px; color:rgba(255,255,255,0.5); border:4px solid rgba(255,255,255,0.15);
}
.chm-role-badge {
    display:inline-block; background:var(--accent-color); color:#fff;
    font-size:10px; font-weight:700; letter-spacing:1.5px; text-transform:uppercase;
    padding:5px 16px; border-radius:50px; margin-bottom:10px;
}
.chm-name { font-size:22px; font-weight:800; color:#fff; margin:0 0 4px; }
.chm-desig { font-size:13px; color:rgba(255,255,255,0.65); }

.chm-msg-side { padding:48px 52px; display:flex; flex-direction:column; justify-content:center; position:relative; }
.chm-quote-bg {
    position:absolute; top:14px; left:24px; font-size:160px; font-family:Georgia,serif; font-weight:900;
    color:var(--primary-color); opacity:0.05; line-height:1; pointer-events:none; user-select:none;
}
.chm-quote-icon { display:flex; align-items:center; gap:12px; margin-bottom:20px; position:relative; z-index:1; }
.chm-quote-icon i { font-size:26px; color:var(--primary-color); opacity:0.7; }
.chm-quote-icon span { height:2px; width:50px; background:linear-gradient(90deg,var(--primary-color),transparent); border-radius:2px; }
.chm-message { font-size:15px; line-height:1.9; color:var(--text-dark); font-style:italic; position:relative; z-index:1; }
.chm-sig-row { display:flex; align-items:center; gap:16px; margin-top:26px; padding-top:20px; border-top:1px solid rgba(23,22,91,0.1); position:relative; z-index:1; }
.chm-sig-img { height:40px; width:auto; max-width:130px; opacity:0.75; filter:saturate(0); }
.chm-sig-name { font-size:14.5px; font-weight:700; color:var(--primary-color); display:block; }
.chm-sig-role { font-size:12px; color:var(--text-light); }

@media (max-width:800px) {
    .chm-photo-side { padding:38px 30px; }
    .chm-msg-side { padding:36px 30px; }
}

/* --- CMS placeholder --- */
.chm-placeholder {
    max-width:640px; margin:0 auto; text-align:center; padding:60px 30px;
    background:#fff; border-radius:20px; border:1px dashed rgba(23,22,91,0.25);
}
.chm-placeholder i { font-size:44px; color:var(--border-color); margin-bottom:16px; display:block; }
.chm-placeholder h3 { color:var(--text-dark); font-size:18px; margin:0 0 8px; }
.chm-placeholder p { color:var(--text-light); font-size:13.5px; margin:0 auto; max-width:460px; line-height:1.7; }
</style>

<!-- HERO -->
<section class="chm-hero">
    <div class="container" style="position:relative;z-index:2;">
        <div class="chm-breadcrumb">
            <a href="index.php"><i class="fas fa-home" style="font-size:11px;"></i> Home</a>
            <span><i class="fas fa-chevron-right" style="font-size:9px;"></i></span>
            <span>Chairman's Message</span>
        </div>
        <div class="chm-hero-badge">
            <i class="fas fa-quote-left"></i> A Message From Our Chairman
        </div>
        <h1>Chairman's <span>Message</span></h1>
        <p>A word from the Chairman of <?php echo htmlspecialchars(getSiteName()); ?>.</p>
    </div>
</section>

<!-- MESSAGE -->
<section class="chm-section">
    <div class="container">
        <?php if ($chairman): ?>
        <div class="chm-card">
            <div class="chm-photo-side">
                <div class="chm-photo-wrap">
                    <?php if (!empty($chairman['photo'])): ?>
                        <img src="<?php echo htmlspecialchars($chairman['photo']); ?>" alt="<?php echo htmlspecialchars($chairman['name']); ?>" class="chm-photo" onerror="this.parentElement.innerHTML='<div class=\'chm-photo-placeholder\'><i class=\'fas fa-user-tie\'></i></div>'">
                    <?php else: ?>
                        <div class="chm-photo-placeholder"><i class="fas fa-user-tie"></i></div>
                    <?php endif; ?>
                </div>
                <?php if (!empty($chairman['role_title'])): ?>
                <span class="chm-role-badge"><?php echo htmlspecialchars($chairman['role_title']); ?></span>
                <?php endif; ?>
                <h3 class="chm-name"><?php echo htmlspecialchars($chairman['name']); ?></h3>
                <p class="chm-desig"><?php echo htmlspecialchars($chairman['designation']); ?></p>
            </div>
            <div class="chm-msg-side">
                <span class="chm-quote-bg">&#10077;</span>
                <div class="chm-quote-icon"><i class="fas fa-quote-left"></i><span></span></div>
                <div class="chm-message"><?php echo nl2br(htmlspecialchars($chairman['message'])); ?></div>
                <div class="chm-sig-row">
                    <?php if (!empty($chairman['signature'])): ?>
                    <img src="<?php echo htmlspecialchars($chairman['signature']); ?>" alt="Signature" class="chm-sig-img" loading="lazy" onerror="this.style.display='none'">
                    <div style="width:1px;height:34px;background:rgba(23,22,91,0.15);"></div>
                    <?php endif; ?>
                    <div>
                        <strong class="chm-sig-name"><?php echo htmlspecialchars($chairman['name']); ?></strong>
                        <span class="chm-sig-role"><?php echo htmlspecialchars($chairman['designation']); ?></span>
                    </div>
                </div>
            </div>
        </div>
        <?php else: ?>
        <div class="chm-placeholder">
            <i class="fas fa-user-tie"></i>
            <h3>Chairman's Message — Coming Soon</h3>
            <p>The Chairman's verified name, photo and message have not been published yet. This page will be updated once confirmed — nothing here is fabricated in the meantime.</p>
        </div>
        <?php endif; ?>
    </div>
</section>

<?php include 'includes/footer.php'; ?>
