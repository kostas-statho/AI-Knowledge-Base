# Next Actions — Mentoring Documentation

Generated: 2026-03-27

---

## Current Status

| Item | Status | Count |
|---|---|---|
| Mentor guides (total) | ✅ All created | 18 / 18 |
| Guides with Intragen style | ⚠️ Partial | 10 / 18 |
| Presentations | ❌ None yet | 0 / 18 |
| index.html Intragen style | ❌ Not done | - |
| Git commit | ❌ Pending | - |

---

## Guides still needing Intragen restyle

Run `restyle_guides.ps1` to fix all of these in one shot:

```
module_006_tpl_guide.html
module_010_cnr_guide.html
module_013_att_guide.html
module_015_rps_guide.html
module_016_psc_guide.html
module_019_dim_guide.html
module_024_001_dm_guide.html
module_024_004_ta_guide.html
```

---

## Step-by-step: What to run

### Step 1 — Restyle all remaining guides (instant, zero tokens)

```powershell
cd "C:\Users\OneIM\Knowledge_Base\Mentoring_Documentation"
powershell -File restyle_guides.ps1
```

Expected output: 8 restyled + 10 skipped (already Intragen).

---

### Step 2 — Generate all 18 presentations (instant, zero tokens)

```powershell
cd "C:\Users\OneIM\Knowledge_Base\Mentoring_Documentation"
powershell -File generate_presentations.ps1
```

Expected output: 18 HTML presentation files in `presentations\`.

---

### Step 3 — Update index.html to Intragen style

Ask Claude: *"Update index.html to use Intragen branding (purple sidebar, INTRAGEN. logo)"*
Or use the `/intragen-doc` skill.

---

### Step 4 — Git commit

```bash
cd "C:/Users/OneIM/Knowledge_Base"
git add Mentoring_Documentation/
git commit -m "Add Intragen-branded mentor guides and presentations for all 18 OIM Academy modules"
```

---

## Tools created (reusable, zero tokens)

| Tool | Location | Purpose |
|---|---|---|
| `restyle_guides.ps1` | `Mentoring_Documentation/` | Applies Intragen CSS to all guide HTML files |
| `generate_presentations.ps1` | `Mentoring_Documentation/` | Generates 18 HTML slide decks |
| `/intragen-guide` skill | `.claude/commands/intragen-guide.md` | Create any new guide with Intragen style |
| `/intragen-presentation` skill | `.claude/commands/intragen-presentation.md` | Create any new presentation with Intragen style |

---

## Adding a new module in future

1. Add docx exercises to `C:\Users\OneIM\Academy\Excercises\[new folder]\`
2. Run: `powershell -File "C:\Users\OneIM\AppData\Local\Temp\extract_docx.ps1"` to extract content
3. Use `/intragen-guide NNN "Module Name" Level` to create the guide
4. Use `/intragen-presentation NNN "Module Name" Level` to create the presentation
5. Run `restyle_guides.ps1` to verify style consistency
6. Git commit
