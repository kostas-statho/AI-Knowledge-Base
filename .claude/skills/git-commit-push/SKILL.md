---
name: git-commit-push
description: Stage, commit with a conventional commit message, and push the Knowledge_Base repo to GitHub. Use when the user wants to save and push their work.
argument-hint: "[\"commit message\"] [--files path1 path2 ...] [--all]"
user-invocable: true
allowed-tools: "Bash, Read, Glob"
---

Perform a full git commit and push workflow for the Knowledge_Base repo.

## Step 1 — Assess current state

Run these in parallel:
```bash
git -C "C:/Users/OneIM/Knowledge_Base" status --short
git -C "C:/Users/OneIM/Knowledge_Base" diff --stat HEAD
git -C "C:/Users/OneIM/Knowledge_Base" remote -v
git -C "C:/Users/OneIM/Knowledge_Base" branch --show-current
git -C "C:/Users/OneIM/Knowledge_Base" log --oneline -5
```

## Step 2 — Check remote

If `git remote -v` returns nothing:
1. Tell the user no remote is configured
2. Ask for their GitHub repo URL (e.g. `https://github.com/user/Knowledge_Base.git` or `git@github.com:user/Knowledge_Base.git`)
3. Run: `git remote add origin <url>`
4. Verify SSH key is configured if using git@ URL (see SSH key check below)

**SSH key check (for git@github.com URLs):**
```bash
ssh -T git@github.com
```
If this fails, guide the user through:
```bash
# Generate key if none exists
ssh-keygen -t ed25519 -C "your-email@example.com" -f "$HOME/.ssh/id_ed25519"
# Display public key to add to GitHub Settings → SSH keys
cat "$HOME/.ssh/id_ed25519.pub"
```
Then ask user to add it at https://github.com/settings/ssh/new and retry.

## Step 3 — Determine what to stage

**If `--all` flag or no specific files given:**
- Show the user a list of all changed/untracked files
- Ask which to include (or confirm staging all non-gitignored files)
- Never stage: `.env`, `secrets.*`, `*.zip` > 100MB, `OneIdentityManager9.3/`

**If `--files path1 path2` given:**
- Stage only those specific paths

**Stage:**
```bash
git -C "C:/Users/OneIM/Knowledge_Base" add <files>
```

## Step 4 — Generate commit message

If the user provided a message in `$ARGUMENTS`, use it as-is.

Otherwise, analyse the staged diff and generate a **conventional commit** message:

```
<type>(<scope>): <short description>

<optional body — bullet points of key changes>
```

**Types:** `feat` (new feature/file), `fix` (bug fix), `docs` (docs only), `refactor`, `chore` (tooling/config)

**Scope examples:** `plugins`, `skills`, `templates`, `docs`, `sql`, `powershell`, `mentoring`

**Rules:**
- Subject line ≤ 72 chars
- Present tense ("add" not "added")
- Body: max 5 bullets, each ≤ 80 chars
- If multiple scopes, use the dominant one or omit scope

**Show the message to the user and ask for confirmation before committing.**

## Step 5 — Commit

```bash
git -C "C:/Users/OneIM/Knowledge_Base" commit -m "$(cat <<'EOF'
<type>(<scope>): <description>

<body bullets if any>

Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>
EOF
)"
```

## Step 6 — Push

```bash
git -C "C:/Users/OneIM/Knowledge_Base" push origin <current-branch>
```

If first push to remote:
```bash
git -C "C:/Users/OneIM/Knowledge_Base" push -u origin <current-branch>
```

## Step 7 — Confirm

Run `git log --oneline -3` and show the user the result. State the GitHub URL of the pushed commit if known.

## Error handling

| Error | Fix |
|---|---|
| `Permission denied (publickey)` | SSH key not added to GitHub — run Step 2 SSH check |
| `remote: Repository not found` | Wrong URL or no access — verify URL and repo exists |
| `Updates were rejected` | Remote has commits not in local — run `git pull --rebase origin <branch>` first |
| `nothing to commit` | Working tree clean — tell user, offer to push existing commits |
