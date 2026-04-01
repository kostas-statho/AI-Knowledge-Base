# intragen-guide

Create a new Intragen-branded mentor guide HTML file for an OIM Academy module.

## Usage
```
/intragen-guide <module_code> "<module_name>" <level>
```
Example: `/intragen-guide 025 "Custom Connector" Advanced`

## What this produces
A self-contained HTML file at:
`C:\Users\OneIM\Knowledge_Base\Mentoring_Documentation\guides\module_<code>_guide.html`

## Intragen Brand CSS Specification

Use these exact values — no deviation:

```
Colors:
  --purple:      #7B2D8B   (sidebar bg, h3)
  --purple-dark: #5C1F6B   (section banners, table th, module header gradient start)
  --teal:        #007B77   (accent borders, links, callout-tip icon, hover border)
  --golden:      #F0A800   (INTRAGEN. dot, module title in sidebar)
  Body bg outer: #F0EDE8
  Content bg:    #FAF8F5
  Code bg:       #1E1E1E
  Border:        #DDD
  Text:          #2C2C2C

Font: Inter (Google Fonts import)
```

## Required structure

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Module XXX — [Name] — Mentor Guide | Intragen Academy</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
  <style>
    /* Full Intragen CSS — see spec above */
  </style>
</head>
<body>
<div class="layout">
  <nav class="sidebar">
    <div class="intragen-logo">INTRAGEN<span class="logo-dot">.</span></div>
    <div class="module-title-sidebar">MODULE [CODE] — [NAME]</div>
    <!-- Nav links with anchor IDs per exercise -->
  </nav>
  <main>
    <div class="module-header">
      <span class="intragen-watermark">INTRAGEN<span style="color:#F0A800">.</span></span>
      <h1>[Module Name]</h1>
      <p>[Brief description]</p>
      <span class="badge [level]">[Level]</span>
    </div>
    <!-- Exercise cards -->
    <footer>
      INTRAGEN<span class="footer-dot">.</span> Academy — Mentoring Documentation —
      © Intragen International. This document remains strictly private and confidential.
    </footer>
  </main>
</div>
</body>
</html>
```

## Exercise card structure (repeat for each exercise)

```html
<section id="ex-N">
  <div class="exercise-card">
    <div class="ex-header">
      <div class="ex-num">N</div>
      <h3>Exercise ID — Title</h3>
    </div>

    <div class="section-label">Requirements</div>
    <p>...</p>

    <div class="section-label">Solution Steps</div>
    <ol class="steps">
      <li>Step 1</li>
    </ol>

    <div class="section-label">Test Cases</div>
    <table>
      <thead><tr><th>#</th><th>Test Scenario</th><th>Test Steps</th><th>Expected Results</th><th>Mentor Notes</th></tr></thead>
      <tbody>
        <tr><td>1</td><td>...</td><td>...</td><td>...</td><td></td></tr>
      </tbody>
    </table>

    <div class="callout callout-tip">
      <strong>Mentor Tips</strong>
      ...
    </div>
  </div>
</section>
```

## Key rules
- Extract exercise content from the docx files in `C:\Users\OneIM\Academy\Excercises\[module folder]\`
- Use the PowerShell extraction pattern from `C:\Users\OneIM\AppData\Local\Temp\extract_docx.ps1`
- Pre-extracted content available in `C:\Users\OneIM\AppData\Local\Temp\modules\[CODE].txt`
- ALWAYS use real exercise content — never invent/assume requirements
- Include all test table rows exactly as in the docx
- Run `restyle_guides.ps1` after creation to verify Intragen CSS is consistent

## Live example output
See `C:\Users\OneIM\Knowledge_Base\Mentoring\guides\` for 18 completed guides following this pattern.
The most complete reference implementations are `module_017_api_guide.html` (API module) and
`module_024_002_ba_guide.html` (Bulk Actions module).

## Implementation guide variant
This skill is also used for non-Academy implementation guides saved to
`C:\Users\OneIM\Knowledge_Base\Implementation_Guides\<ScenarioName>\`.
In that variant, omit the module code/level and replace exercise cards with
implementation section cards (numbered 01, 02, 03…). See
`Implementation_Guides\O3EMailbox_Conversion\o3emailbox_conversion_impl_guide.html`
for a working example of this variant.
