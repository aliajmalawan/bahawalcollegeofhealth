<?php
require_once 'includes/config.php';
$page_title = "Principal's Message";
$page_description = "Read a welcome message from the Principal of Bahawal College of Health Sciences about our approach to health sciences education.";

// Reuses the existing Leadership CMS (AdminCP > Home Page > Leadership) — no separate
// admin section to build. We identify the Principal by designation/role containing
// "principal" but excluding "vice principal", so admins can add this simply by
// creating a leadership entry with Designation "Principal".
$principal = mysqli_fetch_assoc(mysqli_query($conn, "
    SELECT * FROM leadership
    WHERE status = 'active'
      AND (LOWER(designation) LIKE '%principal%' OR LOWER(role_title) LIKE '%principal%')
      AND LOWER(designation) NOT LIKE '%vice%' AND LOWER(role_title) NOT LIKE '%vice%'
    ORDER BY display_order ASC LIMIT 1
"));
?>
<?php include 'includes/header.php'; ?>

<style>
/* ===== PRINCIPAL'S MESSAGE PAGE ===== */

.prm-hero {
    background: linear-gradient(135deg,#0D1048 0%,#17165B 55%,#0D1048 100%);
    padding: 62px 0 50px;
    position: relative; overflow: hidden;
}
.prm-hero::after {
    content:'';
    position:absolute; bottom:-1px; left:0; right:0;
    height:40px;
    background:#F5F9FC;
    clip-path:ellipse(55% 100% at 50% 100%);
}
.prm-breadcrumb {
    display:flex; align-items:center; gap:8px;
    font-size:12px; color:rgba(255,255,255,0.5); margin-bottom:18px;
    position:relative; z-index:1;
}
.prm-breadcrumb a { color:rgba(255,255,255,0.6); text-decoration:none; }
.prm-breadcrumb a:hover { color:var(--accent-color); }
.prm-hero-badge {
    display:inline-flex; align-items:center; gap:7px;
    background:rgba(9,169,217,0.14); border:1px solid rgba(9,169,217,0.35);
    color:var(--accent-color); padding:6px 18px; border-radius:50px;
    font-size:10.5px; font-weight:700; letter-spacing:2px;
    text-transform:uppercase; margin-bottom:16px;
    position:relative; z-index:1;
}
.prm-hero h1 {
    font-size:38px; font-weight:800; color:#fff;
    margin:0 0 12px; line-height:1.15;
    position:relative; z-index:1;
}
.prm-hero h1 span { color:var(--accent-color); }
.prm-hero p {
    color:rgba(255,255,255,0.72); font-size:15px; margin:0; max-width:560px; line-height:1.7;
    position:relative; z-index:1;
}

.prm-section { padding:52px 0 64px; background:#F5F9FC; }

/* --- Message card --- */
.prm-card {
    background:#fff; border-radius:24px; border:1px solid rgba(23,22,91,0.1);
    box-shadow:0 10px 40px rgba(23,22,91,0.08);
    overflow:hidden; display:grid; grid-template-columns:320px 1fr;
    max-width:1000px; margin:0 auto;
}
@media (max-width:800px) { .prm-card { grid-template-columns:1fr; } }

.prm-photo-side {
    background:linear-gradient(160deg,var(--primary-color) 0%,#0D1048 100%);
    display:flex; flex-direction:column; align-items:center; justify-content:center;
    padding:44px 32px; text-align:center;
}
.prm-photo-wrap { position:relative; margin-bottom:22px; }
.prm-photo {
    width:170px; height:170px; border-radius:50%; object-fit:cover; object-position:center top;
    border:4px solid rgba(255,255,255,0.25); display:block;
}
.prm-photo-placeholder {
    width:170px; height:170px; border-radius:50%;
    background:rgba(255,255,255,0.1); display:flex; align-items:center; justify-content:center;
    font-size:64px; color:rgba(255,255,255,0.5); border:4px solid rgba(255,255,255,0.15);
}
.prm-role-badge {
    display:inline-block; background:var(--accent-color); color:#fff;
    font-size:10px; font-weight:700; letter-spacing:1.5px; text-transform:uppercase;
    padding:5px 16px; border-radius:50px; margin-bottom:10px;
}
.prm-name { font-size:22px; font-weight:800; color:#fff; margin:0 0 4px; }
.prm-desig { font-size:13px; color:rgba(255,255,255,0.65); }

.prm-msg-side { padding:48px 52px; display:flex; flex-direction:column; justify-content:center; position:relative; }
.prm-quote-bg {
    position:absolute; top:14px; left:24px; font-size:160px; font-family:Georgia,serif; font-weight:900;
    color:var(--primary-color); opacity:0.05; line-height:1; pointer-events:none; user-select:none;
}
.prm-quote-icon { display:flex; align-items:center; gap:12px; margin-bottom:20px; position:relative; z-index:1; }
.prm-quote-icon i { font-size:26px; color:var(--primary-color); opacity:0.7; }
.prm-quote-icon span { height:2px; width:50px; background:linear-gradient(90deg,var(--primary-color),transparent); border-radius:2px; }
.prm-message { font-size:15px; line-height:1.9; color:var(--text-dark); font-style:italic; position:relative; z-index:1; }
.prm-sig-row { display:flex; align-items:center; gap:16px; margin-top:26px; padding-top:20px; border-top:1px solid rgba(23,22,91,0.1); position:relative; z-index:1; }
.prm-sig-img { height:40px; width:auto; max-width:130px; opacity:0.75; filter:saturate(0); }
.prm-sig-name { font-size:14.5px; font-weight:700; color:var(--primary-color); display:block; }
.prm-sig-role { font-size:12px; color:var(--text-light); }

@media (max-width:800px) {
    .prm-photo-side { padding:38px 30px; }
    .prm-msg-side { padding:36px 30px; }
}

/* --- CMS placeholder --- */
.prm-placeholder {
    max-width:640px; margin:0 auto; text-align:center; padding:60px 30px;
    background:#fff; border-radius:20px; border:1px dashed rgba(23,22,91,0.25);
}
.prm-placeholder i { font-size:44px; color:var(--border-color); margin-bottom:16px; display:block; }
.prm-placeholder h3 { color:var(--text-dark); font-size:18px; margin:0 0 8px; }
.prm-placeholder p { color:var(--text-light); font-size:13.5px; margin:0 auto; max-width:460px; line-height:1.7; }
</style>

<!-- HERO -->
<section class="prm-hero">
    <div class="container" style="position:relative;z-index:2;">
        <div class="prm-breadcrumb">
            <a href="index.php"><i class="fas fa-home" style="font-size:11px;"></i> Home</a>
            <span><i class="fas fa-chevron-right" style="font-size:9px;"></i></span>
            <span>Principal's Message</span>
        </div>
        <div class="prm-hero-badge">
            <i class="fas fa-quote-left"></i> A Message From Our Principal
        </div>
        <h1>Principal's <span>Message</span></h1>
        <p>A word from the Principal of <?php echo htmlspecialchars(getSiteName()); ?>.</p>
    </div>
</section>

<!-- MESSAGE -->
<section class="prm-section">
    <div class="container">
        <?php if ($principal): ?>
        <div class="prm-card">
            <div class="prm-photo-side">
                <div class="prm-photo-wrap">
                    <?php if (!empty($principal['photo'])): ?>
                        <img src="<?php echo htmlspecialchars($principal['photo']); ?>" alt="<?php echo htmlspecialchars($principal['name']); ?>" class="prm-photo" onerror="this.parentElement.innerHTML='<div class=\'prm-photo-placeholder\'><i class=\'fas fa-user-tie\'></i></div>'">
                    <?php else: ?>
                        <div class="prm-photo-placeholder"><i class="fas fa-user-tie"></i></div>
                    <?php endif; ?>
                </div>
                <?php if (!empty($principal['role_title'])): ?>
                <span class="prm-role-badge"><?php echo htmlspecialchars($principal['role_title']); ?></span>
                <?php endif; ?>
                <h3 class="prm-name"><?php echo htmlspecialchars($principal['name']); ?></h3>
                <p class="prm-desig"><?php echo htmlspecialchars($principal['designation']); ?></p>
            </div>
            <div class="prm-msg-side">
                <span class="prm-quote-bg">&#10077;</span>
                <div class="prm-quote-icon"><i class="fas fa-quote-left"></i><span></span></div>
                <div class="prm-message"><?php echo nl2br(htmlspecialchars($principal['message'])); ?></div>
                <div class="prm-sig-row">
                    <?php if (!empty($principal['signature'])): ?>
                    <img src="<?php echo htmlspecialchars($principal['signature']); ?>" alt="Signature" class="prm-sig-img" loading="lazy" onerror="this.style.display='none'">
                    <div style="width:1px;height:34px;background:rgba(23,22,91,0.15);"></div>
                    <?php endif; ?>
                    <div>
                        <strong class="prm-sig-name"><?php echo htmlspecialchars($principal['name']); ?></strong>
                        <span class="prm-sig-role"><?php echo htmlspecialchars($principal['designation']); ?></span>
                    </div>
                </div>
            </div>
        </div>
        <?php else: ?>
        <div class="prm-placeholder">
            <i class="fas fa-user-tie"></i>
            <h3>Principal's Message — Coming Soon</h3>
            <p>The Principal's verified photo and message have not been published yet. This page will be updated once confirmed — nothing here is fabricated in the meantime.</p>
        </div>
        <?php endif; ?>
    </div>
</section>

<?php include 'includes/footer.php'; ?>
