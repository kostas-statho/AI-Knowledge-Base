# ----------------------------------------------
# Global application state
# $Global:ApiKey and $Global:Profile are initialized in IntragenAssistant.ps1
# ----------------------------------------------

# ── Load JSON configs ──────────────────────────
function Load-JsonConfig($path, $default) {
    if (Test-Path $path) {
        try { return Get-Content $path -Raw -Encoding UTF8 | ConvertFrom-Json }
        catch { }
    }
    return $default
}

$Global:OAISettings = Load-JsonConfig $OAISettingsPath ([PSCustomObject]@{
    model              = 'gpt-4o'
    temperature        = 0.1
    maxTokens          = 4096
    topP               = 1.0
    timeoutSeconds     = 60
    maxRulesChars      = 12000
    maxSchemaChars     = 4000
    systemPromptAppend = ''
    sqlLibraryPath     = ''
    claudeModel        = 'claude-sonnet-4-6'
    grokModel          = 'grok-4.1-fast'
    providerQueryEval  = 'openai'
    providerGoals      = 'claude'
    providerMeeting    = 'grok'
    providerPresent    = 'claude'
    providerDocBuild   = 'claude'
})

# Ensure new fields exist on loaded config (forward-compat)
$_oaiDefaults = @{
    claudeModel       = 'claude-sonnet-4-6'
    grokModel         = 'grok-4.1-fast'
    providerQueryEval = 'openai'
    providerGoals     = 'claude'
    providerMeeting   = 'grok'
    providerPresent   = 'claude'
    providerDocBuild  = 'claude'
    sqlLibraryPath    = ''
}
foreach ($k in $_oaiDefaults.Keys) {
    if (-not $Global:OAISettings.PSObject.Properties[$k]) {
        $Global:OAISettings | Add-Member -NotePropertyName $k -NotePropertyValue $_oaiDefaults[$k]
    }
}

$Global:PresentConfig = Load-JsonConfig $PresentConfigPath ([PSCustomObject]@{
    templatePath    = ''
    outputDirectory = ''
    recent          = @()
})

$Global:PresentStyle = Load-JsonConfig $PresentStylePath ([PSCustomObject]@{
    colourScheme   = 'Corporate'
    tone           = 'Professional'
    targetAudience = 'Junior Developers'
    language       = 'English'
    slideStructure = @('Title','Agenda','Content','Summary','Q&A')
    brandingNotes  = ''
})

$Global:DocStyle = Load-JsonConfig $DocStylePath ([PSCustomObject]@{
    format               = 'Markdown'
    tone                 = 'Formal'
    targetAudience       = 'OIM Developers'
    includeExamples      = $true
    includeTableOfContents = $true
    language             = 'English'
    brandingNotes        = ''
})

# ── Goals state (mirrors GoalSetter) ─────────
$Global:SwotJson      = $null
$Global:ThinkingText  = ''
$Global:McqData       = @()
$Global:GoalProposals = @()
$Global:Goals         = @()
$Global:TargetDays    = $null
$Global:HoursPerDay   = $null
