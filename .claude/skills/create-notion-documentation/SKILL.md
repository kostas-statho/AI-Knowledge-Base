---
name: create-notion-documentation
description: Convert any documentation source (HTML, Markdown, plain text) into a Notion-ready workspace folder — CSVs for databases, Markdown reference pages, and a step-by-step setup guide in the auto-detected language.
argument-hint: "<source-path> [--output <folder>] [--lang el|en] [--name <workspace-title>]"
user-invocable: true
allowed-tools: "Read, Write, Bash, Glob"
---

Convert a source document into a complete Notion workspace folder ready to import.

## Step 0 — Parse arguments

Parse `$ARGUMENTS` using this table:

| Token | Variable | Default |
|---|---|---|
| First non-flag value | `SOURCE_PATH` | Required |
| `--output <folder>` | `OUTPUT_DIR` | `parent(SOURCE_PATH)/Notion_<Name>_Workspace` |
| `--lang el\|en` | `LANG` | Auto-detect (Step 1b) |
| `--name <title>` | `WORKSPACE_NAME` | Derived from source (Step 1c) |

If `SOURCE_PATH` is not provided, stop and print:
```
Missing source path.
Usage: /create-notion-documentation <source-path> [--output <folder>] [--lang el|en] [--name <title>]
```

## Step 1 — Read and analyze source

Read the file at `SOURCE_PATH` in full. For files larger than 1000 lines, read in 500-line chunks until all content is processed.

### 1a — Detect language (skip if `--lang` was given)

Count characters in the first 500 characters of source content:
- Greek (U+0370–U+03FF, U+1F00–U+1FFF): `greek_count`
- Total non-whitespace: `total_count`

If `greek_count / total_count > 0.40`: set `LANG=el`. Otherwise set `LANG=en`.

Language constants:

| Variable | `LANG=el` | `LANG=en` |
|---|---|---|
| `SETUP_FILENAME` | `SETUP_ΟΔΗΓΟΣ.md` | `SETUP_GUIDE.md` |
| `SETUP_TITLE` | `Οδηγός Εγκατάστασης` | `Setup Guide` |
| `FOR_LABEL` | `Για` | `For` |
| `SETUP_TIME_LABEL` | `Χρόνος εγκατάστασης` | `Setup time` |
| `NEED_LABEL` | `Τι θα χρειαστείτε` | `What you need` |
| `DAILY_USE_LABEL` | `Ημερήσια Χρήση` | `Daily Use` |

### 1b — Derive workspace name (skip if `--name` was given)

Check in order of preference:
1. HTML `<title>` tag content (strip HTML entities)
2. First `# ` heading in Markdown
3. File basename without extension, with underscores/hyphens replaced by spaces, first letter capitalized

### 1c — Determine output directory (skip if `--output` was given)

```
OUTPUT_DIR = parent_of(SOURCE_PATH) + "/Notion_" + WORKSPACE_NAME.replace(" ","_") + "_Workspace"
```

Example: `Docs/acl_recovery_visual.html` → `Docs/Notion_ACL_Recovery_Visual_Workspace/`

### 1d — Print preview and check for existing output

Print:
```
Notion workspace generator
──────────────────────────────────────────
Source     : <SOURCE_PATH>
Output     : <OUTPUT_DIR>
Language   : <el/en>
Name       : <WORKSPACE_NAME>
──────────────────────────────────────────
```

If `OUTPUT_DIR` already exists and contains files, list them and ask:
```
Output folder already exists with N files. Overwrite? (yes/no)
```
Stop if user answers no. Proceed immediately if yes or if directory is new/empty.

## Step 2 — Classify all content

Analyze the full source. Assign every identifiable content block to one of four categories:

| Category | Assign when the block is... | Output type |
|---|---|---|
| **A — DATABASE** | Repeated rows with shared fields; milestone/checklist items where each item has name + status + optional date; schedules with repeated date-event records | One `.csv` per distinct database concept |
| **B — REFERENCE PAGE** | Phase/topic-specific instructions, protocols, exercise descriptions, procedures that repeat the same structure per phase or category | One `.md` per distinct phase/category |
| **C — TEMPLATE FILE** | Fill-in-the-blank recurring forms (daily log, weekly entry) with one variant per phase/period | One `*_Templates.md` covering all variants |
| **D — SETUP/DASHBOARD** | Overview, navigation instructions, sharing/onboarding content | Not a separate file — feeds into SETUP guide |

Before writing any file, print a content manifest:
```
Content manifest
─────────────────────────────────────────
CSV databases   : N
  - <filename>.csv   (N rows, columns: col1, col2, ...)
Reference pages : N
  - <filename>.md    (<one-line description>)
Template file   : <filename>.md  (N variants)
Setup guide     : <SETUP_FILENAME>
Structure file  : workspace_structure.txt
─────────────────────────────────────────
Total files     : N
Writing...
```

## Step 3 — Generate content files (Category A, B, C)

Write all content files to `OUTPUT_DIR` before writing the setup guide.

### 3a — CSV files (Category A)

Rules:
- **Encoding:** UTF-8, no BOM
- **Booleans:** `TRUE` / `FALSE` (all-caps only — never Yes/No, 1/0, or lowercase)
- **Dates:** `YYYY-MM-DD`; empty date cells are empty strings, never `null` or `N/A`
- **Quoting:** Quote any field containing a comma, newline, or `"`. Escape `"` inside quoted fields as `""`
- **Column order:** Name/title first → category/phase → boolean flags → dates → free-text notes last
- **Empty trailing fields:** `,,` — never omit the comma

### 3b — Reference page MD files (Category B)

Each file structure:
```markdown
# <Topic> — <Phase or Category>

**<Phase/timeline label>:** <dates or range>
**<Goal label>:** <one-sentence goal>

---

## <Sub-section heading>

<Content — preserve all specific numbers, durations, measurements exactly from source>

---

## <Exit criteria / completion criteria heading> (if applicable)

- [ ] <criterion 1>
- [ ] <criterion 2>

---

> ⚠️ **<Warning label>:** <warning text> (include only if source contains warnings for this section)
```

Do not summarize or compress clinical, procedural, or instructional content.

### 3c — Template MD file (Category C)

One file, all template variants separated by `---`:
```markdown
## <Template label>: <Phase/Period> (<timeline>)

**<Field 1>:** ___________
**<Field 2>:** ___

### <Checklist heading>
- [ ] <item>

**<Completion label>:** ✅ / ❌
**<Notes label>:**
```

## Step 4 — Generate SETUP guide

Write `OUTPUT_DIR/<SETUP_FILENAME>` after all content files are written.

Requirements:
1. **Reference actual generated filenames** — never use placeholder names
2. **Notion import sequence** — numbered steps in the correct order (databases before pages, dashboard last)
3. **Column type table for every CSV:**

```markdown
| Column | Notion type | Options / notes |
|---|---|---|
| <col> | Title | — |
| <col> | Checkbox | — |
| <col> | Date | — |
| <col> | Select | Option A / Option B / Option C |
| <col> | Number | — |
| <col> | Text | — |
| <col> | Formula | `dateBetween(prop("Date"), parseDate("YYYY-MM-DD"), "days")` |
```

4. **Notion formula syntax** for any calculated fields identified in source (day counters, phase labels, derived dates):
   - Day from surgery: `dateBetween(prop("Ημερομηνία"), parseDate("YYYY-MM-DD"), "days")`
   - Phase from day: `if(prop("Day") < 15, "Phase 1", if(prop("Day") < 43, "Phase 2", if(...)))`

5. **Recommended views** for each database:

```markdown
| View name | View type | Filter / Group |
|---|---|---|
| <name> | Calendar | — |
| <name> | Table | Date = Today |
| <name> | Board | Group by Phase |
```

6. **Dashboard page**: what linked views to embed, 2-column layout where appropriate, mobile pinning tip
7. **Daily use section**: short numbered workflow for the end user (≤7 steps)

Setup guide skeleton:
```markdown
# <SETUP_TITLE> — <WORKSPACE_NAME>
**<FOR_LABEL>:** <person/audience from source>
**<SETUP_TIME_LABEL>:** ~<N> minutes

---

## <NEED_LABEL>

- notion.com account (free)
- Notion mobile app (iOS / Android)
- Files in this folder

---

## Step 1 — <first action>
...

## Step N — Share

...

---

## <DAILY_USE_LABEL>

1. ...
```

## Step 5 — Generate workspace_structure.txt

Plain-text Unicode box-drawing hierarchy. Every generated file must appear:
```
<WORKSPACE_NAME>
├── 🏠 <Dashboard page name>
│   ├── (linked view) <Database 1>
│   └── (linked view) <Database 2>
├── <Database 1>              ← imported from <file>.csv
│   ├── view: <view 1>
│   ├── view: <view 2>
│   └── templates: <templates-file>.md
├── <Database 2>              ← imported from <file>.csv
├── 📖 <Reference section>
│   ├── <Phase 1 page>        ← imported from <file>.md
│   └── <Phase 2 page>        ← imported from <file>.md
└── <Static page>             ← imported from <file>.md
```

## Step 6 — Final report (print only, no file)

```
Notion workspace generated
──────────────────────────────────────────────────
Output folder : <OUTPUT_DIR>
Files written : N

  <file>.csv              N rows · N columns
  <file>.md               reference page
  <file>_Templates.md     N phase templates
  <SETUP_FILENAME>        setup guide
  workspace_structure.txt

Notion import order:
  1. Create database → import <file>.csv
  2. Import page → <file>.md
  ...
  N. Build dashboard page

Next steps:
  - Follow <SETUP_FILENAME> step by step
  - Run /git-commit-push to save to git
──────────────────────────────────────────────────
```

## Error handling

| Situation | Action |
|---|---|
| `SOURCE_PATH` not found | Stop. Print the exact path that failed. Ask user to verify. |
| File is binary/image | Ask user to paste the text content directly and re-invoke. |
| No detectable structure in source | Generate a single reference MD + SETUP guide only. Print: "No structured/tabular data found — no CSV generated." |
| Output dir exists with files | List existing files. Ask "Overwrite? (yes/no)" |
| Source is a URL (starts with `http`) | Stop. Print: "This skill reads local files only. Download the file first with `curl -o local.html <url>`, then re-invoke." |
