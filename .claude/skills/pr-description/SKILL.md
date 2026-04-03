---
name: pr-description
description: Generate a pull request title and body from the current git diff and commit history, formatted for gh pr create.
argument-hint: "[<base-branch>]"
user-invocable: true
allowed-tools: "Bash"
---

Generate a pull request title and body from the current branch's changes.

## Steps

### Step 1 — Gather context

Run these bash commands:

```bash
# Commits in this branch vs base
git log --oneline origin/<base-branch>..HEAD 2>/dev/null || git log --oneline main..HEAD

# Files changed
git diff --name-status origin/<base-branch>..HEAD 2>/dev/null || git diff --name-status main..HEAD

# Full diff summary (stat only — don't show full diff)
git diff --stat origin/<base-branch>..HEAD 2>/dev/null || git diff --stat main..HEAD
```

If `<base-branch>` was not provided, use `main`. If `main` doesn't exist, try `master`.

### Step 2 — Classify the change type

| Commit prefix / file pattern | PR type |
|---|---|
| `feat:` or new endpoints | Feature |
| `fix:` or bug correction | Bug fix |
| `refactor:` or rename/restructure | Refactor |
| `docs:` or `*.md` only | Documentation |
| `chore:` or config/dependencies | Chore |
| `test:` or `*.Tests.ps1` / `*.feature` | Tests |

### Step 3 — Draft the PR

```markdown
## Title (under 70 chars)
<type>(<scope>): <imperative summary>

Example: feat(DataExplorer): add remove-all-memberships endpoint

## Body

## Summary
- <bullet: what changed and why>
- <bullet: second significant change>
- <bullet: third if needed — omit if not>

## Test plan
- [ ] Build succeeds: `dotnet build <solution>.sln`
- [ ] Deploy DLL to test API Server
- [ ] Manual test: [describe the action in the web portal or via curl]
- [ ] Check job queue for errors after triggering
- [ ] Verify expected DB change occurred

## Notes
<Any migration steps, config changes required, or breaking changes>

🤖 Generated with [Claude Code](https://claude.ai/claude-code)
```

### Step 4 — Print the gh command

```bash
gh pr create \
  --title "<generated title>" \
  --body "$(cat <<'EOF'
<generated body>
EOF
)"
```

## Rules

1. Title must be under 70 characters
2. Summary bullets: max 3, focus on "why" not "what" (the diff shows "what")
3. Test plan must include a build step specific to this project
4. If any `.sql` files changed, add `- [ ] Run /oim-query-evaluation on changed queries`
5. If any `.cs` files changed, add `- [ ] Run /oim-review on modified plugin files`
