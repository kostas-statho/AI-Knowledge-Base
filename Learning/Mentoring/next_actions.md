# Next Actions — Mentoring Documentation

Generated: 2026-03-27

---

## Current Status — ALL COMPLETE

| Item | Status | Count |
|---|---|---|
| Mentor guides (total) | ✅ Done | 18 / 18 |
| Guides with Intragen style | ✅ Done | 18 / 18 |
| Presentations | ✅ Done | 18 / 18 |
| index.html Intragen style | ✅ Done | - |
| Git commit | ✅ Done | 2 commits |

---

## Git log (last 2 commits)

```
d586ffc  Update index.html to Intragen branding and fix presentation links
542d345  Add Intragen-branded mentor guides and presentations for all 18 OIM Academy modules
```

---

## Adding a new module in future

1. Add docx exercises to `C:\Users\OneIM\Academy\Excercises\[new folder]\`
2. Run: `powershell -File "C:\Users\OneIM\AppData\Local\Temp\extract_docx.ps1"` to extract content
3. Use `/intragen-guide NNN "Module Name" Level` to create the guide
4. Use `/intragen-presentation NNN "Module Name" Level` to create the presentation
5. Add a new `.mod-card` entry to `index.html` following the existing pattern
6. Run `restyle_guides.ps1` to verify style consistency
7. Git commit

---

## Tools available (reusable, zero tokens)

| Tool | Location | Purpose |
|---|---|---|
| `restyle_guides.ps1` | `Mentoring_Documentation/` | Applies Intragen CSS to all guide HTML files |
| `generate_presentations.ps1` | `Mentoring_Documentation/` | Regenerates all 18 HTML slide decks |
| `/intragen-guide` skill | `.claude/commands/intragen-guide.md` | Create any new guide with Intragen style |
| `/intragen-presentation` skill | `.claude/commands/intragen-presentation.md` | Create any new presentation with Intragen style |
