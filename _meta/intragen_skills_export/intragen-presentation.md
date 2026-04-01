# intragen-presentation

Create a new Intragen-branded HTML slide presentation for an OIM Academy module.

## Usage
```
/intragen-presentation <module_code> "<module_name>" <level>
```
Example: `/intragen-presentation 025 "Custom Connector" Advanced`

## What this produces
A self-contained HTML slide deck at:
`C:\Users\OneIM\Knowledge_Base\Mentoring_Documentation\presentations\module_<code>_presentation.html`

**OR** — run the generator script for all 18 modules at once:
```powershell
cd "C:\Users\OneIM\Knowledge_Base\Mentoring_Documentation"
powershell -File generate_presentations.ps1
```

## Slide structure (6 slides per presentation)

1. **Title slide** — module code, module name, level badge, INTRAGEN. logo, decorative circles
2. **What You Will Learn** — 4-6 key concept bullet points
3. **Prerequisites** — checklist of required prior knowledge/setup
4. **Exercises Overview** — grid of exercise chips (ID + short description)
5. **Mentor Tips & Common Mistakes** — 2-column card grid (warn=amber, good=green)
6. **Ready to Begin** — closing slide with next steps

## Intragen Brand Specification

```
Colors:
  --purple:      #7B2D8B
  --purple-dark: #5C1F6B
  --teal:        #007B77
  --golden:      #F0A800   (INTRAGEN. dot)

Slide types:
  .slide-title   → gradient(purple-dark → purple), white text, decorative circles
  .slide-content → white bg, purple header underline
  .slide-accent  → teal bg, white text (use for closing/emphasis slides)
  .slide-light   → #F0EDE8 bg (use for prerequisites)

Font: Inter (Google Fonts)
Aspect ratio: 16:9
Navigation: keyboard arrows + Prev/Next buttons + golden progress bar
```

## Required HTML structure

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>[Module Name] — Intragen Academy Presentation</title>
  <!-- Full Intragen presentation CSS (see generate_presentations.ps1 for reference) -->
</head>
<body>
<div id="progress"><div id="progress-bar" style="width:16.66%"></div></div>
<div id="presentation">
  <!-- 6 .slide divs: first has class="slide slide-title active" -->
</div>
<div id="nav">
  <button id="btn-prev" disabled>&larr; Prev</button>
  <span id="counter">1 / 6</span>
  <button id="btn-next">Next &rarr;</button>
</div>
<script>/* slide navigation — arrow keys + buttons */</script>
</body>
</html>
```

## INTRAGEN. logo placement
- Title slide: top-right, `font-size:0.85rem; letter-spacing:3px; opacity:0.7`
- All other slides: bottom-right corner, smaller, muted color
- Format always: `INTRAGEN<span class="logo-dot">.</span>` where `.logo-dot { color: #F0A800; }`

## Footer on closing slide
```html
INTRAGEN<span class="logo-dot">.</span> Academy — © Intragen International. Strictly private and confidential.
```

## Key rules
- NO external CSS/JS dependencies — everything inline
- Responsive: `max-width: 960px` centered on dark body background
- Progress bar fills from left in golden (#F0A800) as slides advance
- Content density: max 6 bullet points per slide, max 3 lines per bullet
- Exercise chips: show ID bold + short description (trim to ~8 words)
- For module data (exercises, prereqs, key concepts) — read from the guide file at
  `C:\Users\OneIM\Knowledge_Base\Mentoring_Documentation\guides\module_<code>_guide.html`
  OR from the extracted docx content at `C:\Users\OneIM\AppData\Local\Temp\modules\<CODE>.txt`

## Live example output
See `C:\Users\OneIM\Knowledge_Base\Mentoring\presentations\` for 18 completed presentations.
