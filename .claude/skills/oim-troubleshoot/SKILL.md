---
name: oim-troubleshoot
description: Generate a diagnostic checklist and investigation steps from OIM issue symptoms — processes stuck, sync failures, attestation errors, plugin crashes, or performance problems.
argument-hint: "\"<symptom description>\""
user-invocable: true
allowed-tools: "Read, Glob, Grep"
---

Diagnose an OIM issue from the user's symptom description and produce a prioritized checklist of investigation steps.

## Step 1 — Classify the symptom

Map the description to one or more categories:

| Category | Symptom keywords |
|---|---|
| **Job Queue** | stuck, queued, not processing, pending, retry loop |
| **Sync / Provisioning** | not provisioning, AD not updated, sync failed, connector error |
| **Plugin / API** | 500 error, endpoint not found, null reference, plugin crash |
| **Attestation** | approval not sent, attestation stuck, decision loop |
| **IT Shop** | request not approved, workflow stuck, product not visible |
| **Performance** | slow, timeout, query taking too long, memory |
| **Config / Crypto** | key not found, decrypt error, license, config param missing |
| **Login / Auth** | cannot log in, session expired, role not inherited |

## Step 2 — Diagnostic checklists

### Job Queue — stuck / not processing

1. **Check job queue state**: OIM Manager → Job Queue → filter by Status = `Error`
2. **Read the error message**: expand the error row; copy the full stack trace
3. **Check job service**: Windows Services → One Identity Manager Job Service → running?
4. **Check machine role**: OIM Manager → Base Data → General → Machine Roles — is Job Service assigned?
5. **Check the process in Designer**: find the process by table/event; verify step order and conditions
6. **Clear a single error**: right-click → Retry (do NOT bulk-retry without reading the error first)
7. **Log file location**: `C:\Program Files\One Identity\One Identity Manager\Logs\OIM_JobService_*.log`

### Sync / Provisioning — not updating target system

1. **Check sync project**: Synchronization Editor → open project → "Last synchronization" date/time
2. **Run test connection**: Synchronization Editor → Configuration → Target System → Test Connection
3. **Check object state**: Synchronization Editor → Object Matching → find the object → state column
4. **Verify provisioning process**: Designer → Processes → filter by table → does a provisioning process exist for the event (Insert/Update)?
5. **Check Outstanding objects**: Manager → Target System → Outstanding Objects — is the object here?
6. **Log file**: `C:\Program Files\One Identity\One Identity Manager\Logs\OIM_Sync_*.log`
7. **Connector DLL version**: confirm target system connector DLL matches OIM version

### Plugin / API — endpoint errors

1. **Check plugin is deployed**: `C:\Program Files\One Identity\One Identity Manager\Server\bin\custom\` — is the DLL there?
2. **Check API Server log**: `C:\Program Files\One Identity\One Identity Manager\ApiServer\Logs\`
3. **Verify plugin registration**: OIM Manager → Base Data → API Server → Plugins — is plugin listed?
4. **Test endpoint manually**: `curl -X POST https://<server>/api/webportalplus/<route>` — what's the HTTP status?
5. **Check DLL dependencies**: all referenced DLLs must be in the plugin directory or GAC
6. **Rebuild and redeploy**: `dotnet build` → copy DLL → restart API Server
7. **Review**: run `/oim-review` on the plugin source to catch convention violations

### Attestation — stuck / not sending approvals

1. **Check attestation run**: Attestation UI → Active runs — is the run "Active" or "Error"?
2. **Read attestation log**: expand the run → Events tab → look for "Error" entries
3. **Check approver assignment**: Policy → Approval workflow → are approvers defined?
4. **Check mail server**: OIM Manager → Base Data → General → Mail → SMTP settings → Test
5. **Check mail template**: Designer → Mail Templates → find the attestation template → preview
6. **Check job queue** for `ATT_*` processes — are they processing?

### Performance — slow queries / timeouts

1. **Identify the slow operation**: note the exact action and time of day
2. **Check SQL**: run `/oim-query-evaluation` on any query extracted from the log
3. **Check for missing indexes**: OIM Manager → Base Data → Database → Schema → run Schema Update
4. **Check table row counts**: query `SELECT TOP 20 t.name, SUM(p.rows) as rows FROM sys.tables t JOIN sys.partitions p ON t.object_id=p.object_id GROUP BY t.name ORDER BY rows DESC`
5. **Check sync frequency**: is a heavy sync running during business hours? Move to off-hours.
6. **Database maintenance**: check when last REBUILD INDEX / UPDATE STATISTICS ran

### Config / Crypto — key not found / param missing

1. **Config param path**: Designer → Base Data → General → Configuration → navigate the path
2. **Check value exists**: the param must exist AND have a non-empty value
3. **Crypto key**: OIM Manager → Base Data → General → Encryption → is a valid key set?
4. **Reload config**: restart API Server / Job Service after config changes

## Step 3 — Output format

Print a prioritized checklist matching the diagnosed category:

```
## OIM Diagnostic — <symptom summary>

### Category: <Job Queue | Sync | Plugin | ...>

Priority 1 — Check first (most likely cause):
[ ] Step description

Priority 2 — Check if P1 doesn't resolve:
[ ] Step description

Log files to check:
- <path>

Relevant skills to run next:
- /oim-review — if plugin is involved
- /oim-query-evaluation — if SQL is suspect
- /oim-discover — to screenshot the relevant UI state
```

Always end with: "If none of these resolve the issue, collect the full stack trace from the log file and share it for deeper analysis."
