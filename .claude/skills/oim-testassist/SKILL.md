---
name: oim-testassist
description: Generate a Pester test stub or Gherkin feature file for an OIM CompositionAPI plugin endpoint or PowerShell module.
argument-hint: "<plugin-path-or-endpoint-route> [--gherkin]"
user-invocable: true
allowed-tools: "Read, Write, Glob, Grep"
---

Generate a test file for the specified OIM plugin endpoint or PowerShell module.

- Default output: **Pester test stub** (`.Tests.ps1`) — for PowerShell modules and API endpoint smoke tests
- With `--gherkin`: **Gherkin feature file** (`.feature`) — for BDD-style acceptance criteria

## Step 1 — Read the target

If `<plugin-path-or-endpoint-route>` is a file path:
- Read the `.cs` file to extract: class name, endpoint route (from `Method.Define(...)`), HTTP method, `PostedID` properties, and return shape
- Read the `.ps1` file to extract: function names, parameters, return type

If it is an endpoint route (e.g. `webportalplus/myfeature/action`):
- Search `OIM/Plugins/` with Grep for `"myfeature/action"` to find the endpoint class

## Step 2a — Generate Pester stub

```powershell
# Tests for: <ClassName> — <Route>
# Endpoint:  <HTTP Method> webportalplus/<route>
# Generated: <YYYY-MM-DD>
#Requires -Version 5.1

BeforeAll {
    # Set base URL — override via $env:OIM_API_URL
    $BaseUrl = $env:OIM_API_URL ?? "https://localhost/AppServer/api"
    $Headers = @{ "Authorization" = "Bearer $env:OIM_API_TOKEN"; "Content-Type" = "application/json" }
}

Describe "<ClassName>" {

    Context "Happy path" {
        It "returns 200 OK for a valid request" {
            $body = @{
                uid = "TEST-UID-001"   # replace with real test UID
            } | ConvertTo-Json

            $response = Invoke-RestMethod `
                -Method <HTTP_METHOD> `
                -Uri "$BaseUrl/webportalplus/<route>" `
                -Headers $Headers `
                -Body $body `
                -ErrorAction Stop

            $response | Should -Not -BeNullOrEmpty
        }
    }

    Context "Error cases" {
        It "returns 400 for missing required field" {
            $body = @{} | ConvertTo-Json  # empty body

            { Invoke-RestMethod `
                -Method <HTTP_METHOD> `
                -Uri "$BaseUrl/webportalplus/<route>" `
                -Headers $Headers `
                -Body $body } | Should -Throw
        }

        It "returns 403 or 404 for non-existent UID" {
            $body = @{ uid = "DOES-NOT-EXIST-99999" } | ConvertTo-Json

            $result = Invoke-RestMethod `
                -Method <HTTP_METHOD> `
                -Uri "$BaseUrl/webportalplus/<route>" `
                -Headers $Headers `
                -Body $body `
                -ErrorAction SilentlyContinue

            # Adjust assertion based on endpoint's error contract:
            $result | Should -BeNullOrEmpty
        }
    }
}
```

**Fill in:**
- `<ClassName>`, `<HTTP_METHOD>`, `<route>` from Step 1
- Replace `"TEST-UID-001"` with a real UID from the OIM test system
- Add one `It` block per business rule the endpoint enforces

## Step 2b — Generate Gherkin feature file (with `--gherkin`)

```gherkin
# Feature: <endpoint route>
# Plugin:  <ClassName>
# Created: <YYYY-MM-DD>

Feature: <Human-readable feature name>
  As an OIM administrator
  I want to <action>
  So that <business outcome>

  Background:
    Given I am authenticated as a user with "<required permission>" permission
    And the OIM API is reachable at the configured base URL

  Scenario: Successful <action> for a valid object
    Given a valid <object type> with UID "<test-uid>"
    When I send a <HTTP METHOD> request to "webportalplus/<route>"
    And the request body contains:
      """json
      { "uid": "<test-uid>" }
      """
    Then the response status should be 200
    And the response body should contain "<expected field>"

  Scenario: Request fails for non-existent object
    Given a UID that does not exist in OIM
    When I send a <HTTP METHOD> request to "webportalplus/<route>"
    Then the response status should be 4xx
    And the response body should describe the error

  Scenario: Request is rejected for unauthorized user
    Given I am authenticated as a user WITHOUT the required permission
    When I send a <HTTP METHOD> request to "webportalplus/<route>"
    Then the response status should be 403
```

## Output

- Pester: write to `OIM/TestAssist/<ClassName>.Tests.ps1`
- Gherkin: write to `OIM/TestAssist/<FeatureName>.feature`

State the full file path. Note which `<placeholder>` values the user must fill in before the tests can run.
