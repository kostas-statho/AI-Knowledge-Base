---
name: oim-academy-search
description: Search the 1,280-file Academy/ archive for exercises, code samples, and reference implementations matching a topic or module. Returns ranked results with file paths.
argument-hint: "<topic or keywords>"
user-invocable: true
allowed-tools: "Grep, Glob, Read"
---

Search the `Academy/` archive for relevant exercises, code samples, and reference material.

## What Academy/ contains

- 18 Academy modules (005–024) each with: `.docx` exercise files, PDFs, VB.NET scripts, CSV test data
- A VB script library (`Academy/VBScript_Library/`)
- SDK samples and SharePoint examples
- Training presentations and AI/n8n guides

**Important:** `Academy/` is READ-ONLY. Never write to it.

## Search strategy

### Step 1 — Grep for keywords in Academy/

Run up to 3 targeted searches using the user's terms:

```
Grep pattern: <user keywords, case-insensitive>
Path: Academy/
File types: .vb, .cs, .sql, .txt, .md, .ps1
```

Also Grep for synonyms and OIM-specific variants:
- "process" → also try "ProcessChain", "JobComponent"
- "attestation" → also try "ATT_", "PolicyDecision"
- "IT Shop" → also try "ITShop", "AccProduct", "PWOMethodRef"
- "bulk" → also try "BulkAction", "CCC_"

### Step 2 — Glob for module docx files

If the search terms mention a module number or topic area:

```
Glob: Academy/**/Exercise_*.docx or Academy/0NN_*/
```

List the matching module folders and note what each module covers (from the folder name).

### Step 3 — Check Reference Implementations

Always check these first for code examples:
- `Learning/Training/Reference_Implementations/BulkActions_Ref/` — bulk CSV import reference
- `Learning/Training/Reference_Implementations/DataExplorer_Ref/` — DataExplorer plugin reference
- `Learning/Training/SDK_Samples/` — 58 C# SDK samples (Sdk01–Sdk07)
- `Learning/Training/Reference_Implementations/VBNet/` — VB.NET reference scripts

### Step 4 — Return ranked results

Output a table of top 5 matches:

```
## Academy Search: "<user keywords>"

| # | File | Module | Relevance |
|---|------|--------|-----------|
| 1 | Academy/024_API/Exercises/Exercise_24_01.docx | Module 024 — API | Direct match: CompositionAPI endpoint exercise |
| 2 | Learning/Training/SDK_Samples/Sdk02_Endpoints/BasicEndpoint.cs | SDK Samples | GET endpoint example with full implementation |
| 3 | Academy/VBScript_Library/person_create.vb | VBScript Library | Person creation pattern |
| 4 | Learning/Training/Reference_Implementations/BulkActions_Ref/ | Bulk Reference | Full 4-endpoint bulk pattern |
| 5 | Academy/019_Processes/... | Module 019 | Process chain exercise |

### Top result preview
[Read and show the first 40 lines of the #1 match]
```

## Fallback

If fewer than 3 matches are found in `Academy/`, also search:
- `Learning/Mentoring/guides/` — HTML mentor guides (18 modules)
- `Docs/` — Architecture.md, Tables.md, SQL_Optimization_Rules.md

Always end with: the module number(s) most relevant to the query and the path to the matching mentor guide at `Learning/Mentoring/guides/module_NNN_guide.html`.
