# restyle_guides.ps1
# Applies Intragen branding to all mentor guide HTML files.
# Safe to re-run: skips files already restyled.

$guidesDir = "$PSScriptRoot\guides"
$files = Get-ChildItem $guidesDir -Filter "*.html"

$intragenCss = @'
:root {
  --purple:      #7B2D8B;
  --purple-dark: #5C1F6B;
  --teal:        #007B77;
  --golden:      #F0A800;
  /* Legacy variable overrides — keeps existing HTML class references working */
  --navy:  #7B2D8B;
  --blue:  #007B77;
  --green: #27AE60;
  --orange:#E67E22;
  --red:   #E74C3C;
  --bg:    #F0EDE8;
  /* New tokens */
  --body-bg:  #FAF8F5;
  --code-bg:  #1E1E1E;
  --border:   #DDD;
  --text:     #2C2C2C;
  --muted:    #6B6B6B;
}
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
body {
  font-family: 'Inter', 'Segoe UI', system-ui, sans-serif;
  font-size: 15px;
  line-height: 1.6;
  background: var(--bg);
  color: var(--text);
}
/* ── Layout ── */
.layout { display: grid; grid-template-columns: 260px 1fr; min-height: 100vh; }
/* ── Sidebar ── */
.sidebar {
  background: var(--purple);
  color: #fff;
  width: 260px;
  position: sticky;
  top: 0;
  height: 100vh;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
}
.logo, .intragen-logo {
  padding: 1.25rem 1rem;
  font-size: 0.95rem;
  font-weight: 700;
  letter-spacing: 3px;
  text-transform: uppercase;
  border-bottom: 1px solid rgba(255,255,255,0.15);
  color: #fff;
}
.logo-dot { color: var(--golden); }
.module-title, .module-title-sidebar {
  padding: 0.6rem 1rem 0.75rem;
  font-size: 0.82rem;
  font-weight: 600;
  color: var(--golden);
  border-bottom: 1px solid rgba(255,255,255,0.12);
}
.nav-label, .nav-section-label, .module-label {
  padding: 0.75rem 1rem 0.2rem;
  font-size: 0.65rem;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  color: rgba(255,255,255,0.4);
}
.sidebar a {
  display: block;
  padding: 0.4rem 1rem;
  color: rgba(255,255,255,0.75);
  text-decoration: none;
  font-size: 0.82rem;
  border-left: 3px solid transparent;
  transition: all 0.15s ease;
}
.sidebar a:hover {
  background: rgba(255,255,255,0.08);
  border-left-color: var(--teal);
  color: #fff;
}
/* ── Main ── */
main { padding: 2rem; max-width: 1080px; }
/* ── Module header ── */
.module-header {
  background: linear-gradient(135deg, var(--purple-dark) 0%, var(--purple) 100%);
  color: #fff;
  padding: 2rem 2rem 1.5rem;
  border-radius: 10px;
  margin-bottom: 2rem;
  position: relative;
  overflow: hidden;
}
.module-header::before {
  content: '';
  position: absolute;
  right: -20px; top: -20px;
  width: 160px; height: 160px;
  border-radius: 50%;
  background: rgba(255,255,255,0.05);
}
.module-header .intragen-watermark {
  position: absolute;
  top: 1rem; right: 1.5rem;
  font-size: 0.7rem;
  font-weight: 700;
  letter-spacing: 3px;
  text-transform: uppercase;
  opacity: 0.55;
}
.mod-num { display: inline-block; font-size: 2.5rem; font-weight: 900; opacity: 0.2; float: right; line-height: 1; }
.module-header h1 { font-size: 1.55rem; margin-bottom: 0.4rem; }
.module-header p  { opacity: 0.85; font-size: 0.9rem; }
/* ── Badges ── */
.badge { display: inline-block; padding: 0.2rem 0.7rem; border-radius: 999px; font-size: 0.72rem; font-weight: 700; text-transform: uppercase; }
.beginner    { background: #d4edda; color: #155724; }
.intermediate{ background: #fff3cd; color: #856404; }
.advanced    { background: #f8d7da; color: #721c24; }
/* ── Overview grid ── */
.overview-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 1.2rem; margin-bottom: 2rem; }
.info-card {
  background: #fff;
  border-left: 4px solid var(--teal);
  padding: 1.1rem 1.2rem;
  border-radius: 0 8px 8px 0;
  box-shadow: 0 1px 6px rgba(0,0,0,0.07);
}
.info-card h3 { color: var(--purple-dark); font-size: 0.9rem; margin-bottom: 0.5rem; text-transform: uppercase; letter-spacing: 0.05em; }
.info-card ul { padding-left: 1.2rem; }
.info-card li { font-size: 0.9rem; margin-bottom: 0.25rem; }
/* ── Sections ── */
section { margin-bottom: 2.5rem; }
section > h2 {
  color: var(--purple-dark);
  font-size: 1.15rem;
  border-bottom: 2px solid var(--teal);
  padding-bottom: 0.4rem;
  margin-bottom: 1.2rem;
}
.section-banner {
  background: var(--purple-dark);
  color: #fff;
  font-size: 0.75rem;
  font-weight: 700;
  letter-spacing: 1px;
  text-transform: uppercase;
  padding: 0.5rem 0.9rem;
  margin-bottom: 1.25rem;
  border-radius: 3px;
}
/* ── Exercise cards ── */
.exercise-card {
  background: #fff;
  border-radius: 0 8px 8px 0;
  box-shadow: 0 2px 10px rgba(0,0,0,0.06);
  padding: 1.4rem;
  margin-bottom: 1.4rem;
  border-left: 4px solid var(--teal);
}
.ex-header { display: flex; align-items: center; gap: 0.75rem; margin-bottom: 1rem; }
.ex-num {
  background: var(--purple-dark);
  color: #fff;
  min-width: 38px; height: 38px;
  border-radius: 50%;
  display: flex; align-items: center; justify-content: center;
  font-weight: 700; font-size: 0.8rem; flex-shrink: 0;
}
.ex-header h3 { color: var(--purple-dark); font-size: 1rem; margin: 0; }
.section-label {
  font-size: 0.72rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.08em;
  color: var(--teal);
  margin: 0.9rem 0 0.3rem;
}
/* ── Callouts ── */
.callout {
  padding: 0.85rem 1rem;
  border-radius: 0 8px 8px 0;
  margin: 0.8rem 0;
  font-size: 0.9rem;
}
.callout b, .callout strong {
  display: block;
  margin-bottom: 0.2rem;
  font-size: 0.75rem;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}
.callout-mentor, .callout-note  { border-left: 4px solid #2D6DB5; background: #E8F4FF; }
.callout-tip                    { border-left: 4px solid #22C55E; background: #F0FDF4; }
.callout-warn                   { border-left: 4px solid #F59E0B; background: #FFF8E1; }
.callout-error, .callout-important { border-left: 4px solid var(--purple); background: #F5EFF8; }
/* ── Steps / Lists ── */
.steps { padding-left: 1.4rem; margin: 0.4rem 0; }
.steps li { margin-bottom: 0.4rem; font-size: 0.9rem; }
li::marker { color: var(--purple); }
/* ── Code ── */
pre, .code-block {
  background: var(--code-bg);
  color: #D4D4D4;
  padding: 1rem 1.1rem;
  border-radius: 6px;
  overflow-x: auto;
  font-size: 0.82rem;
  line-height: 1.5;
  margin: 0.8rem 0;
  font-family: 'Cascadia Code','Fira Code', Consolas, 'Courier New', monospace;
  white-space: pre;
}
code {
  background: #EDE8F0;
  color: #8B2080;
  padding: 1px 5px;
  border-radius: 3px;
  font-family: 'Cascadia Code', Consolas, 'Courier New', monospace;
  font-size: 0.82rem;
}
pre code { background: none; color: inherit; padding: 0; }
/* ── Tables ── */
table { width: 100%; border-collapse: collapse; margin: 0.8rem 0; font-size: 0.88rem; }
thead tr, th { background: var(--purple-dark); color: #fff; }
th { padding: 0.55rem 0.9rem; text-align: left; font-size: 0.78rem; font-weight: 600; letter-spacing: 0.4px; }
td { padding: 0.55rem 0.9rem; border: 1px solid var(--border); vertical-align: top; }
tbody tr:nth-child(even), tr:nth-child(even) td { background: #F8F5FB; }
td.pass { color: #155724; font-weight: 600; }
td.fail { color: #721c24; font-weight: 600; }
/* ── Footer ── */
footer {
  text-align: center;
  padding: 1.5rem 1rem;
  color: var(--muted);
  font-size: 0.78rem;
  border-top: 2px solid #EDE8F0;
  margin-top: 2rem;
  background: #F5EFF8;
}
.footer-dot { color: var(--golden); }
h3 { color: var(--purple); }
h4 { color: #444; text-transform: uppercase; letter-spacing: 0.5px; font-size: 0.85rem; }
'@

$fontLinks = @'
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
'@

$intragenFooter = @'
<footer>
  INTRAGEN<span class="footer-dot">.</span> Academy &mdash; Mentoring Documentation &mdash;
  &copy; Intragen International. This document remains strictly private and confidential.
</footer>
'@

$skipped = 0
$updated = 0

foreach ($file in $files) {
    $html = Get-Content $file.FullName -Raw -Encoding UTF8

    # Skip if already Intragen-styled
    if ($html -match '#7B2D8B|--purple:') {
        Write-Host "SKIP (already Intragen): $($file.Name)" -ForegroundColor Gray
        $skipped++
        continue
    }

    # 1. Replace <style>...</style> block with Intragen CSS
    $newStyle = "<style>`n$intragenCss`n</style>"
    $html = [regex]::Replace($html, '(?s)<style>.*?</style>', $newStyle)

    # 2. Inject Google Fonts links before <style>
    $html = $html -replace '(<style>)', "$fontLinks`$1"

    # 3. Replace OIM Academy logo text with INTRAGEN. logo
    $html = $html -replace '(<div class="logo">)[^<]*(</div>)',
        '<div class="logo">INTRAGEN<span class="logo-dot">.</span></div>'

    # 4. Update <title> to include Intragen
    $html = $html -replace '(<title>[^<]*)(</title>)',
        '$1 | Intragen Academy$2'
    # Remove double "Intragen Academy" if already present
    $html = $html -replace '\| Intragen Academy \| Intragen Academy', '| Intragen Academy'

    # 5. Replace generic footer if exists, or append Intragen footer before </body>
    if ($html -match '<footer[^>]*>') {
        $html = [regex]::Replace($html, '(?s)<footer[^>]*>.*?</footer>', $intragenFooter)
    } else {
        $html = $html -replace '</body>', "$intragenFooter`n</body>"
    }

    # 6. Add INTRAGEN. watermark span inside .module-header if not present
    # (Injected after the first <div class="module-header"> tag)
    if ($html -notmatch 'intragen-watermark') {
        $watermark = '<span class="intragen-watermark">INTRAGEN<span class="footer-dot">.</span></span>'
        $html = $html -replace '(<div class="module-header">)', "`$1`n  $watermark"
    }

    # Save
    [System.IO.File]::WriteAllText($file.FullName, $html, [System.Text.Encoding]::UTF8)
    Write-Host "RESTYLED: $($file.Name)" -ForegroundColor Green
    $updated++
}

Write-Host ""
Write-Host "Done. Updated: $updated  |  Skipped (already Intragen): $skipped" -ForegroundColor Cyan
