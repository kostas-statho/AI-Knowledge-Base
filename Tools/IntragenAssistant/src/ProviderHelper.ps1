# Resolves the correct provider, model, and API key for a given tab setting.
# $providerKey is an OAISettings field name: e.g. 'providerQueryEval', 'providerGoals', etc.
# Pass a literal provider string (e.g. 'openai') to override — used by Goals/Questions tab.
function Get-ProviderParams($providerKey) {
    $prov = if ($Global:OAISettings.PSObject.Properties[$providerKey]) {
        $Global:OAISettings.$providerKey
    } else {
        $providerKey   # treat as literal provider name if not a settings field
    }

    $model = switch ($prov) {
        'claude' { $Global:OAISettings.claudeModel }
        'grok'   { $Global:OAISettings.grokModel   }
        default  { $Global:OAISettings.model        }
    }

    $key = switch ($prov) {
        'claude' { $Global:AnthropicKey }
        'grok'   { $Global:GrokKey      }
        default  { $Global:ApiKey       }
    }

    return @{ Provider = $prov; Model = $model; ApiKey = $key }
}
