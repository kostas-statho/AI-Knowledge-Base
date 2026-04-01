# Intragen Skills Export

Exported from `C:\Users\OneIM\.claude\commands\` on 2026-04-01.
Drop the four `.md` files into a Claude Code `commands/` directory (project-level `.claude/commands/`
or user-level `~/.claude/commands/`) to make them available as slash commands.

---

## Skills in this package

| File | Slash command | Purpose |
|---|---|---|
| `intragen-doc.md` | `/intragen-doc` | Reformat any HTML source into an Intragen PDF-style branded document |
| `intragen-guide.md` | `/intragen-guide` | Create an Intragen-branded OIM Academy mentor guide (or implementation guide) |
| `intragen-presentation.md` | `/intragen-presentation` | Create an Intragen-branded 6-slide HTML presentation for an Academy module |
| `intragen-validate.md` | `/intragen-validate` | Validate the IntragenAssistant WinForms app (pre-flight + manual test walkthrough) |

---

## Intragen Brand — Quick Reference

All four skills share the same visual identity. Key values:

| Token | Value | Used for |
|---|---|---|
| `--purple` | `#7B2D8B` | Sidebar bg, h3, bullets |
| `--purple-dark` | `#5C1F6B` | Section banners, table `<th>`, header gradient |
| `--teal` | `#007B77` | Accent borders, links, callout-tip |
| `--golden` | `#F0A800` | `INTRAGEN.` dot, progress bar, module title |
| Body bg (outer) | `#F0EDE8` | Page background |
| Content bg | `#FAF8F5` | Card / main area background |
| Code bg | `#1E1E1E` | Dark code blocks |
| Font | Inter (Google Fonts) | All text |

Logo format (always): `INTRAGEN<span class="logo-dot">.</span>` where `.logo-dot { color: #F0A800; }`

Footer (always): `INTRAGEN. Academy — Mentoring Documentation — © Intragen International. This document remains strictly private and confidential.`

---

## Output locations (source machine)

| Skill | Default output path |
|---|---|
| `/intragen-guide` | `Knowledge_Base\Mentoring\guides\module_<code>_guide.html` |
| `/intragen-presentation` | `Knowledge_Base\Mentoring\presentations\module_<code>_presentation.html` |
| `/intragen-doc` | Same directory as source, `_Intragen` appended before `.html` |
| `/intragen-guide` (impl variant) | `Knowledge_Base\Implementation_Guides\<ScenarioName>\` |

---

## Usage examples

```
/intragen-guide 025 "Custom Connector" Advanced
/intragen-presentation 017 "APIs" Intermediate
/intragen-doc C:\path\to\source.html
/intragen-validate quick
/intragen-validate full
```

---

## Notes for agents using these skills

- **`/intragen-guide`** has two modes: Academy module guides (with exercise cards and test tables) and
  implementation/reference guides (numbered sections, no test tables). The O3EMailbox conversion guide
  at `Implementation_Guides\O3EMailbox_Conversion\o3emailbox_conversion_impl_guide.html` is the
  canonical example of the implementation variant.

- **`/intragen-doc`** reads a source HTML file and reformats it into paginated A4 pages with cover,
  TOC, and section pages. It does NOT modify the source file.

- **`/intragen-validate`** is the only skill that requires the IntragenAssistant app to be present
  at `Tools\IntragenAssistant\`. It is not applicable if that app is not deployed.

- All HTML output is **fully self-contained** — no external CSS or JS, only a Google Fonts `@import`.
