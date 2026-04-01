# intragen-doc

Apply the Intragen brand documentation template to a source HTML file, producing a new self-contained HTML document that matches the Intragen PDF style.

## Usage
`/intragen-doc <source-html-path> [output-html-path]`

If no output path is given, write to the same directory as the source with `_Intragen` appended before `.html`.

## What to do

1. **Read the source file** in chunks to extract all content: headings, paragraphs, code blocks, tables, callout boxes, lists.
2. **Write the output file** as a single self-contained HTML using the Intragen template below.

---

## Intragen Template Specification

### Visual identity
- Logo: `INTRAGEN<span class="logo-dot">.</span>` — top-right every page, dot is amber `#F0A800`
- Primary purple: `#7B2D8B` — section banners, bullets, h3 colour
- Banner bg: `#5C1F6B` — full-width section header strips
- Teal accent: `#007B77` — sub-sub-section labels
- Body bg: `#FAF8F5` — warm off-white
- Cover decorative circles: blue `rgba(180,210,225,0.5)`, peach `rgba(230,185,165,0.4)`, yellow `rgba(235,220,160,0.5)`
- Table header bg: `#5C1F6B`, text white
- Code bg: `#1E1E1E`, text `#D4D4D4`
- Inline code bg: `#EDE8F0`, text `#8B2080`
- Page footer text: `"This document may be reproduced for use within the circulated parties but remains copyright of Intragen International. All documents remain strictly private and confidential."`

### Page structure (each is a `<div class="page">`)
1. **Cover page** — logo, title badge (purple rounded rect), subtitle, 3 CSS circles, footer
2. **TOC page** — logo, `<div class="contents-banner">CONTENTS</div>`, dotted-leader entries, footer
3. **One content-page per major section** — logo, section-banner, content, footer

### Section-banner format
```html
<div class="section-banner"><span class="section-num">N.</span> SECTION TITLE IN CAPS</div>
```
Strip emojis from headings. Number sections sequentially starting at 1.

### Sub-section box
```html
<div class="subsection-box">
  <div class="subsection-title">SUB-SECTION HEADING</div>
  ...content...
</div>
```

### Sub-sub-section label
```html
<span class="label-teal">LABEL NAME</span>
```

### Callout mapping
- `.note` / `.tip` → `<div class="callout callout-note"><strong>Note</strong>…</div>`
- `.warn` → `<div class="callout callout-warn"><strong>Important</strong>…</div>`
- `.new` → `<div class="callout callout-note"><strong>New in 9.3</strong>…</div>`

### Code blocks
```html
<div class="code-block">…exact code text…</div>
```
Preserve all whitespace and indentation exactly.

### Tables
Keep all table data. Apply `<th>` with purple-dark bg, `<td>` with light border.

---

## Full CSS (embed in `<style>`)

```css
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap');
:root{--purple:#7B2D8B;--purple-dark:#5C1F6B;--teal:#007B77;--body-bg:#FAF8F5;--code-bg:#1E1E1E;--border:#DDD;--text:#2C2C2C;--muted:#6B6B6B;}
*{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'Inter',-apple-system,BlinkMacSystemFont,'Segoe UI',sans-serif;background:#DDDDD5;color:var(--text);font-size:14px;line-height:1.7;}
.page{background:var(--body-bg);width:210mm;min-height:297mm;margin:20px auto;position:relative;box-shadow:0 4px 24px rgba(0,0,0,.18);overflow:hidden;}
/* Logo */
.intragen-logo{position:absolute;top:24px;right:28px;font-size:15px;font-weight:700;letter-spacing:2px;color:#1A1A1A;text-transform:uppercase;z-index:10;}
.logo-dot{color:#F0A800;}
/* Footer */
.page-footer{position:absolute;bottom:18px;left:32px;right:32px;display:flex;justify-content:space-between;align-items:center;font-size:9.5px;color:#999;border-top:1px solid #DDD;padding-top:7px;}
/* ── COVER ── */
.cover-page{min-height:297mm;}
.title-badge{position:absolute;top:110px;left:44px;background:var(--purple);color:#fff;font-size:20px;font-weight:700;padding:18px 28px;border-radius:10px;max-width:320px;line-height:1.35;}
.cover-subtitle{position:absolute;top:230px;left:44px;color:var(--muted);font-size:14px;font-weight:300;}
.cover-version{position:absolute;top:258px;left:44px;color:var(--muted);font-size:12px;}
.circle-blue{position:absolute;width:260px;height:260px;border-radius:50%;background:rgba(180,210,225,.5);top:140px;right:-50px;}
.circle-peach{position:absolute;width:340px;height:340px;border-radius:50%;background:rgba(230,185,165,.4);bottom:-100px;right:-70px;}
.circle-yellow{position:absolute;width:100px;height:100px;border-radius:50%;background:rgba(235,220,160,.5);bottom:90px;left:70px;}
/* ── TOC ── */
.toc-page{padding:44px 48px 70px;}
.contents-banner{background:var(--purple-dark);color:#fff;font-size:12px;font-weight:700;letter-spacing:1.5px;padding:9px 14px;margin:52px 0 24px;}
.toc-entry{display:flex;align-items:baseline;margin-bottom:5px;font-size:13px;}
.toc-entry .toc-title{flex:0 0 auto;}
.toc-entry .toc-dots{flex:1;border-bottom:1px dotted #AAA;margin:0 8px 3px;}
.toc-entry .toc-num{flex:0 0 auto;color:var(--muted);font-size:11px;}
.toc-sub{padding-left:20px;font-size:11.5px;color:var(--muted);margin-bottom:3px;display:flex;align-items:baseline;}
/* ── CONTENT ── */
.content-page{padding:44px 48px 80px;}
.section-banner{background:var(--purple-dark);color:#fff;font-size:12px;font-weight:700;letter-spacing:.8px;padding:9px 14px;margin-bottom:20px;margin-top:10px;}
.section-banner .section-num{opacity:.7;margin-right:6px;}
.subsection-box{border-top:2px solid #C0B0C0;padding-top:10px;margin:20px 0 12px;}
.subsection-title{font-size:11px;font-weight:700;letter-spacing:1.2px;text-transform:uppercase;color:#444;margin-bottom:10px;}
.label-teal{display:block;font-size:10.5px;font-weight:700;letter-spacing:1px;text-transform:uppercase;color:var(--teal);border-bottom:1px dotted var(--teal);padding-bottom:2px;margin:14px 0 7px;}
h3{font-size:14.5px;font-weight:700;color:var(--purple);margin:16px 0 8px;}
h4{font-size:11.5px;font-weight:700;color:#444;text-transform:uppercase;letter-spacing:.5px;margin:12px 0 5px;}
p{margin-bottom:10px;font-size:13.5px;}
ul,ol{margin:6px 0 10px 20px;font-size:13.5px;}
li{margin-bottom:3px;}
li::marker{color:var(--purple);}
/* Code */
.code-block{background:var(--code-bg);color:#D4D4D4;font-family:'Cascadia Code','Fira Code',Consolas,monospace;font-size:11.5px;line-height:1.5;padding:13px 15px;border-radius:4px;overflow-x:auto;margin:10px 0 14px;white-space:pre;}
code{background:#EDE8F0;color:#8B2080;font-family:'Cascadia Code','Fira Code',Consolas,monospace;font-size:11.5px;padding:1px 5px;border-radius:3px;}
/* Tables */
table{width:100%;border-collapse:collapse;margin:10px 0 16px;font-size:12.5px;}
th{background:var(--purple-dark);color:#fff;padding:7px 11px;text-align:left;font-size:11px;font-weight:600;letter-spacing:.4px;}
td{padding:6px 11px;border-bottom:1px solid var(--border);vertical-align:top;}
tr:nth-child(even) td{background:rgba(0,0,0,.02);}
/* Callouts */
.callout{padding:11px 13px;border-radius:0 4px 4px 0;margin:10px 0;font-size:13px;}
.callout strong{display:block;margin-bottom:2px;font-size:11px;text-transform:uppercase;letter-spacing:.5px;}
.callout-note{background:#E8F4FF;border-left:4px solid #2D6DB5;}
.callout-warn{background:#FFF8E1;border-left:4px solid #F59E0B;}
.callout-important{background:#F5EFF8;border-left:4px solid var(--purple);}
.callout-tip{background:#F0FDF4;border-left:4px solid #22C55E;}
/* State flow */
.state-flow{display:flex;flex-wrap:wrap;gap:4px;align-items:center;margin:10px 0;font-size:12px;}
.state-box{background:#fff;border:1px solid var(--border);border-radius:3px;padding:3px 9px;font-family:monospace;font-size:11.5px;}
.state-arrow{color:#888;font-size:13px;}
/* Endpoint grid */
.endpoint-grid{display:grid;grid-template-columns:1fr 1fr;gap:10px;margin:10px 0 16px;}
.endpoint-card{background:#fff;border:1px solid var(--border);border-radius:6px;padding:13px;border-top:3px solid var(--purple);}
.endpoint-card h4{margin:0 0 5px;font-size:12px;}
.endpoint-card p{font-size:11.5px;margin:0;}
.endpoint-card .url{font-family:monospace;font-size:10.5px;color:#8B2080;background:#EDE8F0;padding:2px 5px;border-radius:3px;margin-bottom:6px;display:inline-block;}
/* Print */
@media print{body{background:#fff;}.page{box-shadow:none;margin:0;width:100%;page-break-after:always;}.page:last-child{page-break-after:auto;}}
@media(max-width:800px){.page{width:100%;margin:0;}.title-badge{left:16px;right:16px;}.content-page,.toc-page{padding:24px 20px 60px;}}
```

---

## Output requirements

- Single `.html` file, all CSS in `<style>` tag, no external dependencies except the Google Fonts `@import`
- Every `.page` div gets `.intragen-logo` and `.page-footer`
- TOC entries link to section IDs via `href="#section-N"`
- Content pages have `id="section-N"` matching TOC
- Preserve ALL source content — no section may be omitted or summarised
