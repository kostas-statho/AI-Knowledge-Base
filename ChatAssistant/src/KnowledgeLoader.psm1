#Requires -Version 5.1
# KnowledgeLoader.psm1
# Builds the system prompt from OIM Knowledge_Base sources.
# Call once at startup: $prompt = Build-SystemPrompt -BasePath "C:\Users\OneIM\Knowledge_Base"

function Strip-Html {
    param([string]$html)
    # Remove script/style blocks entirely
    $html = [regex]::Replace($html, '(?is)<(script|style)[^>]*>.*?</\1>', '')
    # Remove all remaining tags
    $html = [regex]::Replace($html, '<[^>]+>', ' ')
    # Decode common entities
    $html = $html.Replace('&lt;','<').Replace('&gt;','>').Replace('&amp;','&').Replace('&nbsp;',' ').Replace('&#39;',"'").Replace('&quot;','"')
    # Collapse whitespace
    $html = [regex]::Replace($html, '[ \t]+', ' ')
    $html = [regex]::Replace($html, '\r?\n(\s*\r?\n)+', "`n`n")
    return $html.Trim()
}

function Get-HtmlSections {
    # Extract named sections from the Intragen training HTML.
    # Returns a single string of the most relevant sections, capped at ~charLimit chars.
    param([string]$html, [int]$charLimit = 14000)

    # Target section IDs / heading text patterns that cover the key OIM concepts
    $sectionPatterns = @(
        'data-model',        # §3  Data Model
        'xorigin',           # §5  XOrigin bitmask
        'it-shop',           # §10 IT Shop
        'role-model',        # §11 Role Model
        'compliance',        # §12 Compliance/SoD
        'sod',
        'attestation',       # §13/14 Attestation
        'api-dev',           # §18-26 API Development
        'plugin',
        'bulk-action',
        'quick-ref',         # §31 Quick Reference
        'permissions'        # §15 Permissions
    )

    $result = [System.Text.StringBuilder]::new()

    foreach ($pat in $sectionPatterns) {
        # Find a <section> or <div> opening with id containing the pattern
        $rx = [regex]::new("(?is)(<(?:section|div)[^>]*id=['""](?:[^'""]*$pat[^'""]*)['""][^>]*>)(.*?)(</(?:section|div)>)", 'IgnoreCase,Singleline')
        $m = $rx.Match($html)
        if ($m.Success) {
            $text = Strip-Html ($m.Groups[2].Value)
            # Limit per section to avoid one section dominating
            if ($text.Length -gt 2500) { $text = $text.Substring(0, 2500) + '...' }
            [void]$result.AppendLine("--- $($pat.ToUpper()) ---")
            [void]$result.AppendLine($text)
            [void]$result.AppendLine()
        }
        if ($result.Length -ge $charLimit) { break }
    }

    # If we got very little (e.g. section IDs didn't match), fall back to a linear strip of the body
    if ($result.Length -lt 500) {
        $bodyMatch = [regex]::Match($html, '(?is)<body[^>]*>(.*)</body>')
        if ($bodyMatch.Success) {
            $stripped = Strip-Html $bodyMatch.Groups[1].Value
            if ($stripped.Length -gt $charLimit) { $stripped = $stripped.Substring(0, $charLimit) + '...' }
            return $stripped
        }
    }

    $text = $result.ToString()
    if ($text.Length -gt $charLimit) { $text = $text.Substring(0, $charLimit) + '...' }
    return $text
}

function Get-PluginSignatures {
    # Extract namespace + class + public method signatures from .cs files.
    param([string]$pluginsRoot)

    $sb = [System.Text.StringBuilder]::new()
    $files = Get-ChildItem -Path $pluginsRoot -Recurse -Filter '*.cs' -ErrorAction SilentlyContinue |
             Where-Object { $_.FullName -notmatch '\\(obj|bin)\\' }

    foreach ($f in $files) {
        $content = Get-Content $f.FullName -Raw -ErrorAction SilentlyContinue
        if (-not $content) { continue }

        # Namespace
        $nsMatch = [regex]::Match($content, 'namespace\s+([\w\.]+)')
        $ns = if ($nsMatch.Success) { $nsMatch.Groups[1].Value } else { '?' }

        # Class declarations
        $classMatches = [regex]::Matches($content, '(?m)^[\s]*(public\s+(?:class|interface)\s+\w+[^{]*)')
        foreach ($cm in $classMatches) {
            [void]$sb.AppendLine("[$ns] $($cm.Groups[1].Value.Trim())")
        }

        # Public method signatures (non-constructor, collapse to one line)
        $methodMatches = [regex]::Matches($content, '(?m)^\s*(public\s+(?:(?:async|static|override|virtual|new)\s+)*[\w<>\[\]]+\s+\w+\s*\([^)]*\))')
        foreach ($mm in $methodMatches) {
            $sig = [regex]::Replace($mm.Groups[1].Value.Trim(), '\s+', ' ')
            [void]$sb.AppendLine("  $sig")
        }
    }

    $result = $sb.ToString()
    if ($result.Length -gt 4000) { $result = $result.Substring(0, 4000) + '...' }
    return $result
}

function Get-SdkDocs {
    param([string]$docsPath)
    $sb = [System.Text.StringBuilder]::new()
    $mdFiles = Get-ChildItem -Path $docsPath -Filter '*.md' -ErrorAction SilentlyContinue | Sort-Object Name
    foreach ($f in $mdFiles) {
        $content = Get-Content $f.FullName -Raw -ErrorAction SilentlyContinue
        if (-not $content) { continue }
        [void]$sb.AppendLine("=== $($f.Name) ===")
        # Limit each doc file
        if ($content.Length -gt 2000) { $content = $content.Substring(0, 2000) + '...' }
        [void]$sb.AppendLine($content)
        [void]$sb.AppendLine()
    }
    $result = $sb.ToString()
    if ($result.Length -gt 8000) { $result = $result.Substring(0, 8000) + '...' }
    return $result
}

function Get-ExportToolSummary {
    param([string]$htmlPath)
    if (-not (Test-Path $htmlPath)) { return '' }
    $html = Get-Content $htmlPath -Raw -ErrorAction SilentlyContinue
    if (-not $html) { return '' }
    $text = Strip-Html $html
    if ($text.Length -gt 1500) { $text = $text.Substring(0, 1500) + '...' }
    return $text
}

function Build-SystemPrompt {
    param([string]$BasePath)

    Write-Verbose "KnowledgeLoader: loading training doc..."
    $trainingHtmlPath = Join-Path $BasePath 'OIM_93_Training_Documentation_v2_Intragen.html'
    $trainingText = ''
    if (Test-Path $trainingHtmlPath) {
        $html = Get-Content $trainingHtmlPath -Raw -ErrorAction SilentlyContinue
        if ($html) { $trainingText = Get-HtmlSections -html $html -charLimit 14000 }
    }

    Write-Verbose "KnowledgeLoader: loading SDK docs..."
    $sdkDocsPath = Join-Path $BasePath 'Training\API_SDK\docs'
    $sdkText = ''
    if (Test-Path $sdkDocsPath) { $sdkText = Get-SdkDocs -docsPath $sdkDocsPath }

    Write-Verbose "KnowledgeLoader: loading plugin signatures..."
    $pluginsPath = Join-Path $BasePath 'Plugins'
    $sigText = ''
    if (Test-Path $pluginsPath) { $sigText = Get-PluginSignatures -pluginsRoot $pluginsPath }

    Write-Verbose "KnowledgeLoader: loading export tool summary..."
    $exportDocPath = Join-Path $BasePath 'PowerShell\OIM_ExportTool\docs\OIM_Export_Tool_Developer_Docs.html'
    $exportText = Get-ExportToolSummary -htmlPath $exportDocPath

    $prompt = @"
You are an expert One Identity Manager (OIM) 9.3 developer assistant embedded in Intragen's Knowledge_Base.
Answer questions about OIM C# plugin development, PowerShell automation, data model, API patterns, and IT Shop workflows.
Be concise and code-first. Reference table/column names, interface names, and method signatures exactly as they appear in OIM.
If you are unsure, say so — do not invent table names, column names, or API methods.

Key OIM 9.3 facts to remember:
- IPlugInMethodSetProvider.Build(VI.Base.IResolve) returns IMethodSetProvider (NOT Create, NOT IExtensibilityService)
- Permission groups are assigned via Designer → Permissions Editor — there is NO .WithPermission() fluent method
- System roles live in ESet table (not ESetItUsed); hierarchy via ESetCollection; entitlements via ESetHasEntitlement
- Session.Principal.IsInRole("groupname") — NOT Session.IsInRole(...)
- ShoppingCartOrder.CheckStatus: 0=Success, 1=Error, 2=Pending
- PersonWantsOrg.OrderState values: Waiting, Assigned, Unsubscribed, Aborted, Dismissed
- AttestationPolicy uses UID_QERTermsOfUse FK (not a TermsOfUseFile column)
- XOrigin bitmask: 1=direct, 2=inherited, 4=dynamic, 8=IT Shop, 0x10=module-specific (rare)
- All DB calls use .ConfigureAwait(false); UnitOfWork pattern: StartUnitOfWork() → PutAsync/DeleteAsync → CommitAsync

=== OIM DATA MODEL & CONCEPTS ===
$trainingText

=== API SDK REFERENCE ===
$sdkText

=== LIVE PLUGIN SIGNATURES (Intragen custom plugins) ===
$sigText

=== POWERSHELL EXPORT TOOL OVERVIEW ===
$exportText
"@

    return $prompt
}

Export-ModuleMember -Function Build-SystemPrompt
