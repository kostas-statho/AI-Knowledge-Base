# Mentoring — OIM Academy Module Registry

> 18 Intragen-branded OIM Academy module guides and presentations.
> Entry point: `Mentoring/index.html`
> Skills: `/intragen-guide NNN "Name"` | `/intragen-presentation NNN "Name"`

---

## Module Registry

| Module | Short Name | Guide | Presentation | Added |
|---|---|---|---|---|
| 005 | BAS — Business Access Scaling | `guides/module_005_bas_guide.html` | `presentations/module_005_bas_presentation.html` | 2026-03-27 |
| 006 | TPL — Templates | `guides/module_006_tpl_guide.html` | `presentations/module_006_tpl_presentation.html` | 2026-03-27 |
| 007 | PRO — Processes | `guides/module_007_pro_guide.html` | `presentations/module_007_pro_presentation.html` | 2026-03-27 |
| 008 | TSA — Technical Service Administration | `guides/module_008_tsa_guide.html` | `presentations/module_008_tsa_presentation.html` | 2026-03-27 |
| 009 | SCN — Scenarios | `guides/module_009_scn_guide.html` | `presentations/module_009_scn_presentation.html` | 2026-03-27 |
| 010 | CNR — Control and Reporting | `guides/module_010_cnr_guide.html` | `presentations/module_010_cnr_presentation.html` | 2026-03-27 |
| 011 | WFL — Workflows | `guides/module_011_wfl_guide.html` | `presentations/module_011_wfl_presentation.html` | 2026-03-27 |
| 012 | PMS — Process Management System | `guides/module_012_pms_guide.html` | `presentations/module_012_pms_presentation.html` | 2026-03-27 |
| 013 | ATT — Attestation | `guides/module_013_att_guide.html` | `presentations/module_013_att_presentation.html` | 2026-03-27 |
| 014 | TRS — Transport & Synchronization | `guides/module_014_trs_guide.html` | `presentations/module_014_trs_presentation.html` | 2026-03-27 |
| 015 | RPS — Reporting & Portal Setup | `guides/module_015_rps_guide.html` | `presentations/module_015_rps_presentation.html` | 2026-03-27 |
| 016 | PSC — Portal Service Catalog | `guides/module_016_psc_guide.html` | `presentations/module_016_psc_presentation.html` | 2026-03-27 |
| 017 | API — APIs | `guides/module_017_api_guide.html` | `presentations/module_017_api_presentation.html` | 2026-03-27 |
| 019 | DIM — Data Integration Module | `guides/module_019_dim_guide.html` | `presentations/module_019_dim_presentation.html` | 2026-03-27 |
| 024.001 | DM — Deployment & Migration | `guides/module_024_001_dm_guide.html` | `presentations/module_024_001_dm_presentation.html` | 2026-03-27 |
| 024.002 | BA — Backup & Administration | `guides/module_024_002_ba_guide.html` | `presentations/module_024_002_ba_presentation.html` | 2026-03-27 |
| 024.003 | DE — Disaster & Emergency | `guides/module_024_003_de_guide.html` | `presentations/module_024_003_de_presentation.html` | 2026-03-27 |
| 024.004 | TA — Troubleshooting & Analysis | `guides/module_024_004_ta_guide.html` | `presentations/module_024_004_ta_presentation.html` | 2026-03-27 |

---

## Branding

Intragen color scheme: purple `#7B2D8B`, teal `#007B77`, golden `#F0A800`
Font: Inter (300, 400, 600, 700)
CSS: `assets/style.css`
Layout: 260px sidebar + content area

---

## Adding a New Module

1. Run `/intragen-guide NNN "Module Name" Level` → saves to `Mentoring/guides/module_NNN_guide.html`
2. Run `/intragen-presentation NNN "Module Name" Level` → saves to `Mentoring/presentations/module_NNN_*.html`
3. Add row to this INDEX.md
4. Update `Mentoring/index.html` nav grid
5. Update root `INDEX.md` — Mentoring section
6. Commit: `/git-commit-push`

## Regeneration Scripts

- `Mentoring/restyle_guides.ps1` — Apply Intragen CSS to all guides
- `Mentoring/generate_presentations.ps1` — Regenerate all presentations
