# generate_presentations.ps1
# Generates Intragen-styled HTML presentations for all 18 OIM Academy modules.
# Run from the Mentoring_Documentation directory.

$outDir = "$PSScriptRoot\presentations"
New-Item -ItemType Directory -Path $outDir -Force | Out-Null

# ── Module data ────────────────────────────────────────────────────────────────
$modules = @(
    @{
        code="005"; name="BAS  -  Basics"; level="Beginner"; color="#27AE60"
        prereqs=@("OIM installed and accessible","Designer access","Basic Windows navigation")
        keyConcepts=@("XOrigin bitmask (0x01 Direct, 0x02 Inherited, 0x04 Dynamic, 0x08 IT Shop)","XIsInEffect flag  -  what it means and how it is set","IT Shop basics: Product, Service Category, Service Item","Approval workflows and FallBack_Approval_Supervisor")
        exercises=@("BAS-1: Basic navigation in OIM Manager","BAS-2: Create and test a Service Category","BAS-3: IT Shop product setup","BAS-4: Request a product via IT Shop","BAS-5: Approval policy configuration","BAS-6: Investigate XOrigin on PersonInOrg","BAS-7: XIsInEffect investigation","BAS-8: FallBack_Approval_Supervisor workflow (6 test cases)")
        mentorTips=@("Trainees often confuse XOrigin bits  -  have them run a DB query to see real values","FallBack_Approval_Supervisor requires the fallback approver to exist as a Person","Approval policies are reusable  -  show how to share across products")
        commonMistakes=@("Selecting wrong approval policy level (direct vs inherited)","Not compiling the DB after config changes","Confusing XOrigin=1 (direct) with XIsInEffect=1 (currently active)")
    },
    @{
        code="006"; name="TPL  -  Templates"; level="Beginner"; color="#3498DB"
        prereqs=@("BAS module completed","Designer access","Basic VB.NET syntax")
        keyConcepts=@("Overwrite vs non-overwrite templates","Date calculation: EntryDate + 2 months","MultiValueProperty handling","Template execution order and priority")
        exercises=@("TPL-1: Create a basic column template","TPL-2: Overwrite mode vs preserve mode","TPL-3: Date calculation template (EntryDate+2 months)","TPL-4: MultiValueProperty template","TPL-5: Template chaining (BAS→BAS1→BAS2→BAS3→BAS1 uniqueness)","TPL-10: Uniqueness test across template chain")
        mentorTips=@("Non-overwrite templates only fire if the column is currently empty","Date arithmetic in VB.NET: DateAdd() is the cleanest approach","MultiValueProperty requires a specific separator  -  check the column definition")
        commonMistakes=@("Using overwrite where non-overwrite is needed (data loss)","Wrong date arithmetic (off-by-one month)","Template priority conflicts  -  two templates writing the same column")
    },
    @{
        code="007"; name="PRO  -  Processes"; level="Intermediate"; color="#E67E22"
        prereqs=@("BAS + TPL completed","Understanding of OIM event model","Basic VB.NET")
        keyConcepts=@("HandleObjectComponent-Delete event","EventName.Equals() condition syntax","IsTemporaryDeactivated generating condition: {Value = `$IsTemporaryDeactivated:Bool`$}","Process step sequencing and error handling")
        exercises=@("PRO-1: Create a basic process on Person table","PRO-2: HandleObjectComponent-Delete pattern","PRO-3: IsTemporaryDeactivated generating condition","PRO-4: EventName.Equals() step condition","PRO-5: Multi-step process with dependencies","PRO-6: Process error handling")
        mentorTips=@("The generating condition fires BEFORE the process  -  wrong condition = process never runs","HandleObjectComponent-Delete: event fires on the COMPONENT (child), not the parent","IsTemporaryDeactivated Bool condition requires exact syntax: {Value = `$IsTemporaryDeactivated:Bool`$}")
        commonMistakes=@("Writing condition on wrong table (e.g., PersonInOrg instead of Person)","Forgetting to compile after process changes","Using wrong event name  -  case-sensitive comparison")
    },
    @{
        code="008"; name="TSA  -  Target Systems"; level="Intermediate"; color="#9B59B6"
        prereqs=@("BAS + PRO completed","AD access helpful","Understanding of sync workflows")
        keyConcepts=@("Account Definitions and Manage Levels","IT Data vs Effects On","Managed vs Unmanaged accounts","Container configuration","Sync workflow direction: Target→OIM vs OIM→Target")
        exercises=@("TSA-1: Account Definition setup","TSA-2: Container configuration","TSA-3: IT Data configuration","TSA-4: Effects On settings","TSA-5: Managed account behavior","TSA-6: Unmanaged account behavior")
        mentorTips=@("Manage Level controls what OIM does when the user is created/deleted in the target","IT Data = data flowing FROM target TO OIM; Effects On = data flowing FROM OIM TO target","Always test with a single account before running full sync")
        commonMistakes=@("Wrong Manage Level causes accounts to not be provisioned","Confusing IT Data direction with Effects On direction","Missing container assignment = accounts not picked up by sync")
    },
    @{
        code="009"; name="SCN  -  Scenarios"; level="Intermediate"; color="#1ABC9C"
        prereqs=@("BAS + TSA completed","Understanding of PersonWantsOrg","IT Shop configured")
        keyConcepts=@("Joiner/Mover/Leaver automation chain","ShoppingCartItem/PersonWantsOrg extension","Request Properties customization","Process Automation triggers")
        exercises=@("SCN-1: Joiner scenario setup","SCN-2: Leaver scenario setup","SCN-3: Mover scenario (department change)","SCN-4: PersonWantsOrg extension","SCN-5: Request Properties customization","SCN-6: Automation trigger conditions")
        mentorTips=@("Joiner: triggered by new Person creation  -  check PersonInOrg.XOrigin after","Mover: column-change detection on Department/CostCenter  -  use template condition","Leaver: deactivation flow  -  check IsInActive flag chain")
        commonMistakes=@("Mover condition not detecting the right column change","Leaver process firing before deactivation is complete","PersonWantsOrg not created because IT Shop product missing")
    },
    @{
        code="010"; name="CNR  -  Connectors"; level="Advanced"; color="#E74C3C"
        prereqs=@("TSA completed","Sync Editor access","AD environment available")
        keyConcepts=@("CSV connector: file format, delimiter, column mapping","OIM connector: table mapping, key columns","5-stage sync pipeline: Read→Transform→Map→Provision→Finalize","Single Object Operations","AD bidirectional sync: AD→OIM and OIM→AD")
        exercises=@("CNR-1: CSV connector setup","CNR-2: OIM connector table mapping","CNR-3: Sync workflow configuration","CNR-4: Single Object Operations","CNR_AD-1: AD connector basic sync","CNR_AD-2: AD attribute mapping","CNR_AD-3: Bidirectional sync configuration")
        mentorTips=@("CSV connector: delimiter mismatch is the #1 failure cause  -  check encoding too","Single Object Operations allow immediate sync without waiting for scheduled full sync","AD sync: always test with a TEST OU first, not production")
        commonMistakes=@("Wrong key column selection causes duplicate records","Missing transform step = raw data written without mapping","AD sync running in wrong direction (overwriting OIM data)")
    },
    @{
        code="011"; name="WFL  -  Workflows"; level="Intermediate"; color="#F39C12"
        prereqs=@("BAS + IT Shop completed","Understanding of PersonWantsOrg","SQL Server access for custom functions")
        keyConcepts=@("Custom SQL function: dbo.CCC_IsInternalManager","Product Owner approval step","Fallback_Approvers group","AND/OR approval logic","Sequential vs parallel approval steps")
        exercises=@("WFL-1: Basic single-approver workflow","WFL-2: Product Owner approval","WFL-3: dbo.CCC_IsInternalManager SQL function","WFL-4: Fallback_Approvers with timeout","WFL-5: AND logic (all must approve)","WFL-6: OR logic (any can approve)")
        mentorTips=@("dbo.CCC_IsInternalManager must be created in SSMS before it can be used as a dynamic approver","Product Owner: the approver is resolved from the Service Item's owner at runtime","Fallback_Approvers: the group must have at least 1 member or approval hangs")
        commonMistakes=@("SQL function not created before workflow references it","Fallback group empty = approval stuck forever","AND logic: if one approver rejects, the whole request is rejected  -  often surprising")
    },
    @{
        code="012"; name="PMS  -  Permissions"; level="Intermediate"; color="#8E44AD"
        prereqs=@("BAS completed","Understanding of AERole and Permission Groups","Role model understanding")
        keyConcepts=@("Role-Based Permission Groups","View/Edit conditions on portal objects","Inheritance chain","Block inheritance pattern","XOrigin bitmask in permission context")
        exercises=@("PMS-1: Create a Permission Group","PMS-2: Assign view-only permissions","PMS-3: Assign edit permissions with conditions","PMS-4: Role inheritance setup","PMS-5: Block inheritance")
        mentorTips=@("Permission Groups apply to portal columns, not DB-level access","View condition: `$IsNull(UID_Person)=false`$  -  only show if populated","Block inheritance: use sparingly  -  it cuts off ALL parent permissions, not just specific ones")
        commonMistakes=@("Assigning permission group to wrong AERole level","View condition syntax error = column invisible to everyone","Forgetting to compile after permission changes")
    },
    @{
        code="013"; name="ATT  -  Attestations"; level="Intermediate"; color="#16A085"
        prereqs=@("BAS + WFL completed","dbo.CCC_IsInternalManager created","Understanding of attestation lifecycle")
        keyConcepts=@("Attestation policies and case generation","dbo.CCC_IsInternalManager as attestor resolver","CCC_SystemRole_Membership_Lost event","Attestation: ORDERGRANTED vs DENY outcomes","Attestation case lifecycle: Open→InProgress→Closed")
        exercises=@("ATT-1: Create attestation policy","ATT-2: Line manager as attestor (CCC_IsInternalManager)","ATT-3: Attestation for system role memberships","ATT-4: CCC_SystemRole_Membership_Lost event","ATT-5: Multi-level attestation","ATT-6: Attestation outcome processing")
        mentorTips=@("Attestation cases are generated by a scheduled task  -  run it manually for testing","CCC_IsInternalManager resolves to the Person's direct manager (IsManager=1)","CCC_SystemRole_Membership_Lost fires AFTER the attestation case closes with DENY")
        commonMistakes=@("Attestation policy not active = no cases generated","Wrong attestor condition = no one receives the attestation","ORDERGRANTED/DENY event names are case-sensitive")
    },
    @{
        code="014"; name="TRS  -  Transport"; level="Intermediate"; color="#2980B9"
        prereqs=@("Any completed module's customizations to transport","Designer access","Target system access")
        keyConcepts=@("Change Labels: grouping objects for transport","Transport packages: Manual vs Automatic","What is transportable vs non-transportable","Import log: Inserted/Updated/Skipped/Error","Connector transport caveats")
        exercises=@("TRS-1: Create a Change Label","TRS-2: Assign objects to Change Label","TRS-3: Export transport package","TRS-4: Import transport package on target system")
        mentorTips=@("Connectors are NOT transportable  -  must be recreated on target","Automatic packages include ALL changes since last transport  -  use Manual for selective transport","Always review import log after import  -  Skipped is not always an error")
        commonMistakes=@("Transporting connector objects (they break on import)","Importing in wrong environment order (DEV→PROD skipping TEST)","Not compiling target system after import")
    },
    @{
        code="015"; name="RPS  -  Reports"; level="Intermediate"; color="#27AE60"
        prereqs=@("BAS completed","SQL view creation access","IT Shop configured for subscriptions")
        keyConcepts=@("Subscribable Reports in IT Shop","SQL view → Report Definition → Report Renderer","PaperCut SMTP delivery","isManager Dynamic Role for report access","Parameterized reports with ForeignKey dropdowns")
        exercises=@("RPS-1: Create SQL view for report data","RPS-2: Create Report Definition","RPS-3: IT Shop report subscription setup")
        mentorTips=@("Report SQL views must be prefixed with v_ by convention","PaperCut SMTP: requires mail server configuration in OIM Admin Portal","isManager Dynamic Role: uses IsManager=1 flag  -  must be maintained by HR data import")
        commonMistakes=@("SQL view has column name mismatch with Report Definition columns","Subscription product not published to IT Shop","Missing @UID_Department parameter causes report to return all rows")
    },
    @{
        code="016"; name="PSC  -  PowerShell Connector"; level="Advanced"; color="#E74C3C"
        prereqs=@("SQL Server access","PowerShell 5.1+","Understanding of OIM Sync Editor","CCC_PSC database created")
        keyConcepts=@("Custom PS functions: Get/Create/Modify/Delete patterns","Authentication modes: -Integrated / -Credential SWITCH / -CredentialObject","Per-run logging: INFO/DEBUG/TRACE/ERROR levels","XML connector definition for OIM","Virtual attributes: vrt_ prefix","Single Object Operations processes")
        exercises=@("PSC-Prep: Create CCC_PSC database + 3 tables","PSC-1: Get-Users, Get-Roles, Get-UserInRole (read functions)","PSC-2: Create-User, Create-Role, Create-UserInRole (write functions)","PSC-3: Modify-User (update function)","PSC-4: Delete-User, Delete-UserInRole (delete functions)","PSC-5: XML connector definition (OIM integration)","PSC-6: UNSRootB object creation in OIM","PSC-7: Mappings + Sync workflow","PSC-8: Single Object Operations processes")
        mentorTips=@("-Credential as a SWITCH (not parameter) = popup GUI dialog on invocation","vrt_ prefix = virtual attribute  -  required by OIM for connector mappings","Single Object Operations = immediate sync per record, no waiting for scheduled full sync","Server: StathopoulosK | Database: CCC_PSC")
        commonMistakes=@("-NoExecute marks changes done without applying  -  NEVER use in PSC context","Forgetting to create UNSRootB before running mappings","FK constraint errors when deleting parent before child records")
    },
    @{
        code="017"; name="API  -  Custom APIs"; level="Advanced"; color="#C0392B"
        prereqs=@("Visual Studio 2022 + .NET Framework 4.8","OIM API Server running","Postman installed","Modules 005-008 completed")
        keyConcepts=@("Project naming: *.CompositionApi.Server.Plugin.dll (mandatory pattern)","Debug output → OIM install dir; Release output → bin/","AllowUnauthenticated() removes login requirement","Permission groups (CCC_Api01) control endpoint access","OOTB APIs at http://stathopoulosk/AppServer/api/")
        exercises=@("API-1: Hello World GET endpoint","API-2: POST endpoint with request body","API-3: Authentication required (.AllowUnauthenticated() removed)","API-4: Full CRUD for AADGroup + CCC_Api01 permission group","API-5: Filtered list + IT Shop membership creation","API-6: GET PersonWantsOrg records by group","API-7: GET all columns for AADGroup","API-8: OOTB AppServer APIs","API-9: Custom AppID (apisamples)")
        mentorTips=@("DLL naming: MUST match *.CompositionApi.Server.Plugin.dll  -  wrong name = API server ignores it","Test with 2 users: Test,A (has CCC_Api01) and Test,B (no permissions)  -  always test both","XSRF protection: disable in CCC.CompositionApi.global.json for local dev")
        commonMistakes=@("DLL in wrong folder (Debug vs Release config)","Missing XSRF header in Postman POST requests","Permission group assigned to wrong AERole level")
    },
    @{
        code="019"; name="DIM  -  Data Importer"; level="Intermediate"; color="#F39C12"
        prereqs=@("OIM Designer access","SQL Server access","Sample CSV data prepared")
        keyConcepts=@("CSV import: file structure, delimiter, text qualifier, key column","SQL import: Object Browser → SELECT → Import from Database","Handling options: Insert / Update  -  NEVER Delete","Save definition as .xml for reuse","Key column selection: can be composite (multiple columns)")
        exercises=@("DIM-1: Import identities from CSV (Insert mode)","DIM-2: Update identities from CSV (Update mode)","DIM-3: Database connection configuration","DIM-4: Advanced connection options","DIM-5: Connection variable setup")
        mentorTips=@("CRITICAL: Never select Delete in Handling Options  -  it deletes matching OIM records","Always test with 2-3 rows before importing hundreds","Save the definition XML immediately after first successful import  -  mapping takes time to rebuild")
        commonMistakes=@("Wrong key column = duplicate records instead of updates","File encoding mismatch (UTF-8 with BOM vs without)","Selecting Delete mode accidentally")
    },
    @{
        code="024_001"; name="DM  -  Deployment Manager"; level="Advanced"; color="#8E44AD"
        prereqs=@("PowerShell 7.5.4 installed","Deployment Manager extracted + DLLs unblocked","Working OIM database connection")
        keyConcepts=@("PSM Console Mode: live DB session via PowerShell","masterProjectConfig.xml vs projectConfig.xml relationship","DM deployment task types: ConfigParams, XML tasks, Templates","-o suffix = overwrite flag for templates","aftercontainer + noCompile deployment control flags","Deployment.log location and interpretation")
        exercises=@("PSM-01: Console Mode queries (Find all/single Person, update property)","PSM-02: Create .ps1 OIM automation file","PSM-03: Config parameter controlled identity deactivation","DM-01: Install PowerShell 7 + Unblock-File DLLs","DM-02: Set up Deployment folder structure","DM-04: Dry execution (confirmation prompt  -  NOT -NoExecute)","DM-05: Deploy config parameters via 100-ConfigParams_Custom.csv","DM-06: Create and execute XML task in Tasks/10-CustomObjects","DM-07: XML template + CSV data","DM-08: Push template with -o (overwrite) suffix","DM-09: ConfigParamsEnablement with aftercontainer + noCompile","DM-10: DialogScheduleDisablement","DM-11: TemplateModify task")
        mentorTips=@("CRITICAL: -NoExecute marks changes as done WITHOUT applying  -  never use for testing","DB compile after DM-09 takes minutes  -  OIM briefly inaccessible","PSM Console Mode is a live session  -  always test on dev DB first")
        commonMistakes=@("Using -NoExecute (corrupts deployment state)","Missing -o suffix = existing templates not overwritten (silent skip)","Template CSV path wrong = nothing deployed, no error")
    },
    @{
        code="024_002"; name="BA  -  Bulk Actions"; level="Advanced"; color="#2C3E50"
        prereqs=@("Node.js + npm installed","Angular CLI 18.2.14","Visual Studio Code","Git for Windows","C# API development experience (module 017)")
        keyConcepts=@("4-endpoint HTTP contract: csvtemplate → startvalidate → validate → startaction/action/endaction","DLL must be copied to BOTH OIM install dir AND ApiServer\bin","angular.json: all 'rmb' references renamed to 'bulk-actions'","npm run nx:build-all (10-20 min first run)","Permission group CCC_BulkActions + AERole")
        exercises=@("BA_01: Full environment setup (npm, Angular, Git, DLL, permissions)","BA_02: First bulk action endpoint","BA_03: Validation endpoint","BA_04: Action endpoint","BA_05: Identity import with validation (Personnel number uniqueness, mandatory LastName)","BA_07: Add entitlement bulk action (6 endpoints)","BA_08: Remove entitlement bulk action (6 endpoints)")
        mentorTips=@("DLL in only ONE location causes intermittent failures  -  copy to BOTH","angular.json rename: use VS Code Find and Replace All  -  not just Find Next","BA_05: Personnel number uniqueness is OIM-enforced, not custom code")
        commonMistakes=@("Missing DLL copy to ApiServer\bin","Partial angular.json rename (some 'rmb' left unchanged)","npm run nx:build-all interrupted  -  restart from scratch")
    },
    @{
        code="024_003"; name="DE  -  DataExplorer+"; level="Advanced"; color="#16A085"
        prereqs=@("Module 017 (APIs) completed","Module 013 (Attestations) completed","Module 016 (PSC/Schema extension) helpful","CCC_ permission group created")
        keyConcepts=@("DataExplorer+ requires: Program Function + Predefined SQL + Config Parameters","Predefined SQL names are config-driven (link to UI views by name)","DLL rebuild pattern same as module 017","CCC_DE_Recommendations table via schema extension tool","ORDERGRANTED + DENY events on AttestationCase")
        exercises=@("DE_01: Permissions setup (AERole + Config Params + Predefined SQL + Program Function)","DE_02: Predefined SQL for Line Manager Attestations","DE_03: Attestation accept/reject API endpoints","DE_04: Business Role membership management (removable vs non-removable)","DE_05: Bulk remove Business Roles button","DE_06: CCC_DE_Recommendations table + import/remove scripts via Data Importer")
        mentorTips=@("Missing ANY of the 4 setup items (AERole, Config Params, Predefined SQL, Program Function) = feature invisible","DE_06: Schema extension creates the table; Data Importer scripts are triggered by Process steps","DENY event is critical for cleanup  -  missing it = recommendations left behind after attestation")
        commonMistakes=@("Config Parameter name mismatch with Predefined SQL name","DLL not rebuilt after endpoint changes","Schema extension table missing CCC_ prefix")
    },
    @{
        code="024_004"; name="TA  -  Test Assist"; level="Advanced"; color="#8E44AD"
        prereqs=@("Deployment Manager working (module 024_001)","PowerShell 7","Pester 4.x (NOT 5.x)","VS Code with cucumberautocomplete + powershell extensions")
        keyConcepts=@("Pester 4.x: Invoke-Gherkin exists ONLY in v4 (removed in v5)","Setup.ps1 loaded on Import-Module  -  force reload after changes","Utility cmdlets: Write-ProcessTestStubs, Write-ScriptTestStubs, Write-TemplateTestStubs","Gherkin execution: .feature → regex match → .steps.ps1 → PowerShell execution","Parameter capture: regex capture groups in .steps.ps1")
        exercises=@("TA_01: Install Pester 4.x + Selenium (path fix 2.0.0→3.0.1) + NameIT","TA_02: Encrypt connection string + configure Setup.ps1","TA_03: Run self-tests (C:\Intragen\TestAssist\test)","TA_04: Generate test stubs (Process + Script + Template stubs)","TA_05: Complete a template unit test (Extended_Person_Remarks_TemplateStub)","TA_06: Complete a script unit test (TA_06_ScriptStubsFinal)","TA_07: Understand Gherkin execution flow (webtest.feature walkthrough)","TA_08: Create a Gherkin feature file + steps file","TA_09: Custom Gherkin assertion with parameters")
        mentorTips=@("Pester v4 vs v5 BREAKING: Invoke-Gherkin removed in v5  -  must have v4","Force reload: Import-Module TestAssist -Force after any Setup.ps1 change",".steps.ps1 MUST be in SAME directory as .feature  -  wrong location = no steps matched")
        commonMistakes=@("Installing Pester 5 (Install-Module Pester without -RequiredVersion 4.10.1)","Selenium path not updated (2.0.0 → 3.0.1)","Stubs left uncompleted  -  they fail until test logic is written")
    }
)

# ── Intragen CSS for presentations ───────────────────────────────────────────
$presCSS = @'
<style>
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800&display=swap');
:root {
  --purple:      #7B2D8B;
  --purple-dark: #5C1F6B;
  --teal:        #007B77;
  --golden:      #F0A800;
  --bg:          #F0EDE8;
  --white:       #FFFFFF;
  --text:        #2C2C2C;
  --muted:       #6B6B6B;
  --border:      #DDD;
}
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
body {
  font-family: 'Inter', system-ui, sans-serif;
  background: #222;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
  padding: 1rem;
}
/* ── Slide container ── */
#presentation { width: 100%; max-width: 960px; position: relative; }
.slide {
  display: none;
  width: 100%;
  aspect-ratio: 16/9;
  background: var(--white);
  border-radius: 10px;
  overflow: hidden;
  box-shadow: 0 8px 40px rgba(0,0,0,0.5);
  position: relative;
  flex-direction: column;
}
.slide.active { display: flex; }
/* ── Slide types ── */
.slide-title {
  background: linear-gradient(135deg, var(--purple-dark) 0%, var(--purple) 100%);
  color: #fff;
  align-items: flex-start;
  justify-content: flex-end;
  padding: 0 6% 7%;
}
.slide-content { padding: 5% 6%; gap: 1.2rem; }
.slide-accent  { background: var(--teal); color: #fff; padding: 5% 6%; }
.slide-light   { background: var(--bg); padding: 5% 6%; }
/* ── Title slide elements ── */
.slide-title .logo {
  position: absolute;
  top: 5%; right: 5%;
  font-size: clamp(0.7rem, 1.5vw, 1rem);
  font-weight: 700;
  letter-spacing: 3px;
  text-transform: uppercase;
  opacity: 0.7;
}
.logo-dot { color: var(--golden); }
.slide-title .circle-1 {
  position: absolute;
  width: 40%; aspect-ratio: 1;
  border-radius: 50%;
  background: rgba(255,255,255,0.06);
  top: -10%; right: -5%;
}
.slide-title .circle-2 {
  position: absolute;
  width: 30%; aspect-ratio: 1;
  border-radius: 50%;
  background: rgba(240,168,0,0.12);
  bottom: -8%; left: 40%;
}
.slide-title .module-code {
  font-size: clamp(0.65rem, 1.2vw, 0.85rem);
  font-weight: 700;
  letter-spacing: 4px;
  text-transform: uppercase;
  opacity: 0.6;
  margin-bottom: 0.75rem;
}
.slide-title h1 {
  font-size: clamp(1.4rem, 3.5vw, 2.2rem);
  font-weight: 800;
  line-height: 1.15;
  margin-bottom: 0.6rem;
}
.slide-title .subtitle {
  font-size: clamp(0.75rem, 1.5vw, 1rem);
  opacity: 0.75;
  font-weight: 300;
}
.level-badge {
  display: inline-block;
  padding: 0.2rem 0.8rem;
  border-radius: 999px;
  font-size: clamp(0.6rem, 1vw, 0.75rem);
  font-weight: 700;
  text-transform: uppercase;
  margin-top: 1rem;
}
.beginner    { background: #d4edda; color: #155724; }
.intermediate{ background: #fff3cd; color: #856404; }
.advanced    { background: #f8d7da; color: #721c24; }
/* ── Content slide elements ── */
.slide-header {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding-bottom: 0.75rem;
  border-bottom: 2px solid var(--purple);
  margin-bottom: 1rem;
  flex-shrink: 0;
}
.slide-header .dot {
  width: clamp(10px, 1.5vw, 14px);
  height: clamp(10px, 1.5vw, 14px);
  border-radius: 50%;
  background: var(--golden);
  flex-shrink: 0;
}
.slide-header h2 {
  font-size: clamp(0.9rem, 2vw, 1.3rem);
  color: var(--purple-dark);
  font-weight: 700;
}
.slide-logo {
  position: absolute;
  bottom: 3%; right: 4%;
  font-size: clamp(0.55rem, 1vw, 0.7rem);
  font-weight: 700;
  letter-spacing: 2px;
  text-transform: uppercase;
  color: var(--muted);
}
/* ── Lists ── */
ul.slide-list { list-style: none; padding: 0; display: flex; flex-direction: column; gap: 0.5rem; flex: 1; }
ul.slide-list li {
  display: flex;
  align-items: flex-start;
  gap: 0.6rem;
  font-size: clamp(0.72rem, 1.4vw, 0.92rem);
  line-height: 1.45;
  color: var(--text);
}
ul.slide-list li::before {
  content: '';
  width: 6px; height: 6px;
  border-radius: 50%;
  background: var(--teal);
  margin-top: 0.45rem;
  flex-shrink: 0;
}
/* ── Exercises grid ── */
.exercises-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 0.5rem;
  flex: 1;
}
.ex-chip {
  background: #F5EFF8;
  border: 1px solid #EDE8F0;
  border-left: 3px solid var(--teal);
  border-radius: 4px;
  padding: 0.4rem 0.6rem;
  font-size: clamp(0.62rem, 1.1vw, 0.78rem);
  color: var(--text);
}
.ex-chip .ex-id { color: var(--purple-dark); font-weight: 700; display: block; margin-bottom: 1px; }
/* ── Mistakes / tips cards ── */
.tip-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 0.75rem; flex: 1; }
.tip-card { background: #fff; border-radius: 6px; padding: 0.75rem; box-shadow: 0 1px 4px rgba(0,0,0,0.08); }
.tip-card.warn { border-left: 3px solid #F59E0B; }
.tip-card.good { border-left: 3px solid #22C55E; }
.tip-card .tip-label { font-size: 0.65rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 0.3rem; }
.tip-card.warn .tip-label { color: #D97706; }
.tip-card.good .tip-label { color: #16A34A; }
.tip-card p { font-size: clamp(0.65rem, 1.2vw, 0.82rem); line-height: 1.4; color: var(--text); }
/* ── Accent slide ── */
.slide-accent .slide-header h2 { color: #fff; }
.slide-accent .slide-header { border-bottom-color: rgba(255,255,255,0.3); }
.slide-accent ul.slide-list li { color: #fff; }
.slide-accent ul.slide-list li::before { background: var(--golden); }
.slide-accent .slide-logo { color: rgba(255,255,255,0.5); }
/* ── Nav controls ── */
#nav {
  display: flex;
  align-items: center;
  gap: 1.5rem;
  margin-top: 1.25rem;
}
#nav button {
  background: var(--purple);
  color: #fff;
  border: none;
  padding: 0.6rem 1.4rem;
  border-radius: 6px;
  cursor: pointer;
  font-family: inherit;
  font-size: 0.85rem;
  font-weight: 600;
  transition: background 0.15s;
}
#nav button:hover  { background: var(--purple-dark); }
#nav button:disabled { background: #555; cursor: default; }
#counter { color: #aaa; font-size: 0.85rem; font-family: inherit; min-width: 80px; text-align: center; }
#progress {
  width: 100%;
  max-width: 960px;
  height: 3px;
  background: #444;
  border-radius: 3px;
  margin-bottom: 0.5rem;
}
#progress-bar { height: 100%; background: var(--golden); border-radius: 3px; transition: width 0.3s; }
</style>
'@

# ── Slide builder helpers ──────────────────────────────────────────────────────
function Build-TitleSlide($m) {
    $levelClass = $m.level.ToLower()
    return @"
<div class="slide slide-title active" id="slide-1">
  <div class="logo">INTRAGEN<span class="logo-dot">.</span></div>
  <div class="circle-1"></div>
  <div class="circle-2"></div>
  <div class="module-code">Module $($m.code) &mdash; Intragen Academy</div>
  <h1>$($m.name)</h1>
  <div class="subtitle">Mentor Introduction &amp; Exercise Guide</div>
  <span class="level-badge $levelClass">$($m.level)</span>
</div>
"@
}

function Build-AgendaSlide($m) {
    $items = ($m.keyConcepts | ForEach-Object { "<li>$_</li>" }) -join "`n        "
    return @"
<div class="slide slide-content" id="slide-2">
  <div class="slide-logo">INTRAGEN<span class="logo-dot">.</span></div>
  <div class="slide-header"><div class="dot"></div><h2>What You Will Learn</h2></div>
  <ul class="slide-list">
    $items
  </ul>
</div>
"@
}

function Build-PrereqSlide($m) {
    $items = ($m.prereqs | ForEach-Object { "<li>$_</li>" }) -join "`n        "
    return @"
<div class="slide slide-light" id="slide-3">
  <div class="slide-logo">INTRAGEN<span class="logo-dot">.</span></div>
  <div class="slide-header"><div class="dot"></div><h2>Prerequisites</h2></div>
  <ul class="slide-list">
    $items
  </ul>
</div>
"@
}

function Build-ExercisesSlide($m) {
    $chips = ($m.exercises | ForEach-Object {
        $parts = $_ -split ': ', 2
        $id   = if ($parts.Count -gt 1) { $parts[0] } else { $_ }
        $desc = if ($parts.Count -gt 1) { $parts[1] } else { '' }
        "<div class='ex-chip'><span class='ex-id'>$id</span>$desc</div>"
    }) -join "`n    "
    return @"
<div class="slide slide-content" id="slide-4">
  <div class="slide-logo">INTRAGEN<span class="logo-dot">.</span></div>
  <div class="slide-header"><div class="dot"></div><h2>Exercises Overview ($($m.exercises.Count) exercises)</h2></div>
  <div class="exercises-grid">
    $chips
  </div>
</div>
"@
}

function Build-TipsSlide($m) {
    $warnCards = ($m.commonMistakes | ForEach-Object {
        "<div class='tip-card warn'><div class='tip-label'>Common Mistake</div><p>$_</p></div>"
    }) -join "`n    "
    $goodCards = ($m.mentorTips | ForEach-Object {
        "<div class='tip-card good'><div class='tip-label'>Mentor Tip</div><p>$_</p></div>"
    }) -join "`n    "
    return @"
<div class="slide slide-content" id="slide-5">
  <div class="slide-logo">INTRAGEN<span class="logo-dot">.</span></div>
  <div class="slide-header"><div class="dot"></div><h2>Mentor Tips &amp; Common Mistakes</h2></div>
  <div class="tip-grid">
    $warnCards
    $goodCards
  </div>
</div>
"@
}

function Build-ClosingSlide($m) {
    return @"
<div class="slide slide-accent" id="slide-6">
  <div class="slide-logo">INTRAGEN<span class="logo-dot">.</span></div>
  <div class="slide-header"><div class="dot"></div><h2>Ready to Begin</h2></div>
  <ul class="slide-list" style="margin-top:1rem;">
    <li>Open the Mentor Guide for detailed exercise steps and test tables</li>
    <li>Ensure all prerequisites are met before starting</li>
    <li>Run through exercises in order  -  later exercises build on earlier ones</li>
    <li>Use the troubleshooting table in the guide for common issues</li>
    <li>Questions? Refer to the Intragen Academy documentation portal</li>
  </ul>
  <div style="margin-top:auto;padding-top:1rem;font-size:0.7rem;opacity:0.6;border-top:1px solid rgba(255,255,255,0.2);">
    INTRAGEN<span class="logo-dot">.</span> Academy &mdash; &copy; Intragen International. Strictly private and confidential.
  </div>
</div>
"@
}

$navScript = @'
<script>
const slides = document.querySelectorAll('.slide');
const bar    = document.getElementById('progress-bar');
const ctr    = document.getElementById('counter');
const prev   = document.getElementById('btn-prev');
const next   = document.getElementById('btn-next');
let cur = 0;
function show(n) {
  slides[cur].classList.remove('active');
  cur = Math.max(0, Math.min(n, slides.length - 1));
  slides[cur].classList.add('active');
  bar.style.width = ((cur + 1) / slides.length * 100) + '%';
  ctr.textContent = (cur + 1) + ' / ' + slides.length;
  prev.disabled = cur === 0;
  next.disabled = cur === slides.length - 1;
}
prev.addEventListener('click', () => show(cur - 1));
next.addEventListener('click', () => show(cur + 1));
document.addEventListener('keydown', e => {
  if (e.key === 'ArrowRight' || e.key === 'ArrowDown') show(cur + 1);
  if (e.key === 'ArrowLeft'  || e.key === 'ArrowUp')   show(cur - 1);
});
show(0);
</script>
'@

# ── Generate files ─────────────────────────────────────────────────────────────
foreach ($m in $modules) {
    $fname = "module_$($m.code)_presentation.html"
    $outPath = Join-Path $outDir $fname

    $slides = @(
        (Build-TitleSlide    $m),
        (Build-AgendaSlide   $m),
        (Build-PrereqSlide   $m),
        (Build-ExercisesSlide $m),
        (Build-TipsSlide     $m),
        (Build-ClosingSlide  $m)
    )

    $allSlides = $slides -join "`n"

    $html = @"
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>$($m.name)  -  Intragen Academy Presentation</title>
$presCSS
</head>
<body>
<div id="progress"><div id="progress-bar" style="width:16.66%"></div></div>
<div id="presentation">
$allSlides
</div>
<div id="nav">
  <button id="btn-prev" disabled>&larr; Prev</button>
  <span id="counter">1 / 6</span>
  <button id="btn-next">Next &rarr;</button>
</div>
$navScript
</body>
</html>
"@

    [System.IO.File]::WriteAllText($outPath, $html, [System.Text.Encoding]::UTF8)
    Write-Host "Created: $fname" -ForegroundColor Green
}

Write-Host ""
Write-Host "Done. $($modules.Count) presentations written to: $outDir" -ForegroundColor Cyan

