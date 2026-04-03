---
name: changelog-update
description: Build a CHANGELOG.md entry from commits since the last git tag, following Keep a Changelog format with semantic versioning.
argument-hint: "[<tag-or-version>]"
user-invocable: true
allowed-tools: "Bash, Read, Write"
---

Generate a CHANGELOG.md entry from recent commits.

## Steps

### Step 1 — Get commit history

```bash
# Find the last tag
git describe --tags --abbrev=0 2>/dev/null || echo "no-tags"

# Commits since last tag (or all if no tags)
git log --oneline --no-merges "$(git describe --tags --abbrev=0 2>/dev/null)..HEAD" 2>/dev/null \
  || git log --oneline --no-merges -30
```

If `<tag-or-version>` is provided, use that as the base instead of the last tag.

### Step 2 — Classify commits

Map each commit to a Keep a Changelog category:

| Category | Commit prefixes |
|---|---|
| `Added` | `feat:`, new files, new endpoints |
| `Changed` | `refactor:`, `perf:`, behavior changes |
| `Fixed` | `fix:`, bug corrections |
| `Removed` | `chore:` removal, deleted endpoints |
| `Security` | any auth/permission/encryption change |
| `Deprecated` | features marked for future removal |

Ignore `docs:`, `chore: bump`, `test:` commits in the changelog body (they are implementation details).

### Step 3 — Determine next version

If the last tag was `vX.Y.Z`:
- **Major bump** (X): breaking API change, removed endpoint, auth change
- **Minor bump** (Y): new endpoint, new feature, new skill
- **Patch bump** (Z): bug fix, documentation, refactor with no API change

### Step 4 — Generate the entry

```markdown
## [X.Y.Z] — YYYY-MM-DD

### Added
- <ClassName>: new `webportalplus/<route>` endpoint for <purpose>
- New skill `/oim-vbnet` for generating VB.NET Designer scripts

### Changed
- Renamed `intragen-assistant` display name to `Person Assistant`
- Refactored Tab2 query evaluator to use async runspace pattern

### Fixed
- Fix null reference in `RemoveMembership` when entity has no groups
- Fix DPAPI decrypt failing when config.json has empty apiKey field

### Removed
- Removed deprecated `/webportalplus/legacy/endpoint`
```

### Step 5 — Update CHANGELOG.md

Read `CHANGELOG.md` if it exists. Insert the new entry at the top (below the `# Changelog` heading). If the file doesn't exist, create it with the standard header:

```markdown
# Changelog

All notable changes to this project will be documented in this file.
Format based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

<new entry here>
```

Write the updated file back.

## Rules

1. Date is always today's date in YYYY-MM-DD format
2. Never include merge commits or `chore: bump version` entries
3. Use imperative mood: "Add endpoint" not "Added endpoint" in bullet text
4. Link issue numbers if mentioned in commits: `Fix null ref (#42)`
5. Keep entries concise — one line per change, two max
