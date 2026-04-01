---
name: gdrive-sync
description: Sync the Knowledge_Base (or a subdirectory) to Google Drive using rclone with a service account JSON key. Supports local rclone or SSH to a remote rclone host.
argument-hint: "[subdirectory] [--dry-run] [--remote <rclone-remote-name>] [--ssh <user@host>]"
user-invocable: true
allowed-tools: "Bash, Read"
---

Sync Knowledge_Base content to Google Drive using rclone (via service account key) or via SSH to a remote rclone host.

## Prerequisites check (run first)

```bash
# Check local rclone
where rclone 2>NUL || echo "rclone: not found"
# Check rclone remotes configured
rclone listremotes 2>NUL
# Check SSH
where ssh
```

---

## Path A — Local rclone (preferred)

### A1 — Install rclone (if not found)

```powershell
# Download and install rclone for Windows
winget install Rclone.Rclone
# OR manual: https://rclone.org/downloads/ → Windows AMD64 zip → extract to C:\rclone\
```

After install, verify: `rclone version`

### A2 — Create Google Service Account key (one-time setup)

A **service account JSON key** is Google's equivalent of an SSH key — a credential file that grants API access without a browser login.

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a project (or use existing)
3. Enable the **Google Drive API**: APIs & Services → Library → Google Drive API → Enable
4. Create service account: IAM & Admin → Service Accounts → Create
   - Name: `knowledge-base-sync`
   - Role: not required (Drive access is granted separately)
5. Create JSON key: click the service account → Keys → Add Key → JSON → download
   - Save as: `C:\Users\OneIM\.ssh\gdrive-service-account.json`
6. Share your Google Drive target folder with the service account email (e.g. `knowledge-base-sync@your-project.iam.gserviceaccount.com`) — give it **Editor** access

### A3 — Configure rclone remote (one-time)

```bash
rclone config create gdrive drive scope drive service_account_file "C:\Users\OneIM\.ssh\gdrive-service-account.json" root_folder_id <YOUR_DRIVE_FOLDER_ID>
```

Get the folder ID from the Google Drive URL:
`https://drive.google.com/drive/folders/<FOLDER_ID_HERE>`

Verify: `rclone lsd gdrive:`

### A4 — Sync command

**Dry run first (always):**
```bash
rclone sync "C:/Users/OneIM/Knowledge_Base" gdrive:Knowledge_Base --dry-run --progress --exclude "OneIdentityManager9.3/**" --exclude "OneIdentityManager9.3.zip" --exclude ".git/**" --exclude "bin/**" --exclude "obj/**"
```

**Live sync (after confirming dry run):**
```bash
rclone sync "C:/Users/OneIM/Knowledge_Base" gdrive:Knowledge_Base --progress --exclude "OneIdentityManager9.3/**" --exclude "OneIdentityManager9.3.zip" --exclude ".git/**" --exclude "bin/**" --exclude "obj/**"
```

**Sync a subdirectory only (e.g. `Mentoring_Documentation`):**
```bash
rclone sync "C:/Users/OneIM/Knowledge_Base/Mentoring_Documentation" gdrive:Knowledge_Base/Mentoring_Documentation --progress
```

---

## Path B — Remote rclone via SSH (--ssh user@host)

Use this if rclone is installed on a Linux server and that server has Google Drive configured.

### B1 — SSH key setup (one-time)

```bash
# Generate key if none exists
ssh-keygen -t ed25519 -C "gdrive-sync" -f "$HOME/.ssh/gdrive_sync_key"
# Copy public key to remote server
ssh-copy-id -i "$HOME/.ssh/gdrive_sync_key.pub" <user@host>
# Test
ssh -i "$HOME/.ssh/gdrive_sync_key" <user@host> "rclone version"
```

### B2 — Sync via SSH

First copy files to remote, then run rclone from there:

```bash
# Step 1: rsync local → remote staging dir
rsync -avz --progress \
  -e "ssh -i $HOME/.ssh/gdrive_sync_key" \
  --exclude ".git/" --exclude "bin/" --exclude "obj/" \
  --exclude "OneIdentityManager9.3/" \
  "C:/Users/OneIM/Knowledge_Base/" \
  <user@host>:/tmp/knowledge-base-staging/

# Step 2: rclone on remote → GDrive
ssh -i "$HOME/.ssh/gdrive_sync_key" <user@host> \
  "rclone sync /tmp/knowledge-base-staging gdrive:Knowledge_Base --progress"
```

---

## Always exclude

These paths are always excluded from any GDrive sync:
- `OneIdentityManager9.3/` — 1.2 GB OIM SDK, not needed in Drive
- `OneIdentityManager9.3.zip` — same
- `.git/` — git internals
- `bin/`, `obj/` — build artifacts

## Sync summary output

After sync completes, run and show:
```bash
rclone size gdrive:Knowledge_Base
```

State: total files synced, total size, remote name, destination path.

## Troubleshooting

| Error | Fix |
|---|---|
| `Failed to create file system: didn't find section in config file` | Remote not configured — run Step A3 |
| `googleapi: Error 403: insufficientPermissions` | Service account not shared on Drive folder — re-check Step A2 step 6 |
| `connection refused` (SSH) | Wrong host/port — verify with `ssh -v` |
| `NOTICE: ... not transferring, use --ignore-times` | Add `--checksum` flag to force hash comparison |
