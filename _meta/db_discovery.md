# OIM Database Discovery

_Generated: 2026-03-28 21:28:38_  
_Server: `STATHOPOULOSK` | Database: `OneIM`_

---

## Summary

| Metric | Value |
|--------|-------|
| Total tables | 691 |
| Tables with rows > 0 | 322 |
| Total columns | 11,620 |
| Generated | 2026-03-28 21:28:38 |

> **Verified 2026-03-30:** 322 tables with data (was 316 on 2026-03-28 — 6 newly populated). Schema unchanged: 691 tables, 11,620 columns exact match. No schema regeneration needed.

---

## All Tables

> Tip: Use **Ctrl+F** to search for a table or column name.

### AADActivityBasedTimeoutPolicy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADActivityBasedTimeoutPol | `varchar(38)` | NO |
| UID_AADOrganization | `varchar(38)` | NO |
| Definition | `nvarchar(MAX)` | YES |
| Description | `nvarchar(MAX)` | YES |
| DisplayName | `nvarchar(255)` | YES |
| IsOrganizationDefault | `bit` | YES |
| Id | `nvarchar(36)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AADAdministrativeUnit  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADAdministrativeUnit | `varchar(38)` | NO |
| UID_AADOrganization | `varchar(38)` | NO |
| DisplayName | `nvarchar(1024)` | NO |
| Id | `nvarchar(36)` | YES |
| Description | `nvarchar(1024)` | YES |
| Visibility | `nvarchar(32)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateSubItem | `datetime` | YES |
| UID_AERoleOwner | `varchar(38)` | YES |

### AADApplication  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADApplication | `varchar(38)` | NO |
| UID_AADOrganization | `varchar(38)` | NO |
| UID_AADTokenIssuancePolicy | `varchar(38)` | YES |
| UID_AADTokenLifetimePolicy | `varchar(38)` | YES |
| AppId | `nvarchar(64)` | YES |
| CreatedDateTime | `datetime` | YES |
| DisplayName | `nvarchar(128)` | YES |
| GroupMemberShipClaims | `nvarchar(128)` | YES |
| Id | `nvarchar(36)` | YES |
| InfoLogoUrl | `nvarchar(255)` | YES |
| InfoMarketingUrl | `nvarchar(255)` | YES |
| InfoPrivacyStatementUrl | `nvarchar(255)` | YES |
| InfoServiceUrl | `nvarchar(255)` | YES |
| InfoTermsOfServiceUrl | `nvarchar(255)` | YES |
| IsFallbackPublicClient | `bit` | YES |
| PublisherDomain | `nvarchar(255)` | YES |
| SignInAudience | `nvarchar(128)` | YES |
| Tags | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateSubItem | `datetime` | YES |
| UID_AERoleOwner | `varchar(38)` | YES |

### AADApplicationOwner  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADApplicationOwner | `varchar(38)` | NO |
| ObjectKeyOwner | `varchar(138)` | NO |
| UID_AADApplication | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AADAppRole  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADAppRole | `varchar(38)` | NO |
| UID_AADServicePrincipal | `varchar(38)` | NO |
| AllowedMemberTypes | `nvarchar(MAX)` | YES |
| Description | `nvarchar(MAX)` | YES |
| DisplayName | `nvarchar(256)` | YES |
| Id | `nvarchar(128)` | YES |
| IsEnabled | `bit` | YES |
| Origin | `nvarchar(64)` | YES |
| Value | `nvarchar(255)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AADAppRoleAssignment  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADAppRoleAssignment | `varchar(38)` | NO |
| UID_AADServicePrincipal | `varchar(38)` | NO |
| ObjectKeyPrincipal | `varchar(138)` | NO |
| UID_AADAppRole | `varchar(38)` | YES |
| Id | `nvarchar(128)` | YES |
| CreationTimestamp | `datetime` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AADBaseTreeHasDeniedService  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Org | `varchar(38)` | NO |
| UID_AADDeniedServicePlan | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XIsInEffect | `bit` | YES |

### AADBaseTreeHasDirectoryRole  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADDirectoryRole | `varchar(38)` | NO |
| UID_Org | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| RiskIndexCalculated | `float` | YES |
| XIsInEffect | `bit` | YES |

### AADBaseTreeHasGroup  (8 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Org | `varchar(38)` | NO |
| UID_AADGroup | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| RiskIndexCalculated | `float` | YES |
| XIsInEffect | `bit` | YES |

### AADBaseTreeHasScopedRLAsgn  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Org | `varchar(38)` | NO |
| UID_AADScopedRLAsgn | `varchar(38)` | NO |
| RiskIndexCalculated | `float` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XIsInEffect | `bit` | YES |

### AADBaseTreeHasScopedRLElgb  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Org | `varchar(38)` | NO |
| UID_AADScopedRLElgb | `varchar(38)` | NO |
| RiskIndexCalculated | `float` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XIsInEffect | `bit` | YES |

### AADBaseTreeHasSubSku  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Org | `varchar(38)` | NO |
| UID_AADSubSku | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XIsInEffect | `bit` | YES |

### AADDeniedServicePlan  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADDeniedServicePlan | `varchar(38)` | NO |
| UID_AADSubSku | `varchar(38)` | NO |
| UID_AADServicePlan | `varchar(38)` | NO |
| MatchPatternForMembership | `bigint` | YES |
| IsForITShop | `bit` | YES |
| IsITShopOnly | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| UID_AccProduct | `varchar(38)` | YES |

### AADDirectoryRole  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADDirectoryRole | `varchar(38)` | NO |
| MatchPatternForMembership | `bigint` | YES |
| DisplayName | `nvarchar(1024)` | NO |
| Id | `varchar(36)` | YES |
| Description | `nvarchar(512)` | YES |
| RoleTemplateID | `varchar(36)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| UID_AADOrganization | `varchar(38)` | NO |
| IsForITShop | `bit` | YES |
| IsITShopOnly | `bit` | YES |
| UID_AccProduct | `varchar(38)` | YES |
| XMarkedForDeletion | `int` | YES |
| RiskIndex | `float` | YES |
| XDateSubItem | `datetime` | YES |
| UNSDisplay | `nvarchar(400)` | YES |

### AADGroup  (7 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADGroup | `varchar(38)` | NO |
| MatchPatternForMembership | `bigint` | YES |
| UID_AADOrganization | `varchar(38)` | NO |
| DisplayName | `nvarchar(1024)` | NO |
| Id | `varchar(36)` | YES |
| Description | `nvarchar(1024)` | YES |
| OnPremSid | `nvarchar(64)` | YES |
| OnPremisesSyncEnabled | `bit` | YES |
| OnPremLastSyncDateTime | `datetime` | YES |
| Mail | `nvarchar(256)` | YES |
| MailNickName | `nvarchar(256)` | NO |
| IsMailEnabled | `bit` | YES |
| IsSecurityEnabled | `bit` | YES |
| UID_AccProduct | `varchar(38)` | YES |
| IsForITShop | `bit` | YES |
| IsITShopOnly | `bit` | YES |
| UNSDisplay | `nvarchar(400)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XMarkedForDeletion | `int` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndex | `float` | YES |
| ProxyAddresses | `nvarchar(MAX)` | YES |
| XDateSubItem | `datetime` | YES |
| GroupTypes | `nvarchar(MAX)` | YES |
| IsAssignableToRole | `bit` | YES |
| MembershipRule | `nvarchar(MAX)` | YES |
| MembershipProcessingState | `nvarchar(32)` | YES |
| HasReadOnlyMemberships | `bit` | YES |
| CCC_ToBeVisibleOnApi | `nvarchar(64)` | YES |

### AADGroupClassificationLbl  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADGroupClassificationLbl | `varchar(38)` | NO |
| UID_AADOrganization | `varchar(38)` | NO |
| Label | `nvarchar(255)` | NO |
| Description | `nvarchar(512)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AADGroupCollection  (7 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADGroupContainer | `varchar(38)` | NO |
| UID_AADGroupMember | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| LevelNumber | `int` | YES |
| IsCircular | `bit` | YES |

### AADGroupExclusion  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADGroupLower | `varchar(38)` | NO |
| UID_AADGroupHigher | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XMarkedForDeletion | `int` | YES |
| XObjectKey | `varchar(138)` | NO |

### AADGroupHasDeniedService  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADDeniedServicePlan | `varchar(38)` | NO |
| UID_AADGroup | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XIsInEffect | `bit` | YES |

### AADGroupHasSubSku  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADSubSku | `varchar(38)` | NO |
| UID_AADGroup | `varchar(38)` | NO |
| DenyList | `varchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XIsInEffect | `bit` | YES |

### AADGroupInAdministrativeUnit  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADGroup | `varchar(38)` | NO |
| UID_AADAdministrativeUnit | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AADGroupInDirectoryRole  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADGroup | `varchar(38)` | NO |
| UID_AADDirectoryRole | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AADGroupInGroup  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADGroupMember | `varchar(38)` | NO |
| UID_AADGroupContainer | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AADGroupInScopedRLAsgn  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADGroup | `varchar(38)` | NO |
| UID_AADScopedRLAsgn | `varchar(38)` | NO |
| ValidFrom | `datetime` | YES |
| ValidTo | `datetime` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AADGroupInScopedRLElgb  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADGroup | `varchar(38)` | NO |
| UID_AADScopedRLElgb | `varchar(38)` | NO |
| ValidFrom | `datetime` | YES |
| ValidTo | `datetime` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AADGroupOwner  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADGroupOwner | `varchar(38)` | NO |
| ObjectKeyOwner | `varchar(138)` | NO |
| UID_AADGroup | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AADHomeRealmDiscoveryPolicy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADHomeRealmDiscoveryPol | `varchar(38)` | NO |
| UID_AADOrganization | `varchar(38)` | NO |
| Definition | `nvarchar(MAX)` | YES |
| Description | `nvarchar(MAX)` | YES |
| DisplayName | `nvarchar(255)` | YES |
| IsOrganizationDefault | `bit` | YES |
| Id | `nvarchar(36)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AADOrganization  (1 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADOrganization | `varchar(38)` | NO |
| MatchPatternDisplay | `nvarchar(MAX)` | YES |
| NamespaceManagedBy | `nvarchar(64)` | YES |
| SecurityNotificationPhones | `nvarchar(MAX)` | YES |
| Country | `nvarchar(64)` | YES |
| DisplayName | `nvarchar(1024)` | NO |
| UID_DialogCountry | `varchar(38)` | YES |
| Id | `varchar(36)` | YES |
| State | `nvarchar(256)` | YES |
| City | `nvarchar(256)` | YES |
| PostalCode | `nvarchar(64)` | YES |
| Street | `nvarchar(256)` | YES |
| OnPremisesSyncEnabled | `bit` | YES |
| SecurityNotificationMails | `nvarchar(MAX)` | YES |
| MarketingNotificationMails | `nvarchar(MAX)` | YES |
| TechnicalNotificationMails | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| UID_TSBAccountDefUser | `varchar(38)` | YES |
| UID_AERoleOwner | `varchar(38)` | YES |
| AccountToPersonMatchingRule | `nvarchar(MAX)` | YES |
| OnPremLastSyncDateTime | `datetime` | YES |
| XMarkedForDeletion | `int` | YES |
| TenantType | `nvarchar(128)` | YES |
| RoleBehavior | `nvarchar(16)` | YES |
| SyncTags | `nvarchar(MAX)` | YES |
| UID_AERoleExchangeAdmin | `varchar(38)` | YES |
| UID_TSBAccountDefMailContact | `varchar(38)` | YES |
| UID_TSBAccountDefMailUser | `varchar(38)` | YES |
| UID_O3EDLHABRoot | `varchar(38)` | YES |

### AADPrincipalInScopedRLAsgn  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADServicePrincipal | `varchar(38)` | NO |
| UID_AADScopedRLAsgn | `varchar(38)` | NO |
| ValidFrom | `datetime` | YES |
| ValidTo | `datetime` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AADPrincipalInScopedRLElgb  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADServicePrincipal | `varchar(38)` | NO |
| UID_AADScopedRLElgb | `varchar(38)` | NO |
| ValidFrom | `datetime` | YES |
| ValidTo | `datetime` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AADRole  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADRole | `varchar(38)` | NO |
| UID_AADOrganization | `varchar(38)` | NO |
| Provider | `nvarchar(128)` | YES |
| Id | `varchar(36)` | YES |
| DisplayName | `nvarchar(1024)` | NO |
| Description | `nvarchar(512)` | YES |
| IsEnabled | `bit` | YES |
| IsBuiltin | `bit` | YES |
| Version | `nvarchar(128)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| UID_AERoleOwner | `varchar(38)` | YES |

### AADRoleAssignment  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADRoleAssignment | `varchar(38)` | NO |
| UID_AADRole | `varchar(38)` | NO |
| Id | `nvarchar(128)` | YES |
| AppScopeId | `nvarchar(128)` | YES |
| ObjectKeyAppScope | `varchar(138)` | YES |
| DirectoryScopeId | `nvarchar(128)` | YES |
| ObjectKeyDirectoryScope | `varchar(138)` | YES |
| ObjectKeyPrincipal | `varchar(138)` | YES |
| StartDateTime | `datetime` | YES |
| ExpirationType | `nvarchar(128)` | YES |
| ExpirationDuration | `int` | YES |
| ExpirationEndDateTime | `datetime` | YES |
| Source | `nvarchar(32)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| Origination | `int` | YES |
| ValidFromInternal | `datetime` | YES |
| ValidToInternal | `datetime` | YES |
| UID_PWOOrigin | `varchar(38)` | YES |

### AADRoleEligibility  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADRoleEligibility | `varchar(38)` | NO |
| UID_AADRole | `varchar(38)` | NO |
| Id | `nvarchar(128)` | YES |
| AppScopeId | `nvarchar(128)` | YES |
| ObjectKeyAppScope | `varchar(138)` | YES |
| DirectoryScopeId | `nvarchar(128)` | YES |
| ObjectKeyDirectoryScope | `varchar(138)` | YES |
| ObjectKeyPrincipal | `varchar(138)` | YES |
| StartDateTime | `datetime` | YES |
| ExpirationType | `nvarchar(128)` | YES |
| ExpirationDuration | `int` | YES |
| ExpirationEndDateTime | `datetime` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| Origination | `int` | YES |
| ValidFromInternal | `datetime` | YES |
| ValidToInternal | `datetime` | YES |
| UID_PWOOrigin | `varchar(38)` | YES |

### AADRoleManagementPolicy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADRoleManagementPolicy | `varchar(38)` | NO |
| UID_AADOrganization | `varchar(38)` | NO |
| UID_AADRole | `varchar(38)` | NO |
| ApUsrAsg_ApprovalMode | `nvarchar(64)` | YES |
| ApUsrAsg_ApprovalStages | `bigint` | YES |
| ApUsrAsg_IsApprovalRequired | `bit` | YES |
| ApUsrAsg_IsApvJustifReq | `bit` | YES |
| ApUsrAsg_IsReqJustifReq | `bit` | YES |
| ApUsrAsg_RecipientType | `nvarchar(64)` | YES |
| AuthCtxUsrAsg_ClaimValue | `nvarchar(1024)` | YES |
| AuthCtxUsrAsg_IsEnabled | `bit` | YES |
| EnableAdmAssignment_Rules | `nvarchar(MAX)` | YES |
| EnableAdmEligibility_Rules | `nvarchar(MAX)` | YES |
| EnableUsrAssignment_Rules | `nvarchar(MAX)` | YES |
| ExpAdmAsg_IsExpirationRequired | `bit` | YES |
| ExpAdmAsg_MaximumDuration | `bigint` | YES |
| ExpAdmElg_IsExpirationRequired | `bit` | YES |
| ExpAdmElg_MaximumDuration | `bigint` | YES |
| ExpUsrAsg_IsExpirationRequired | `bit` | YES |
| ExpUsrAsg_MaximumDuration | `bigint` | YES |
| Id | `nvarchar(256)` | NO |
| NtAdmAdmAsg_IsDefRcptsEnabled | `bit` | YES |
| NtAdmAdmAsg_NotificationLevel | `nvarchar(64)` | YES |
| NtAdmAdmAsg_NtfyRcpts | `nvarchar(MAX)` | YES |
| NtAdmAdmAsg_NotificationType | `nvarchar(64)` | YES |
| NtAdmAdmAsg_RecipientType | `nvarchar(64)` | YES |
| NtAdmAdmElg_IsDefRcptsEnabled | `bit` | YES |
| NtAdmAdmElg_NotificationLevel | `nvarchar(64)` | YES |
| NtAdmAdmElg_NtfyRcpts | `nvarchar(MAX)` | YES |
| NtAdmAdmElg_NotificationType | `nvarchar(64)` | YES |
| NtAdmAdmElg_RecipientType | `nvarchar(64)` | YES |
| NtAdmUsrElg_IsDefRcptsEnabled | `bit` | YES |
| NtAdmUsrElg_NotificationLevel | `nvarchar(64)` | YES |
| NtAdmUsrElg_NtfyRcpts | `nvarchar(MAX)` | YES |
| NtAdmUsrElg_NotificationType | `nvarchar(64)` | YES |
| NtAdmUsrElg_RecipientType | `nvarchar(64)` | YES |
| NtApvAdmAsg_IsDefRcptsEnabled | `bit` | YES |
| NtApvAdmAsg_NotificationLevel | `nvarchar(64)` | YES |
| NtApvAdmAsg_NtfyRcpts | `nvarchar(MAX)` | YES |
| NtApvAdmAsg_NotificationType | `nvarchar(64)` | YES |
| NtApvAdmAsg_RecipientType | `nvarchar(64)` | YES |
| NtApvAdmElg_IsDefRcptsEnabled | `bit` | YES |
| NtApvAdmElg_NotificationLevel | `nvarchar(64)` | YES |
| NtApvAdmElg_NtfyRcpts | `nvarchar(MAX)` | YES |
| NtApvAdmElg_NotificationType | `nvarchar(64)` | YES |
| NtApvAdmElg_RecipientType | `nvarchar(64)` | YES |
| NtApvUsrAsg_IsDefRcptsEnabled | `bit` | YES |
| NtApvUsrAsg_NotificationLevel | `nvarchar(64)` | YES |
| NtApvUsrAsg_NtfyRcpts | `nvarchar(MAX)` | YES |
| NtApvUsrAsg_NotificationType | `nvarchar(64)` | YES |
| NtApvUsrAsg_RecipientType | `nvarchar(64)` | YES |
| NtReqAdmAsg_IsDefRcptsEnabled | `bit` | YES |
| NtReqAdmAsg_NotificationLevel | `nvarchar(64)` | YES |
| NtReqAdmAsg_NtfyRcpts | `nvarchar(MAX)` | YES |
| NtReqAdmAsg_NotificationType | `nvarchar(64)` | YES |
| NtReqAdmAsg_RecipientType | `nvarchar(64)` | YES |
| NtReqAdmElg_IsDefRcptsEnabled | `bit` | YES |
| NtReqAdmElg_NotificationLevel | `nvarchar(64)` | YES |
| NtReqAdmElg_NtfyRcpts | `nvarchar(MAX)` | YES |
| NtReqAdmElg_NotificationType | `nvarchar(64)` | YES |
| NtReqAdmElg_RecipientType | `nvarchar(64)` | YES |
| NtReqUsrAsg_IsDefRcptsEnabled | `bit` | YES |
| NtReqUsrAsg_NotificationLevel | `nvarchar(64)` | YES |
| NtReqUsrAsg_NtfyRcpts | `nvarchar(MAX)` | YES |
| NtReqUsrAsg_NotificationType | `nvarchar(64)` | YES |
| NtReqUsrAsg_RecipientType | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AADScopedRLAsgn  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADScopedRLAsgn | `varchar(38)` | NO |
| UID_AADRole | `varchar(38)` | NO |
| UID_AADOrganization | `varchar(38)` | NO |
| ObjectKeyAppScope | `varchar(138)` | YES |
| ObjectKeyDirectoryScope | `varchar(138)` | YES |
| UNSDisplay | `nvarchar(400)` | YES |
| RiskIndex | `float` | YES |
| MatchPatternForMembership | `bigint` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| IsScopeAllowed | `bit` | YES |

### AADScopedRLElgb  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADScopedRLElgb | `varchar(38)` | NO |
| UID_AADRole | `varchar(38)` | NO |
| UID_AADOrganization | `varchar(38)` | NO |
| ObjectKeyAppScope | `varchar(138)` | YES |
| ObjectKeyDirectoryScope | `varchar(138)` | YES |
| UNSDisplay | `nvarchar(400)` | YES |
| RiskIndex | `float` | YES |
| MatchPatternForMembership | `bigint` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| IsScopeAllowed | `bit` | YES |

### AADSecAttrDef  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADSecAttrDef | `varchar(38)` | NO |
| UID_AADSecAttrSet | `varchar(38)` | NO |
| Name | `nvarchar(32)` | NO |
| Id | `nvarchar(128)` | NO |
| Description | `nvarchar(128)` | YES |
| IsCollection | `bit` | NO |
| IsSearchable | `bit` | NO |
| UsePreDefinedValuesOnly | `bit` | NO |
| Type | `nvarchar(64)` | NO |
| ActivePredefinedValues | `nvarchar(MAX)` | YES |
| Status | `nvarchar(32)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AADSecAttrSet  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADSecAttrSet | `varchar(38)` | NO |
| UID_AADOrganization | `varchar(38)` | NO |
| Id | `nvarchar(32)` | NO |
| Description | `nvarchar(128)` | YES |
| MaxAttributesPerSet | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AADSecAttrSvcPInstance  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADSecAttrSvcPInstance | `varchar(38)` | NO |
| UID_AADServicePrincipal | `varchar(38)` | NO |
| UID_AADSecAttrDef | `varchar(38)` | NO |
| AttrValue | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AADSecAttrUsrInstance  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADSecAttrUsrInstance | `varchar(38)` | NO |
| UID_AADUser | `varchar(38)` | NO |
| UID_AADSecAttrDef | `varchar(38)` | NO |
| AttrValue | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AADServicePlan  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADServicePlan | `varchar(38)` | NO |
| ServicePlanId | `varchar(36)` | YES |
| ServiceName | `nvarchar(256)` | YES |
| UID_AADOrganization | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AADServicePlanInSubSku  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADSubSku | `varchar(38)` | NO |
| UID_AADServicePlan | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AADServicePrincipal  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADServicePrincipal | `varchar(38)` | NO |
| UID_AADOrganization | `varchar(38)` | NO |
| UID_AADHomeRealmDiscoveryPol | `varchar(38)` | YES |
| AccountEnabled | `bit` | YES |
| AlternativeNames | `nvarchar(MAX)` | YES |
| AppDisplayName | `nvarchar(255)` | YES |
| AppId | `nvarchar(64)` | YES |
| ApplicationTemplateId | `nvarchar(64)` | YES |
| AppOwnerOrganizationId | `nvarchar(64)` | YES |
| AppRoleAssignmentRequired | `bit` | YES |
| DeletedDateTime | `datetime` | YES |
| DisplayName | `nvarchar(255)` | YES |
| Homepage | `nvarchar(255)` | YES |
| Id | `nvarchar(36)` | YES |
| InfoLogoUrl | `nvarchar(255)` | YES |
| InfoMarketingUrl | `nvarchar(255)` | YES |
| InfoPrivacyStatementUrl | `nvarchar(255)` | YES |
| InfoServiceUrl | `nvarchar(255)` | YES |
| InfoTermsOfServiceUrl | `nvarchar(255)` | YES |
| LoginUrl | `nvarchar(255)` | YES |
| LogoutUrl | `nvarchar(255)` | YES |
| NotificationEmailAddresses | `nvarchar(MAX)` | YES |
| PreferredSingleSignOnMode | `nvarchar(32)` | YES |
| ReplyUrls | `nvarchar(MAX)` | YES |
| ServicePrincipalNames | `nvarchar(MAX)` | YES |
| ServicePrincipalType | `nvarchar(64)` | YES |
| Tags | `nvarchar(MAX)` | YES |
| TokenEncryptionKeyId | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateSubItem | `datetime` | YES |
| UID_AERoleOwner | `varchar(38)` | YES |

### AADServicePrincipalOwner  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADServicePrincipalOwner | `varchar(38)` | NO |
| ObjectKeyOwner | `varchar(138)` | NO |
| UID_AADServicePrincipal | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AADSubSku  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADSubSku | `varchar(38)` | NO |
| Id | `nvarchar(128)` | YES |
| CapabilityStatus | `nvarchar(512)` | YES |
| ConsumedUnits | `int` | YES |
| SkuId | `varchar(36)` | YES |
| SkuPartNumber | `nvarchar(256)` | YES |
| UID_AADOrganization | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| EnabledUnits | `int` | YES |
| SuspendedUnits | `int` | YES |
| WarningUnits | `int` | YES |
| MatchPatternForMembership | `bigint` | YES |
| IsForITShop | `bit` | YES |
| IsITShopOnly | `bit` | YES |
| RiskIndex | `float` | YES |
| UID_AccProduct | `varchar(38)` | YES |
| UNSDisplay | `nvarchar(400)` | YES |

### AADTokenIssuancePolicy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADTokenIssuancePolicy | `varchar(38)` | NO |
| UID_AADOrganization | `varchar(38)` | NO |
| Definition | `nvarchar(MAX)` | YES |
| Description | `nvarchar(MAX)` | YES |
| DisplayName | `nvarchar(255)` | YES |
| IsOrganizationDefault | `bit` | YES |
| Id | `nvarchar(36)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AADTokenLifetimePolicy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADTokenLifetimePolicy | `varchar(38)` | NO |
| UID_AADOrganization | `varchar(38)` | NO |
| Definition | `nvarchar(MAX)` | YES |
| Description | `nvarchar(MAX)` | YES |
| DisplayName | `nvarchar(255)` | YES |
| IsOrganizationDefault | `bit` | YES |
| Id | `nvarchar(36)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AADUser  (5 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADUser | `varchar(38)` | NO |
| LastPasswordChangeDateTime | `datetime` | YES |
| PasswordPolicies | `nvarchar(1024)` | YES |
| IsGroupAccount | `bit` | YES |
| MatchPatternForMembership | `bigint` | YES |
| UID_AADOrganization | `varchar(38)` | NO |
| UID_Person | `varchar(38)` | YES |
| UID_TSBAccountDef | `varchar(38)` | YES |
| Id | `varchar(36)` | YES |
| UID_TSBBehavior | `varchar(38)` | YES |
| ProxyAddresses | `nvarchar(MAX)` | YES |
| ObjectKeyManager | `varchar(138)` | YES |
| GivenName | `nvarchar(256)` | YES |
| Surname | `nvarchar(256)` | YES |
| DisplayName | `nvarchar(1024)` | YES |
| AccountDisabled | `bit` | YES |
| City | `nvarchar(256)` | YES |
| CompanyName | `nvarchar(256)` | YES |
| Country | `nvarchar(256)` | YES |
| OnPremisesSyncEnabled | `bit` | YES |
| Department | `nvarchar(256)` | YES |
| OnPremImmutableId | `nvarchar(64)` | YES |
| JobTitle | `nvarchar(256)` | YES |
| Mail | `nvarchar(256)` | YES |
| OnPremLastSyncDateTime | `datetime` | YES |
| MailNickName | `char(256)` | NO |
| Mobile | `nvarchar(256)` | YES |
| PostalCode | `nvarchar(64)` | YES |
| PreferredLanguage | `nvarchar(64)` | YES |
| State | `nvarchar(128)` | YES |
| StreetAddress | `nvarchar(256)` | YES |
| OnPremSid | `nvarchar(64)` | YES |
| ThumbnailPhoto | `varbinary` | YES |
| UID_DialogCountryUsage | `varchar(38)` | YES |
| UserPrincipalName | `nvarchar(400)` | YES |
| UserType | `nvarchar(64)` | YES |
| Password | `varchar(990)` | YES |
| ForceChangePassword | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| OfficeLocation | `nvarchar(256)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| UNSDisplay | `nvarchar(400)` | NO |
| RiskIndexCalculated | `float` | YES |
| UID_AADVerifiedDomain | `varchar(38)` | YES |
| BusinessPhones | `nvarchar(MAX)` | YES |
| IsPrivilegedAccount | `bit` | YES |
| IdentityType | `varchar(32)` | YES |
| AgeGroup | `nvarchar(32)` | YES |
| BirthDay | `datetime` | YES |
| ConsentProvidedForMinor | `nvarchar(32)` | YES |
| LegalAgeGroupClassification | `nvarchar(64)` | YES |
| OnPremisesDistinguishedName | `nvarchar(1000)` | YES |
| OnPremisesDomainName | `nvarchar(255)` | YES |
| OnPremisesExtensionAttribute1 | `nvarchar(MAX)` | YES |
| OnPremisesExtensionAttribute2 | `nvarchar(MAX)` | YES |
| OnPremisesExtensionAttribute3 | `nvarchar(MAX)` | YES |
| OnPremisesExtensionAttribute4 | `nvarchar(MAX)` | YES |
| OnPremisesExtensionAttribute5 | `nvarchar(MAX)` | YES |
| OnPremisesExtensionAttribute6 | `nvarchar(MAX)` | YES |
| OnPremisesExtensionAttribute7 | `nvarchar(MAX)` | YES |
| OnPremisesExtensionAttribute8 | `nvarchar(MAX)` | YES |
| OnPremisesExtensionAttribute9 | `nvarchar(MAX)` | YES |
| OnPremisesExtensionAttribute10 | `nvarchar(MAX)` | YES |
| OnPremisesExtensionAttribute11 | `nvarchar(MAX)` | YES |
| OnPremisesExtensionAttribute12 | `nvarchar(MAX)` | YES |
| OnPremisesExtensionAttribute13 | `nvarchar(MAX)` | YES |
| OnPremisesExtensionAttribute14 | `nvarchar(MAX)` | YES |
| OnPremisesExtensionAttribute15 | `nvarchar(MAX)` | YES |
| OnPremisesSAMAccountName | `nvarchar(20)` | YES |
| OnPremisesUserPrincipalName | `nvarchar(400)` | YES |
| IsResourceAccount | `bit` | YES |
| PreferredName | `nvarchar(128)` | YES |
| Responsibilities | `nvarchar(MAX)` | YES |
| Schools | `nvarchar(MAX)` | YES |
| Skills | `nvarchar(MAX)` | YES |
| PastProjects | `nvarchar(MAX)` | YES |
| Interests | `nvarchar(MAX)` | YES |
| HireDate | `datetime` | YES |
| EmployeeID | `nvarchar(128)` | YES |
| AboutMe | `nvarchar(MAX)` | YES |
| MySite | `nvarchar(MAX)` | YES |
| ImAddresses | `nvarchar(MAX)` | YES |
| FaxNumber | `nvarchar(64)` | YES |
| OtherMails | `nvarchar(MAX)` | YES |
| IsGroupAccount_DeniedService | `bit` | YES |
| IsGroupAccount_SubSku | `bit` | YES |
| IsGroupAccount_DirectoryRole | `bit` | YES |
| IsGroupAccount_Group | `bit` | YES |
| ExternalUserState | `nvarchar(255)` | YES |
| ExternalUserStateChangeDate | `datetime` | YES |
| NeverConnectToPerson | `int` | YES |
| IsNeverConnectManual | `bit` | YES |
| CreationType | `nvarchar(64)` | YES |
| Identities | `nvarchar(MAX)` | YES |
| EmployeeHireDate | `datetime` | YES |
| EmployeeLeaveDateTime | `datetime` | YES |
| EmployeeType | `nvarchar(128)` | YES |
| EodDivision | `nvarchar(128)` | YES |
| EodCostCenter | `nvarchar(128)` | YES |
| siaLastNISignInDateTime | `datetime` | YES |
| siaLastNISignInRequestId | `nvarchar(64)` | YES |
| siaLastSignInDateTime | `datetime` | YES |
| siaLastSignInRequestId | `nvarchar(64)` | YES |
| XDateSubItem | `datetime` | YES |
| IsGroupAccount_UnifiedGroup | `bit` | YES |

### AADUserHasDeniedService  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADDeniedServicePlan | `varchar(38)` | NO |
| UID_AADUser | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XIsInEffect | `bit` | YES |

### AADUserHasServicePlan  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADUser | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| UID_AADServicePlan | `varchar(38)` | NO |
| RiskIndexCalculated | `float` | YES |

### AADUserHasSubSku  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADUserHasSubSku | `varchar(38)` | NO |
| UID_AADUser | `varchar(38)` | NO |
| ObjectKeyAADSubSku | `varchar(138)` | NO |
| DenyList | `varchar(MAX)` | YES |
| UID_AADGroupSource | `varchar(38)` | YES |
| State | `nvarchar(64)` | YES |
| ErrorType | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XIsInEffect | `bit` | YES |

### AADUserHasSubSkuCompressed  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADUser | `varchar(38)` | NO |
| UID_AADSubSku | `varchar(38)` | NO |
| InheritInfo | `int` | YES |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |

### AADUserIdentity  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADUserIdentity | `varchar(38)` | NO |
| UID_AADUser | `varchar(38)` | NO |
| SignInType | `varchar(512)` | NO |
| Issuer | `varchar(512)` | NO |
| IssuerAssignedId | `nvarchar(100)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |

### AADUserInAdministrativeUnit  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADUser | `varchar(38)` | NO |
| UID_AADAdministrativeUnit | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AADUserInDirectoryRole  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADUser | `varchar(38)` | NO |
| UID_AADDirectoryRole | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XOrigin | `int` | YES |
| XIsInEffect | `bit` | YES |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |

### AADUserInGroup  (2 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADGroup | `varchar(38)` | NO |
| UID_AADUser | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XIsInEffect | `bit` | YES |
| RiskIndexCalculated | `float` | YES |

### AADUserInScopedRLAsgn  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADUser | `varchar(38)` | NO |
| UID_AADScopedRLAsgn | `varchar(38)` | NO |
| RiskIndexCalculated | `float` | YES |
| ValidFrom | `datetime` | YES |
| ValidTo | `datetime` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XOrigin | `int` | YES |
| XIsInEffect | `bit` | YES |
| XMarkedForDeletion | `int` | YES |

### AADUserInScopedRLElgb  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADUser | `varchar(38)` | NO |
| UID_AADScopedRLElgb | `varchar(38)` | NO |
| RiskIndexCalculated | `float` | YES |
| ValidFrom | `datetime` | YES |
| ValidTo | `datetime` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XOrigin | `int` | YES |
| XIsInEffect | `bit` | YES |
| XMarkedForDeletion | `int` | YES |

### AADUserSponsor  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADUserSponsor | `varchar(38)` | NO |
| UID_AADUser | `varchar(38)` | NO |
| ObjectKeySponsor | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AADUserTemporaryAccessPass  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADUserTemporaryAccessPass | `varchar(38)` | NO |
| UID_AADUser | `varchar(38)` | NO |
| Id | `nvarchar(38)` | YES |
| IsUsable | `bit` | YES |
| IsUsableOnce | `bit` | YES |
| LifetimeInMinutes | `int` | YES |
| StartDateTime | `datetime` | YES |
| MethodUsabilityReason | `nvarchar(64)` | YES |
| TemporaryAccessPass | `varchar(990)` | YES |
| CreatedDateTime | `datetime` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AADVerifiedDomain  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADVerifiedDomain | `varchar(38)` | NO |
| IsDefault | `bit` | YES |
| UID_AADOrganization | `varchar(38)` | NO |
| DomainName | `nvarchar(1024)` | NO |
| IsInitial | `bit` | YES |
| DomainType | `nvarchar(256)` | YES |
| Capabilities | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AccountNames  (3 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AccountName | `varchar(38)` | NO |
| Ident_account | `nvarchar(64)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AccProduct  (104 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AccProduct | `varchar(38)` | NO |
| UID_AccProductParamCategory | `varchar(38)` | YES |
| UID_FunctionalArea | `varchar(38)` | YES |
| UID_PWODecisionMethod | `varchar(38)` | YES |
| UID_OrgRuler | `varchar(38)` | YES |
| UID_ProfitCenter | `varchar(38)` | YES |
| UID_AccProductGroup | `varchar(38)` | YES |
| Ident_AccProduct | `nvarchar(256)` | YES |
| Description | `nvarchar(MAX)` | YES |
| ModeOfCalculation | `nvarchar(64)` | YES |
| OrderNumber | `nvarchar(64)` | YES |
| ArticleCodeForeign | `nvarchar(64)` | YES |
| ArticleCode | `nvarchar(64)` | YES |
| PurchasePrice | `float` | YES |
| SalesPrice | `float` | YES |
| InternalPrice | `float` | YES |
| Currency | `nvarchar(32)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| SortOrder | `nvarchar(16)` | YES |
| CustomProperty01 | `nvarchar(64)` | YES |
| CustomProperty02 | `nvarchar(64)` | YES |
| CustomProperty03 | `nvarchar(64)` | YES |
| CustomProperty04 | `nvarchar(64)` | YES |
| CustomProperty05 | `nvarchar(64)` | YES |
| CustomProperty06 | `nvarchar(64)` | YES |
| CustomProperty07 | `nvarchar(64)` | YES |
| CustomProperty08 | `nvarchar(64)` | YES |
| CustomProperty09 | `nvarchar(64)` | YES |
| CustomProperty10 | `nvarchar(64)` | YES |
| IsSpecialProduct | `bit` | YES |
| XTouched | `nchar(1)` | YES |
| IsCopyOnShopChange | `bit` | YES |
| VATPercent | `float` | YES |
| JPegPhoto | `varbinary` | YES |
| UID_FirmPartner | `varchar(38)` | YES |
| SalesRentCharge | `float` | YES |
| PurchaseRentCharge | `float` | YES |
| InternalRentCharge | `float` | YES |
| ProductURL | `nvarchar(MAX)` | YES |
| MaxValidDays | `int` | YES |
| Availability | `nvarchar(64)` | YES |
| IsInActive | `bit` | YES |
| XObjectKey | `varchar(138)` | NO |
| UID_OrgAttestator | `varchar(38)` | YES |
| XMarkedForDeletion | `int` | YES |
| UID_QERTermsOfUse | `varchar(38)` | YES |
| IsNoCopyParametersPerson | `bit` | YES |
| IsApproveRequiresMfa | `bit` | YES |
| ApproveReasonType | `int` | YES |
| OrderReasonType | `int` | YES |
| DenyReasonType | `int` | YES |
| IsToHideFromITShop | `bit` | YES |
| UID_AOBEntitlement | `varchar(38)` | YES |

### AccProductDependencies  (2 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AccProduct | `varchar(38)` | NO |
| UID_AccProductRelated | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| IsMandatory | `bit` | YES |
| IsOptional | `bit` | YES |
| IsExcluded | `bit` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AccProductGroup  (27 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AccProductGroup | `varchar(38)` | NO |
| UID_AccProductParamCategory | `varchar(38)` | YES |
| UID_PWODecisionMethod | `varchar(38)` | YES |
| UID_OrgRuler | `varchar(38)` | YES |
| SalesPrice | `float` | YES |
| InternalPrice | `float` | YES |
| PurchasePrice | `float` | YES |
| Currency | `nvarchar(32)` | YES |
| Description | `nvarchar(MAX)` | YES |
| Ident_AccProductGroup | `nvarchar(256)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| SortOrder | `nvarchar(16)` | YES |
| CustomProperty01 | `nvarchar(64)` | YES |
| CustomProperty02 | `nvarchar(64)` | YES |
| CustomProperty03 | `nvarchar(64)` | YES |
| CustomProperty04 | `nvarchar(64)` | YES |
| CustomProperty05 | `nvarchar(64)` | YES |
| CustomProperty06 | `nvarchar(64)` | YES |
| CustomProperty07 | `nvarchar(64)` | YES |
| CustomProperty08 | `nvarchar(64)` | YES |
| CustomProperty09 | `nvarchar(64)` | YES |
| CustomProperty10 | `nvarchar(64)` | YES |
| Remarks | `nvarchar(MAX)` | YES |
| IsSpecialGroup | `bit` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| UID_AccProductGroupParent | `varchar(38)` | YES |
| JPegPhoto | `varbinary` | YES |
| UID_OrgAttestator | `varchar(38)` | YES |
| FullPath | `nvarchar(256)` | YES |
| XMarkedForDeletion | `int` | YES |
| ApproveReasonType | `int` | YES |
| OrderReasonType | `int` | YES |
| DenyReasonType | `int` | YES |
| UID_AOBApplication | `varchar(38)` | YES |

### AccProductGroupCollection  (42 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AccProductGroupParent | `varchar(38)` | NO |
| LevelNumber | `int` | YES |
| UID_AccProductGroupChild | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |

### AccProductInAccProduct  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AccProductParent | `varchar(38)` | NO |
| UID_AccProductChild | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AccProductInBaseTree  (2 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Org | `varchar(38)` | NO |
| UID_AccProduct | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AccProductInFunctionalArea  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_FunctionalArea | `varchar(38)` | NO |
| UID_AccProduct | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AccProductParamCategory  (8 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AccProductParamCategory | `varchar(38)` | NO |
| Ident_AccProductParamCategory | `nvarchar(64)` | YES |
| Description | `nvarchar(256)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| IsOldStyle | `bit` | YES |

### AccProductParameter  (18 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AccProductParameter | `varchar(38)` | NO |
| UID_AccProductParamCategory | `varchar(38)` | YES |
| ColumnName | `nvarchar(32)` | YES |
| DisplayValue | `nvarchar(256)` | YES |
| IsReadOnly | `bit` | YES |
| IsMandatory | `bit` | YES |
| SortOrder | `int` | YES |
| ApproverCanEdit | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| FKWhereClause | `nvarchar(MAX)` | YES |
| XMarkedForDeletion | `int` | YES |

### ADSAccount  (22 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ADSAccount | `varchar(38)` | NO |
| UID_ADSGroupPrimary | `varchar(38)` | YES |
| UID_HomeServer | `varchar(38)` | YES |
| UID_Person | `varchar(38)` | YES |
| UID_ADSContainer | `varchar(38)` | YES |
| UID_ADSContainerDisabled | `varchar(38)` | YES |
| AccountExpires | `datetime` | YES |
| AllowDialIn | `bit` | YES |
| cn | `nvarchar(110)` | NO |
| Company | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| Department | `nvarchar(64)` | YES |
| Description | `nvarchar(1024)` | YES |
| DisplayName | `nvarchar(255)` | YES |
| DistinguishedName | `nvarchar(1000)` | YES |
| Fax | `nvarchar(64)` | YES |
| GivenName | `nvarchar(64)` | YES |
| HomeDirectory | `nvarchar(400)` | YES |
| HomeDrive | `nvarchar(2)` | YES |
| Info | `nvarchar(MAX)` | YES |
| Initials | `nvarchar(8)` | YES |
| Locality | `nvarchar(128)` | YES |
| UserPassword | `varchar(990)` | YES |
| LogonHours | `varchar(168)` | YES |
| IsGroupAccount | `bit` | YES |
| HomeSize | `nvarchar(12)` | YES |
| ProfilePath | `nvarchar(400)` | YES |
| Mail | `nvarchar(255)` | YES |
| Mobile | `nvarchar(64)` | YES |
| MSNPCallingStationID | `nvarchar(32)` | YES |
| MSRADIUSCallBackNumber | `nvarchar(128)` | YES |
| MSRADIUSFramedIPAddress | `nchar(15)` | YES |
| MSRADIUSFramedRoute | `nvarchar(MAX)` | YES |
| MSRADIUSServiceType | `nvarchar(16)` | YES |
| ObjectClass | `nvarchar(256)` | YES |
| ObjectGUID | `varchar(36)` | YES |
| OtherFax | `nvarchar(MAX)` | YES |
| OtherHomePhone | `nvarchar(MAX)` | YES |
| OtherIPPhone | `nvarchar(MAX)` | YES |
| OtherMobile | `nvarchar(MAX)` | YES |
| OtherPager | `nvarchar(MAX)` | YES |
| OtherWWW | `nvarchar(MAX)` | YES |
| Pager | `nvarchar(64)` | YES |
| PostalCode | `nvarchar(40)` | YES |
| State | `nvarchar(128)` | YES |
| StreetAddress | `nvarchar(MAX)` | YES |
| PostOfficeBox | `nvarchar(40)` | YES |
| PWDLastSet | `datetime` | YES |
| Surname | `nvarchar(64)` | YES |
| TelephoneNumber | `nvarchar(64)` | YES |
| Title | `nvarchar(128)` | YES |
| UserPrincipalName | `nvarchar(1024)` | YES |
| WWWHomePage | `nvarchar(MAX)` | YES |
| SAMAccountName | `nvarchar(20)` | YES |
| ScriptPath | `nvarchar(400)` | YES |
| IsPreferredAccount | `bit` | YES |
| AccountDisabled | `bit` | YES |
| StorePWUsingRevEncrypt | `bit` | YES |
| PasswordNeverExpires | `bit` | YES |
| SmartCardRequired | `bit` | YES |
| AccountTrustedForDelegation | `bit` | YES |
| AccountSensitive | `bit` | YES |
| UseDES | `bit` | YES |
| DoNotRequireKerberos | `bit` | YES |
| UserMustChangePassword | `bit` | YES |
| UserCanNotChangePassword | `bit` | YES |
| LogonWorkstation | `nvarchar(MAX)` | YES |
| HomePhone | `nvarchar(64)` | YES |
| ipPhone | `nvarchar(64)` | YES |
| AccountLockedOut | `bit` | YES |
| PhysicalDeliveryOfficeName | `nvarchar(128)` | YES |
| OtherMailBox | `nvarchar(MAX)` | YES |
| TerminalServerProfilePath | `nvarchar(400)` | YES |
| AllowLogonTerminalServer | `bit` | YES |
| TerminalServerRemoteHomeDir | `bit` | YES |
| TerminalServerHomeDir | `nvarchar(400)` | YES |
| TerminalServerHomeDirDrive | `nchar(2)` | YES |
| HomeShare | `nvarchar(400)` | YES |
| SharedAs | `nvarchar(64)` | YES |
| HomeDirPath | `nvarchar(400)` | YES |
| ProfileShare | `nvarchar(64)` | YES |
| ProfileDirPath | `nvarchar(400)` | YES |
| UID_ProfileServer | `varchar(38)` | YES |
| UID_TerminalHomeServer | `varchar(38)` | YES |
| UID_TerminalProfileServer | `varchar(38)` | YES |
| RASNoCallBack | `bit` | YES |
| RASCallerSetCallBack | `bit` | YES |
| RASAlwaysCallBack | `bit` | YES |
| TerminalHomeShare | `nvarchar(400)` | YES |
| TerminalSharedAs | `nvarchar(400)` | YES |
| TerminalHomeDirPath | `nvarchar(400)` | YES |
| TerminalProfileShare | `nvarchar(400)` | YES |
| TerminalProfileDirPath | `nvarchar(400)` | YES |
| CanonicalName | `nvarchar(1000)` | YES |
| OtherTelephoneNumber | `nvarchar(MAX)` | YES |
| ExtensionAttribute1 | `nvarchar(MAX)` | YES |
| ExtensionAttribute2 | `nvarchar(MAX)` | YES |
| ExtensionAttribute3 | `nvarchar(MAX)` | YES |
| ExtensionAttribute4 | `nvarchar(MAX)` | YES |
| ExtensionAttribute5 | `nvarchar(MAX)` | YES |
| ExtensionAttribute6 | `nvarchar(MAX)` | YES |
| ExtensionAttribute7 | `nvarchar(MAX)` | YES |
| ExtensionAttribute8 | `nvarchar(MAX)` | YES |
| ExtensionAttribute9 | `nvarchar(MAX)` | YES |
| ExtensionAttribute10 | `nvarchar(MAX)` | YES |
| ExtensionAttribute11 | `nvarchar(MAX)` | YES |
| ExtensionAttribute12 | `nvarchar(MAX)` | YES |
| ExtensionAttribute13 | `nvarchar(MAX)` | YES |
| ExtensionAttribute14 | `nvarchar(MAX)` | YES |
| ExtensionAttribute15 | `nvarchar(MAX)` | YES |
| MaxStorage | `nvarchar(12)` | YES |
| ExtensionData | `nvarchar(MAX)` | YES |
| TSInitialProgram | `nvarchar(256)` | YES |
| TSWorkingDirectory | `nvarchar(256)` | YES |
| TSInheritInitialProgram | `bit` | YES |
| TSTimeoutSetConnections | `int` | YES |
| TSTimeoutSetDisconnections | `int` | YES |
| TSTimeoutSetIdle | `int` | YES |
| TSDeviceClientDrives | `bit` | YES |
| TSDeviceClientPrinters | `bit` | YES |
| TSDeviceClientDefaultPrinter | `bit` | YES |
| TSBrokenTimeoutSet | `bit` | YES |
| TSReconnectSet | `bit` | YES |
| TSRemoteEnable | `bit` | YES |
| TSRemotePermissionRequired | `bit` | YES |
| TSRemoteViewSession | `bit` | YES |
| TSRemoteInteractWithSession | `bit` | YES |
| PSharedAs | `nvarchar(400)` | YES |
| XTouched | `nchar(1)` | YES |
| AllowDialinByPolicy | `bit` | YES |
| PersonalTitle | `nvarchar(64)` | YES |
| XObjectKey | `varchar(138)` | NO |
| ObjectSID | `nvarchar(255)` | YES |
| MatchPatternForMembership | `bigint` | YES |
| UID_ADSCountryCode | `varchar(38)` | YES |
| LastLogon | `datetime` | YES |
| RiskIndexCalculated | `float` | YES |
| EmployeeID | `nvarchar(16)` | YES |
| EmployeeNumber | `nvarchar(512)` | YES |
| EmployeeType | `nvarchar(256)` | YES |
| XMarkedForDeletion | `int` | YES |
| UID_TSBAccountDef | `varchar(38)` | YES |
| IsPrivilegedAccount | `bit` | YES |
| UID_TSBBehavior | `varchar(38)` | YES |
| ObjectKeyManager | `varchar(138)` | YES |
| UID_ADSDomain | `varchar(38)` | NO |
| XDateSubItem | `datetime` | YES |
| StructuralObjectClass | `nvarchar(256)` | YES |
| SIDHistory | `nvarchar(MAX)` | YES |
| IdentityType | `varchar(32)` | YES |
| IsProtectedFromAccidentalDel | `bit` | YES |
| MSDsConsistencyGuid | `nvarchar(256)` | YES |
| MiddleName | `nvarchar(64)` | YES |
| NeverConnectToPerson | `int` | YES |
| IsNeverConnectManual | `bit` | YES |
| GidNumber | `int` | YES |
| Gecos | `nvarchar(400)` | YES |
| LoginShell | `nvarchar(400)` | YES |
| UidPosix | `varchar(128)` | YES |
| UidNumber | `int` | YES |
| UnixHomeDirectory | `nvarchar(400)` | YES |
| edsvaDeprovisionStatus | `int` | YES |
| edsvaDeprovisionDeletionDate | `datetime` | YES |

### ADSAccountInADSGroup  (32 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ADSAccount | `varchar(38)` | NO |
| UID_ADSGroup | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### ADSAccountSecretary  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ADSAccountSecretary | `varchar(38)` | NO |
| UID_ADSAccount | `varchar(38)` | NO |
| ObjectKeySecretary | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### ADSContact  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ADSContact | `varchar(38)` | NO |
| DistinguishedName | `nvarchar(1000)` | YES |
| CanonicalName | `nvarchar(1000)` | YES |
| ObjectClass | `nvarchar(256)` | YES |
| UID_ADSDomain | `varchar(38)` | NO |
| UID_ADSContainer | `varchar(38)` | YES |
| ExtensionAttribute1 | `nvarchar(MAX)` | YES |
| ExtensionAttribute2 | `nvarchar(MAX)` | YES |
| ExtensionAttribute3 | `nvarchar(MAX)` | YES |
| ExtensionAttribute4 | `nvarchar(MAX)` | YES |
| ExtensionAttribute5 | `nvarchar(MAX)` | YES |
| ExtensionAttribute6 | `nvarchar(MAX)` | YES |
| ExtensionAttribute7 | `nvarchar(MAX)` | YES |
| ExtensionAttribute8 | `nvarchar(MAX)` | YES |
| ExtensionAttribute9 | `nvarchar(MAX)` | YES |
| ExtensionAttribute10 | `nvarchar(MAX)` | YES |
| ExtensionAttribute11 | `nvarchar(MAX)` | YES |
| ExtensionAttribute12 | `nvarchar(MAX)` | YES |
| ExtensionAttribute13 | `nvarchar(MAX)` | YES |
| ExtensionAttribute14 | `nvarchar(MAX)` | YES |
| ExtensionAttribute15 | `nvarchar(MAX)` | YES |
| OtherFax | `nvarchar(MAX)` | YES |
| OtherHomePhone | `nvarchar(MAX)` | YES |
| OtherIPPhone | `nvarchar(MAX)` | YES |
| OtherMailBox | `nvarchar(MAX)` | YES |
| OtherMobile | `nvarchar(MAX)` | YES |
| OtherPager | `nvarchar(MAX)` | YES |
| OtherTelephoneNumber | `nvarchar(MAX)` | YES |
| OtherWWW | `nvarchar(MAX)` | YES |
| Company | `nvarchar(64)` | YES |
| UID_ADSCountryCode | `varchar(38)` | YES |
| Department | `nvarchar(64)` | YES |
| Description | `nvarchar(1024)` | YES |
| DisplayName | `nvarchar(255)` | YES |
| Mail | `nvarchar(255)` | YES |
| cn | `nvarchar(110)` | NO |
| Fax | `nvarchar(64)` | YES |
| HomePhone | `nvarchar(64)` | YES |
| GivenName | `nvarchar(64)` | YES |
| Info | `nvarchar(MAX)` | YES |
| Initials | `nvarchar(8)` | YES |
| Locality | `nvarchar(128)` | YES |
| ipPhone | `nvarchar(64)` | YES |
| Mobile | `nvarchar(64)` | YES |
| Pager | `nvarchar(64)` | YES |
| PhysicalDeliveryOfficeName | `nvarchar(128)` | YES |
| PostalCode | `nvarchar(40)` | YES |
| PostOfficeBox | `nvarchar(40)` | YES |
| StreetAddress | `nvarchar(MAX)` | YES |
| State | `nvarchar(128)` | YES |
| Surname | `nvarchar(64)` | YES |
| TelephoneNumber | `nvarchar(64)` | YES |
| Title | `nvarchar(128)` | YES |
| WWWHomePage | `nvarchar(MAX)` | YES |
| PersonalTitle | `nvarchar(64)` | YES |
| EmployeeID | `nvarchar(16)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| MatchPatternForMembership | `bigint` | YES |
| UID_TSBBehavior | `varchar(38)` | YES |
| UID_Person | `varchar(38)` | YES |
| UID_TSBAccountDef | `varchar(38)` | YES |
| RiskIndexCalculated | `float` | YES |
| IsGroupAccount | `bit` | YES |
| ObjectKeyManager | `varchar(138)` | YES |
| ObjectGUID | `varchar(36)` | YES |
| EmployeeNumber | `nvarchar(512)` | YES |
| EmployeeType | `nvarchar(256)` | YES |
| XDateSubItem | `datetime` | YES |
| StructuralObjectClass | `nvarchar(256)` | YES |
| IdentityType | `varchar(32)` | YES |
| IsProtectedFromAccidentalDel | `bit` | YES |
| MSDsConsistencyGuid | `nvarchar(256)` | YES |
| NeverConnectToPerson | `int` | YES |
| IsNeverConnectManual | `bit` | YES |
| GidNumber | `int` | YES |
| Gecos | `nvarchar(400)` | YES |
| LoginShell | `nvarchar(400)` | YES |
| UidPosix | `varchar(128)` | YES |
| UidNumber | `int` | YES |
| UnixHomeDirectory | `nvarchar(400)` | YES |

### ADSContactInADSGroup  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ADSGroup | `varchar(38)` | NO |
| UID_ADSContact | `varchar(38)` | NO |
| XDateUpdated | `datetime` | YES |
| XDateInserted | `datetime` | YES |
| XOrigin | `int` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| RiskIndexCalculated | `float` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |

### ADSContactSecretary  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ADSContactSecretary | `varchar(38)` | NO |
| UID_ADSContact | `varchar(38)` | NO |
| ObjectKeySecretary | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### ADSContainer  (126 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ADSContainer | `varchar(38)` | NO |
| UID_AERoleOwner | `varchar(38)` | YES |
| UID_ParentADSContainer | `varchar(38)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| cn | `nvarchar(110)` | NO |
| Description | `nvarchar(1024)` | YES |
| DistinguishedName | `nvarchar(1000)` | YES |
| Locality | `nvarchar(64)` | YES |
| ObjectClass | `nvarchar(256)` | YES |
| ObjectGUID | `varchar(36)` | YES |
| ou | `nvarchar(110)` | YES |
| PostalCode | `nvarchar(16)` | YES |
| State | `nvarchar(32)` | YES |
| Street | `nvarchar(MAX)` | YES |
| IsSystemContainer | `bit` | YES |
| ShowInAdvancedViewOnly | `bit` | YES |
| CanonicalName | `nvarchar(1000)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| UID_ADSCountryCode | `varchar(38)` | YES |
| DomainDisplayName | `nvarchar(128)` | YES |
| XMarkedForDeletion | `int` | YES |
| UID_ADSDomain | `varchar(38)` | NO |
| ObjectKeyManager | `varchar(138)` | YES |
| IsProtectedFromAccidentalDel | `bit` | YES |
| StructuralObjectClass | `nvarchar(256)` | YES |

### ADSDomain  (3 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ADSDomain | `varchar(38)` | NO |
| UID_AERoleOwner | `varchar(38)` | YES |
| Ident_Domain | `nvarchar(32)` | NO |
| UID_TSBAccountDef | `varchar(38)` | YES |
| Description | `nvarchar(1024)` | YES |
| MinPasswordLength | `int` | YES |
| MinPasswordAge | `int` | YES |
| MaxPasswordAge | `int` | YES |
| MaxBadPasswordsAllowed | `int` | YES |
| PasswordHistoryLength | `int` | YES |
| AutoUnlockInterval | `int` | YES |
| LockoutObservationInterval | `int` | YES |
| DefaultHomeDrive | `nchar(2)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| dc | `nvarchar(64)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| ObjectGUID | `varchar(36)` | YES |
| ADSDomainName | `nvarchar(255)` | YES |
| IsADSComplexPassword | `bit` | YES |
| XTouched | `nchar(1)` | YES |
| ObjectClass | `nvarchar(255)` | YES |
| XObjectKey | `varchar(138)` | NO |
| CanonicalName | `nvarchar(400)` | YES |
| DisplayName | `nvarchar(128)` | YES |
| NamespaceManagedBy | `nvarchar(16)` | YES |
| IsRecyclerEnabled | `bit` | YES |
| msDSdeletedObjectLifetime | `int` | YES |
| AccountToPersonMatchingRule | `nvarchar(MAX)` | YES |
| XMarkedForDeletion | `int` | YES |
| UID_ADSDomainSubType | `varchar(38)` | YES |
| UID_ADSDomainParent | `varchar(38)` | YES |
| UID_ADSForest | `varchar(38)` | NO |
| ObjectKeyManager | `varchar(138)` | YES |
| MatchPatternDisplay | `nvarchar(MAX)` | YES |
| UID_TSBAccountDefContact | `varchar(38)` | YES |
| StructuralObjectClass | `nvarchar(256)` | YES |
| ObjectSID | `nvarchar(255)` | YES |
| msDSExpirePasswdOnSCardOnlyAcc | `bit` | YES |
| UID_ADSMachineRIDMaster | `varchar(38)` | YES |
| AdUserName | `nvarchar(512)` | YES |
| AdUserPassword | `varchar(990)` | YES |
| IsArsWorkflowsEnabled | `bit` | YES |
| UseARSDeprovUserByDefault | `bit` | YES |
| UseARSDeprovGroupByDefault | `bit` | YES |
| UID_TSBAccountDefEX0MailUser | `varchar(38)` | YES |
| UID_TSBAccountDefEX0MailBox | `varchar(38)` | YES |
| UID_TSBAccountDefEX0MailCont | `varchar(38)` | YES |
| EX0UserName | `nvarchar(512)` | YES |
| EX0UserPassword | `varchar(990)` | YES |
| UID_ADSMachineEX0DC | `varchar(38)` | YES |
| UID_TSBAccountDefEXHRemoteMB | `varchar(38)` | YES |

### ADSDomainSubType  (9 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ADSDomainSubType | `varchar(38)` | NO |
| Ident_ADSDomainSubType | `nvarchar(64)` | NO |
| Description | `nvarchar(1024)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### ADSForest  (3 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ADSForest | `varchar(38)` | NO |
| DistinguishedName | `nvarchar(400)` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| ForestMode | `nvarchar(128)` | YES |
| Name | `nvarchar(512)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### ADSGroup  (52 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ADSGroup | `varchar(38)` | NO |
| UID_AccProduct | `varchar(38)` | YES |
| UID_ADSContainer | `varchar(38)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| cn | `nvarchar(110)` | NO |
| Description | `nvarchar(1024)` | YES |
| DistinguishedName | `nvarchar(1000)` | YES |
| Info | `nvarchar(1024)` | YES |
| Mail | `nvarchar(255)` | YES |
| ObjectGUID | `varchar(36)` | YES |
| SAMAccountName | `nvarchar(256)` | YES |
| IsDistributionGroup | `bit` | YES |
| IsGlobal | `bit` | YES |
| IsLocal | `bit` | YES |
| IsUniversal | `bit` | YES |
| IsSecurity | `bit` | YES |
| CanonicalName | `nvarchar(1000)` | YES |
| primaryGroupToken | `nvarchar(12)` | YES |
| ExtensionAttribute1 | `nvarchar(MAX)` | YES |
| ExtensionAttribute2 | `nvarchar(MAX)` | YES |
| ExtensionAttribute3 | `nvarchar(MAX)` | YES |
| ExtensionAttribute4 | `nvarchar(MAX)` | YES |
| ExtensionAttribute5 | `nvarchar(MAX)` | YES |
| ExtensionAttribute6 | `nvarchar(MAX)` | YES |
| ExtensionAttribute7 | `nvarchar(MAX)` | YES |
| ExtensionAttribute8 | `nvarchar(MAX)` | YES |
| ExtensionAttribute9 | `nvarchar(MAX)` | YES |
| ExtensionAttribute10 | `nvarchar(MAX)` | YES |
| ExtensionAttribute11 | `nvarchar(MAX)` | YES |
| ExtensionAttribute12 | `nvarchar(MAX)` | YES |
| ExtensionAttribute13 | `nvarchar(MAX)` | YES |
| ExtensionAttribute14 | `nvarchar(MAX)` | YES |
| ExtensionAttribute15 | `nvarchar(MAX)` | YES |
| DisplayName | `nvarchar(255)` | YES |
| IsForITShop | `bit` | YES |
| XTouched | `nchar(1)` | YES |
| ObjectClass | `nvarchar(256)` | YES |
| AllowWriteMembers | `bit` | YES |
| IsITShopOnly | `bit` | YES |
| XObjectKey | `varchar(138)` | NO |
| ObjectSID | `nvarchar(255)` | YES |
| MatchPatternForMembership | `bigint` | YES |
| RiskIndex | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| ObjectKeyManager | `varchar(138)` | YES |
| UID_ADSDomain | `varchar(38)` | NO |
| XDateSubItem | `datetime` | YES |
| StructuralObjectClass | `nvarchar(256)` | YES |
| SIDHistory | `nvarchar(MAX)` | YES |
| IsProtectedFromAccidentalDel | `bit` | YES |
| MSDsConsistencyGuid | `nvarchar(256)` | YES |
| IsApplicationGroup | `bit` | YES |
| HasReadOnlyMemberships | `bit` | YES |
| GidNumber | `int` | YES |
| edsvaPublished | `bit` | YES |
| edsvaAppByPrimaryOwnerReq | `bit` | YES |
| edsvaAppBySecondaryOwnerReq | `bit` | YES |
| edsvaSecondaryOwners | `nvarchar(MAX)` | YES |
| edsvaDeprovisionStatus | `int` | YES |
| edsvaDeprovisionDeletionDate | `datetime` | YES |
| edsaIsDynamicGroup | `bit` | YES |
| edsvaGFIsGroupFamily | `bit` | YES |
| edsvaCGisControlledGroup | `bit` | YES |

### ADSGroupCollection  (63 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ADSGroupParent | `varchar(38)` | NO |
| UID_ADSGroupChild | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| LevelNumber | `int` | YES |
| IsCircular | `bit` | YES |
| XMarkedForDeletion | `int` | YES |

### ADSGroupExclusion  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ADSGroupLower | `varchar(38)` | NO |
| UID_ADSGroupHigher | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### ADSGroupInADSGroup  (11 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ADSGroupParent | `varchar(38)` | NO |
| UID_ADSGroupChild | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### ADSGroupSecretary  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ADSGroupSecretary | `varchar(38)` | NO |
| UID_ADSGroup | `varchar(38)` | NO |
| ObjectKeySecretary | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### ADSMachine  (5 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ADSMachine | `varchar(38)` | NO |
| UID_Hardware | `varchar(38)` | YES |
| UID_ADSGroupPrimary | `varchar(38)` | YES |
| DistinguishedName | `nvarchar(1000)` | YES |
| ObjectGUID | `varchar(36)` | YES |
| SAMAccountName | `nvarchar(20)` | YES |
| ObjectClass | `nvarchar(255)` | YES |
| CanonicalName | `nvarchar(1000)` | YES |
| ObjectSID | `nvarchar(255)` | YES |
| UID_ADSContainer | `varchar(38)` | YES |
| cn | `nvarchar(110)` | NO |
| DNSHostName | `nvarchar(256)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| ObjectKeyManager | `varchar(138)` | YES |
| UID_ADSDomain | `varchar(38)` | NO |
| MachineRole | `nvarchar(MAX)` | YES |
| OperatingSystem | `nvarchar(MAX)` | YES |
| OperatingSystemHotfix | `nvarchar(MAX)` | YES |
| OperatingSystemServicePack | `nvarchar(MAX)` | YES |
| OperatingSystemVersion | `nvarchar(MAX)` | YES |
| StructuralObjectClass | `nvarchar(256)` | YES |
| SIDHistory | `nvarchar(MAX)` | YES |
| IsProtectedFromAccidentalDel | `bit` | YES |
| MSDsConsistencyGuid | `nvarchar(256)` | YES |

### ADSMachineInADSGroup  (6 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ADSGroup | `varchar(38)` | NO |
| UID_ADSMachine | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### ADSMachineInADSSite  (1 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ADSMachine | `varchar(38)` | NO |
| UID_ADSSite | `varchar(38)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### ADSOtherSID  (111 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ADSOtherSID | `varchar(38)` | NO |
| ObjectSID | `nvarchar(255)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| Ident_ADSOtherSID | `nvarchar(256)` | YES |
| DistinguishedName | `nvarchar(1000)` | YES |
| CanonicalName | `nvarchar(1000)` | YES |
| XMarkedForDeletion | `int` | YES |
| IsPrivilegedAccount | `bit` | YES |

### ADSOtherSIDInADSGroup  (15 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ADSOtherSID | `varchar(38)` | NO |
| UID_ADSGroup | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### ADSPolicy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ADSPolicy | `varchar(38)` | NO |
| cn | `nvarchar(110)` | NO |
| Description | `nvarchar(1024)` | YES |
| DistinguishedName | `nvarchar(400)` | NO |
| CanonicalName | `nvarchar(400)` | YES |
| displayNamePrintable | `nvarchar(MAX)` | YES |
| DisplayName | `nvarchar(255)` | YES |
| msDSLockoutDuration | `int` | YES |
| msDSLockoutObservationWindow | `int` | YES |
| msDSLockoutThreshold | `int` | YES |
| msDSMaximumPwdAge | `bigint` | YES |
| msDSMinimumPwdAge | `int` | YES |
| msDSMinimumPwdLength | `int` | YES |
| msDSPwdSettingsPrecedence | `int` | YES |
| msDSPwdReversibleEncryption | `bit` | YES |
| msDSPwdHistoryLength | `int` | YES |
| msDSPwdComplexity | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| UID_ADSDomain | `varchar(38)` | NO |
| ObjectGUID | `varchar(36)` | YES |
| XDateSubItem | `datetime` | YES |

### ADSPolicyAppliesTo  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ADSPolicyAppliesTo | `varchar(38)` | NO |
| UID_ADSPolicy | `varchar(38)` | NO |
| ObjectKeyAppliesTo | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### ADSPrinter  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ADSPrinter | `varchar(38)` | NO |
| CustomProperty01 | `nvarchar(64)` | YES |
| CustomProperty02 | `nvarchar(64)` | YES |
| CustomProperty03 | `nvarchar(64)` | YES |
| CustomProperty04 | `nvarchar(64)` | YES |
| CustomProperty05 | `nvarchar(64)` | YES |
| CustomProperty06 | `nvarchar(64)` | YES |
| CustomProperty07 | `nvarchar(64)` | YES |
| CustomProperty08 | `nvarchar(64)` | YES |
| CustomProperty09 | `nvarchar(64)` | YES |
| CustomProperty10 | `nvarchar(64)` | YES |
| uncName | `nvarchar(256)` | YES |
| Description | `nvarchar(1024)` | YES |
| PortName | `nvarchar(256)` | YES |
| IsPrintColor | `bit` | YES |
| IsPrintDuplexSupported | `bit` | YES |
| PrintPagesPerMinute | `int` | YES |
| IsPrintStaplingSupported | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| UID_ADSMachine | `varchar(38)` | NO |
| Location | `nvarchar(MAX)` | YES |
| printMaxResolutionSupported | `int` | YES |
| PrintMaxXExtent | `int` | YES |
| PrintMaxYExtent | `int` | YES |
| DriverName | `nvarchar(MAX)` | YES |
| PrinterName | `nvarchar(64)` | YES |
| ServerName | `nvarchar(255)` | YES |
| ShortServerName | `nvarchar(255)` | YES |
| DistinguishedName | `nvarchar(1000)` | YES |
| ObjectGUID | `varchar(36)` | YES |
| CanonicalName | `nvarchar(1000)` | YES |

### ADSSite  (1 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ADSSite | `varchar(38)` | NO |
| ObjectGUID | `varchar(36)` | YES |
| cn | `nvarchar(110)` | YES |
| Location | `nvarchar(1024)` | YES |
| Description | `nvarchar(1024)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| ObjectClass | `nvarchar(256)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| SubNets | `nvarchar(MAX)` | YES |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| UID_ADSForest | `varchar(38)` | NO |

### AOBAppHasAttestationPolicy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AOBAppHasAttestationPolicy | `varchar(38)` | NO |
| UID_AOBApplication | `varchar(38)` | NO |
| ObjectKeyAttestationPolicy | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AOBAppHasComplianceRule  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AOBAppHasComplianceRule | `varchar(38)` | NO |
| UID_AOBApplication | `varchar(38)` | NO |
| ObjectKeyComplianceRule | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AOBAppHasMitigatingControl  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AOBAppHasMitigatingControl | `varchar(38)` | NO |
| UID_AOBApplication | `varchar(38)` | NO |
| ObjectKeyMitigatingControl | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AOBAppHasQERPolicy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AOBAppHasQERPolicy | `varchar(38)` | NO |
| UID_AOBApplication | `varchar(38)` | NO |
| ObjectKeyQERPolicy | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AOBAppHasTargetSH  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ITShopOrg | `varchar(38)` | NO |
| UID_AOBApplication | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AOBApplication  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AOBApplication | `varchar(38)` | NO |
| ActivationDate | `datetime` | YES |
| Ident_AOBApplication | `nvarchar(256)` | YES |
| Description | `nvarchar(MAX)` | YES |
| JPegPhoto | `varbinary` | YES |
| ApplicationEnvironment | `nvarchar(64)` | YES |
| IsInActive | `bit` | YES |
| UID_AERoleOwner | `varchar(38)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| UID_ITShopSrcBT | `varchar(38)` | YES |
| IsSSOEnabled | `bit` | YES |
| IsMultiFactorEnabled | `bit` | YES |
| IsFederationEnabled | `bit` | YES |
| IsAuthenticationIntegrated | `bit` | YES |
| ApplicationWebURL | `nvarchar(MAX)` | YES |
| SSORedirectionUrl | `nvarchar(MAX)` | YES |
| AuthenticationRoot | `varchar(138)` | YES |
| UID_FunctionalArea | `varchar(38)` | YES |
| RiskIndex | `float` | YES |
| PurchasedLicenses | `int` | YES |
| UID_AERoleApprover | `varchar(38)` | YES |
| UID_PersonHead | `varchar(38)` | YES |
| NextRunDate | `datetime` | YES |
| WhereClause | `nvarchar(MAX)` | YES |
| WhereClauseAddOn | `nvarchar(MAX)` | YES |

### AOBAppUsesAccount  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AOBAppUsesAccount | `varchar(38)` | NO |
| UID_AOBApplication | `varchar(38)` | NO |
| ObjectKeyAccount | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AOBEntitlement  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AOBEntitlement | `varchar(38)` | NO |
| ObjectKeyAdditionalApprover | `varchar(138)` | YES |
| ObjectKeyElement | `varchar(138)` | YES |
| Ident_AOBEntitlement | `nvarchar(256)` | YES |
| UID_AERoleOwner | `varchar(38)` | YES |
| Description | `nvarchar(MAX)` | YES |
| JPegPhoto | `varbinary` | YES |
| IsInActive | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| UID_AOBApplication | `varchar(38)` | NO |
| ActivationDate | `datetime` | YES |
| IsDynamic | `bit` | YES |

### AssetClass  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AssetClass | `varchar(38)` | NO |
| Ident_AssetClass | `nvarchar(64)` | NO |
| DisplayName | `nvarchar(255)` | YES |
| Description | `nvarchar(MAX)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AssetType  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AssetType | `varchar(38)` | NO |
| Ident_AssetType | `nvarchar(32)` | NO |
| Description | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### ATTBaseObjectHasDecisionRule  (5,074 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_PWODecisionRule | `varchar(38)` | NO |
| UID_DialogTable | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AttestationCase  (1,012 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AttestationCase | `varchar(38)` | NO |
| UID_QERJustification | `varchar(38)` | YES |
| UID_AttestationPolicy | `varchar(38)` | NO |
| UID_PersonHead | `varchar(38)` | YES |
| ObjectKeyBase | `varchar(138)` | YES |
| DisplayName | `nvarchar(255)` | YES |
| ReportContent | `nvarchar(MAX)` | YES |
| IsClosed | `bit` | YES |
| IsGranted | `bit` | YES |
| DisplayPersonHead | `nvarchar(255)` | YES |
| ReasonHead | `nvarchar(MAX)` | YES |
| DateHead | `datetime` | YES |
| DecisionLevel | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| ReportType | `nvarchar(16)` | YES |
| ToSolveTill | `datetime` | YES |
| StructureDisplay1 | `nvarchar(1024)` | YES |
| StructureDisplay2 | `nvarchar(1024)` | YES |
| StructureDisplay3 | `nvarchar(1024)` | YES |
| PropertyInfo1 | `nvarchar(1024)` | YES |
| PropertyInfo2 | `nvarchar(1024)` | YES |
| PropertyInfo3 | `nvarchar(1024)` | YES |
| PropertyInfo4 | `nvarchar(1024)` | YES |
| IsReserved | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| RiskIndex | `float` | YES |
| ObjectKey1 | `varchar(138)` | YES |
| ObjectKey2 | `varchar(138)` | YES |
| ObjectKey3 | `varchar(138)` | YES |
| IsNotApprovedBefore | `bit` | YES |
| UID_AttestationRun | `varchar(38)` | NO |
| UID_QERWorkingMethod | `varchar(38)` | YES |
| PeerGroupFactor | `float` | YES |
| IsCrossFunctional | `bit` | YES |
| IsUnderConstruction | `bit` | YES |
| Recommendation | `int` | YES |
| RecommendationDetail | `nvarchar(MAX)` | YES |

### AttestationCaseHasMControl  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AttestationCase | `varchar(38)` | NO |
| UID_MitigatingControl | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AttestationHelper  (488 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AttestationHelper | `varchar(38)` | NO |
| UID_PersonHead | `varchar(38)` | YES |
| UID_AttestationCase | `varchar(38)` | NO |
| LevelNumber | `int` | NO |
| SubLevelNumber | `int` | NO |
| Decision | `nchar(1)` | YES |
| ReasonHead | `nvarchar(MAX)` | YES |
| XObjectKey | `varchar(138)` | NO |
| NextReminder | `datetime` | YES |
| NextAutomaticDecision | `datetime` | YES |
| UID_PersonAdditional | `varchar(38)` | YES |
| UID_PersonInsteadOf | `varchar(38)` | YES |
| IsFromDelegation | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| UID_PWODecisionRule | `varchar(38)` | YES |
| RulerLevel | `int` | YES |
| UID_QERWorkingStep | `varchar(38)` | YES |
| UID_PWORulerOrigin | `varchar(38)` | YES |

### AttestationHistory  (1,998 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AttestationHistory | `varchar(38)` | NO |
| UID_QERJustification | `varchar(38)` | YES |
| UID_AttestationCase | `varchar(38)` | YES |
| UID_PersonHead | `varchar(38)` | YES |
| DisplayPersonHead | `nvarchar(255)` | YES |
| ReasonHead | `nvarchar(MAX)` | YES |
| DateHead | `datetime` | YES |
| DecisionLevel | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| DecisionType | `nvarchar(16)` | YES |
| IsDecisionBySystem | `bit` | YES |
| Ident_PWODecisionStep | `nvarchar(64)` | YES |
| IsToHideInHistory | `bit` | YES |
| UID_PersonRelated | `varchar(38)` | YES |
| XMarkedForDeletion | `int` | YES |
| UID_PWODecisionRule | `varchar(38)` | YES |
| RulerLevel | `int` | YES |

### AttestationObject  (43 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AttestationObject | `varchar(38)` | NO |
| Ident_AttestationObject | `nvarchar(64)` | YES |
| ObjectKeyReport | `varchar(138)` | YES |
| Description | `nvarchar(512)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| StructureDisplayPattern1 | `nvarchar(1024)` | YES |
| StructureDisplayPattern2 | `nvarchar(1024)` | YES |
| StructureDisplayPattern3 | `nvarchar(1024)` | YES |
| PropertyInfoPattern1 | `nvarchar(1024)` | YES |
| PropertyInfoPattern2 | `nvarchar(1024)` | YES |
| PropertyInfoPattern3 | `nvarchar(1024)` | YES |
| PropertyInfoPattern4 | `nvarchar(1024)` | YES |
| PropertyInfo1 | `nvarchar(256)` | YES |
| PropertyInfo2 | `nvarchar(256)` | YES |
| PropertyInfo3 | `nvarchar(256)` | YES |
| PropertyInfo4 | `nvarchar(256)` | YES |
| UID_AttestationType | `varchar(38)` | YES |
| StructureDisplay1 | `nvarchar(256)` | YES |
| StructureDisplay2 | `nvarchar(256)` | YES |
| StructureDisplay3 | `nvarchar(256)` | YES |
| PreProcessorCondition | `nvarchar(1024)` | YES |
| IsDeactivatedByPreProcessor | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| UID_DialogTable | `varchar(38)` | YES |
| RiskIndexTemplate | `nvarchar(1024)` | YES |
| ObjectKey1 | `nvarchar(1024)` | YES |
| ObjectKey2 | `nvarchar(1024)` | YES |
| ObjectKey3 | `nvarchar(1024)` | YES |
| UiText | `nvarchar(MAX)` | YES |
| UiTextGrouped1 | `nvarchar(MAX)` | YES |
| UiTextGrouped2 | `nvarchar(MAX)` | YES |
| UiTextGrouped3 | `nvarchar(MAX)` | YES |
| ObjectReportMode | `int` | YES |
| UiChallengeText | `nvarchar(MAX)` | YES |

### AttestationObjectHasPWODM  (109 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AttestationObject | `varchar(38)` | NO |
| UID_PWODecisionMethod | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AttestationPolicy  (63 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AttestationPolicy | `varchar(38)` | NO |
| UID_PWODecisionMethod | `varchar(38)` | YES |
| Ident_AttestationPolicy | `nvarchar(64)` | YES |
| Description | `nvarchar(MAX)` | YES |
| UID_DialogSchedule | `varchar(38)` | YES |
| UID_AttestationObject | `varchar(38)` | YES |
| WhereClause | `nvarchar(MAX)` | YES |
| WhereClauseAddOn | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| ReportType | `nvarchar(16)` | YES |
| IsAutoCloseOldCases | `bit` | YES |
| DefaultReasonAutomation | `nvarchar(255)` | YES |
| SolutionDays | `int` | YES |
| WhereClauseMeta | `nvarchar(MAX)` | YES |
| RiskIndex | `float` | YES |
| RiskIndexReduced | `float` | YES |
| UID_PersonOwner | `varchar(38)` | YES |
| LimitOfOldCases | `int` | YES |
| IsInActive | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| IsApproveRequiresMfa | `bit` | YES |
| UID_AERoleOwner | `varchar(38)` | YES |
| UID_QERPickCategory | `varchar(38)` | YES |
| UID_DialogCulture | `varchar(38)` | YES |
| IsShowElementsInvolved | `bit` | YES |
| IsSetApprovalStateOnApproved | `bit` | YES |
| IsSetApprovalStateOnDenied | `bit` | YES |
| IsSingleCaseNotification | `bit` | YES |
| UID_QERTermsOfUse | `varchar(38)` | YES |
| ApproveReasonType | `int` | YES |
| DenyReasonType | `int` | YES |
| UID_AttestationPolicyGroup | `varchar(38)` | YES |
| IsNoRunOnEmptyResult | `bit` | YES |

### AttestationPolicyGroup  (1 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AttestationPolicyGroup | `varchar(38)` | NO |
| Ident_AttestationPolicyGroup | `nvarchar(64)` | YES |
| Description | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| IsInActive | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| UID_QERPickCategory | `varchar(38)` | YES |
| UID_DialogSchedule | `varchar(38)` | YES |
| UID_PersonOwner | `varchar(38)` | YES |
| UID_AERoleOwner | `varchar(38)` | YES |

### AttestationPolicyHasApprover  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AttestationPolicy | `varchar(38)` | NO |
| UID_Person | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AttestationPolicyHasMControl  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AttestationPolicy | `varchar(38)` | NO |
| UID_MitigatingControl | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AttestationPolicyInArea  (43 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ComplianceArea | `varchar(38)` | NO |
| UID_AttestationPolicy | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AttestationRun  (328 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AttestationRun | `varchar(38)` | NO |
| UID_AttestationPolicy | `varchar(38)` | YES |
| HistoryNumber | `int` | YES |
| PolicyProcessed | `datetime` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| CountChunksUnderConstruction | `int` | YES |
| UID_AttestationPolicyGroup | `varchar(38)` | YES |

### AttestationType  (7 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AttestationType | `varchar(38)` | NO |
| Ident_AttestationType | `nvarchar(128)` | YES |
| Description | `nvarchar(512)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### AttestationWizardParm  (319 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AttestationWizardParm | `varchar(38)` | NO |
| UID_AttestationObject | `varchar(38)` | NO |
| DisplayValue | `nvarchar(256)` | YES |
| WhereClauseSnippet | `nvarchar(MAX)` | YES |
| RequiredParameter | `nvarchar(256)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| PreProcessorCondition | `nvarchar(1024)` | YES |
| IsDeactivatedByPreProcessor | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| UID_DialogTablePickCategory | `varchar(38)` | YES |

### AttestationWizardParmOpt  (67 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AttestationWizardParmOpt | `varchar(38)` | NO |
| UID_AttestationWizardParm | `varchar(38)` | NO |
| DisplayValue | `nvarchar(256)` | YES |
| WhereClauseSnippet | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### BaseTree  (254 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Org | `varchar(38)` | NO |
| UID_PWODecisionMethod | `varchar(38)` | YES |
| UID_FunctionalArea | `varchar(38)` | YES |
| UID_OrgAttestator | `varchar(38)` | YES |
| UID_OrgBoardTemplate | `varchar(38)` | YES |
| UID_AccProduct | `varchar(38)` | YES |
| UID_PersonHead | `varchar(38)` | YES |
| UID_OrgDepartment | `varchar(38)` | YES |
| UID_OrgProfitCenter | `varchar(38)` | YES |
| UID_ParentOrg | `varchar(38)` | YES |
| Ident_Org | `nvarchar(256)` | NO |
| UID_OrgLocality | `varchar(38)` | YES |
| IsCutNode | `bit` | YES |
| Description | `nvarchar(MAX)` | YES |
| UID_OrgRoot | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| InternalName | `nvarchar(MAX)` | YES |
| FullPath | `nvarchar(400)` | YES |
| AccountNumber | `nvarchar(32)` | YES |
| ZIPCode | `nvarchar(16)` | YES |
| City | `nvarchar(64)` | YES |
| Street | `nvarchar(MAX)` | YES |
| TelephoneShort | `nchar(10)` | YES |
| PostalAddress | `nvarchar(MAX)` | YES |
| Room | `nvarchar(32)` | YES |
| RoomRemarks | `nvarchar(MAX)` | YES |
| Telephone | `nvarchar(MAX)` | YES |
| Commentary | `nvarchar(256)` | YES |
| CustomProperty01 | `nvarchar(64)` | YES |
| CustomProperty02 | `nvarchar(64)` | YES |
| CustomProperty03 | `nvarchar(64)` | YES |
| CustomProperty04 | `nvarchar(64)` | YES |
| CustomProperty05 | `nvarchar(64)` | YES |
| CustomProperty06 | `nvarchar(64)` | YES |
| CustomProperty07 | `nvarchar(64)` | YES |
| CustomProperty08 | `nvarchar(64)` | YES |
| CustomProperty09 | `nvarchar(64)` | YES |
| CustomProperty10 | `nvarchar(64)` | YES |
| UID_PersonHeadSecond | `varchar(38)` | YES |
| Building | `nvarchar(64)` | YES |
| treelevel | `int` | YES |
| ITShopInfo | `nvarchar(2)` | YES |
| IsX500Node | `bit` | YES |
| XTouched | `nchar(1)` | YES |
| Fax | `nvarchar(MAX)` | YES |
| IPOffset | `nchar(7)` | YES |
| IsInActive | `bit` | YES |
| Remarks | `nvarchar(MAX)` | YES |
| ShortName | `nvarchar(64)` | YES |
| SubnetMask | `nvarchar(16)` | YES |
| TXTBusinessTimes | `nvarchar(MAX)` | YES |
| TXTMailAddresses | `nvarchar(MAX)` | YES |
| TXTVisitAddresses | `nvarchar(MAX)` | YES |
| TXTWayDescriptions | `nvarchar(MAX)` | YES |
| TXTTelephoneTimes | `nvarchar(MAX)` | YES |
| TXTVisitTimes | `nvarchar(MAX)` | YES |
| SeeAlso | `nvarchar(MAX)` | YES |
| CustomDatetime1 | `datetime` | YES |
| CustomDatetime2 | `datetime` | YES |
| CustomDatetime3 | `datetime` | YES |
| XObjectKey | `varchar(138)` | NO |
| UID_RulerContainerIT | `varchar(38)` | YES |
| UID_RulerContainer | `varchar(38)` | YES |
| RiskIndexCalculated | `float` | YES |
| TransparencyIndex | `float` | YES |
| Turnover | `float` | YES |
| Profit | `float` | YES |
| IsNoInheriteToPerson | `bit` | YES |
| IsNoInheriteToWorkDesk | `bit` | YES |
| IsNoInheriteToHardware | `bit` | YES |
| UID_DialogState | `varchar(38)` | YES |
| UID_DialogCountry | `varchar(38)` | YES |
| RiskIndex | `float` | YES |
| UID_DialogCulture | `varchar(38)` | YES |
| XMarkedForDeletion | `int` | YES |
| UID_OrgType | `varchar(38)` | YES |
| UID_DialogGroup | `varchar(38)` | YES |
| ImportSource | `nvarchar(32)` | YES |
| ApprovalState | `int` | YES |
| IsInvalidForDynamicGroup | `bit` | YES |
| UID_AERoleManager | `varchar(38)` | YES |
| RuleViolationThreshold | `int` | YES |
| UID_DefaultPrintServer | `varchar(38)` | YES |

### BaseTreeAssign  (29 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_BaseTreeAssign | `varchar(38)` | NO |
| UID_TaskHardware | `varchar(38)` | YES |
| UID_TaskWorkDesk | `varchar(38)` | YES |
| UID_TaskPerson | `varchar(38)` | YES |
| UID_TaskBaseTree | `varchar(38)` | YES |
| UID_DialogTableElement | `varchar(38)` | YES |
| IsITShopEnabled | `bit` | YES |
| IsEsetEnabled | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| UID_DialogTableMN | `varchar(38)` | YES |
| DelegationType | `int` | YES |
| XMarkedForDeletion | `int` | YES |
| IsReusePossible | `bit` | YES |
| IsReusePossibleUS | `bit` | YES |
| DisplayNameElement | `nvarchar(64)` | YES |
| DisplayNameMN | `nvarchar(64)` | YES |

### BaseTreeCollection  (421 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Org | `varchar(38)` | NO |
| UID_ParentOrg | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |

### BaseTreeCollectionF  (527 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Org | `varchar(38)` | NO |
| UID_ParentOrg | `varchar(38)` | NO |

### BaseTreeExcludesBasetree  (1 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Org | `varchar(38)` | NO |
| UID_OrgExcluded | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### BaseTreeHasADSGroup  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Org | `varchar(38)` | NO |
| UID_ADSGroup | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### BaseTreeHasESet  (55 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Org | `varchar(38)` | NO |
| UID_ESet | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### BaseTreeHasObject  (272 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_BaseTreeHasObject | `varchar(38)` | NO |
| ObjectKey | `varchar(138)` | NO |
| UID_Org | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| InheritInfo | `int` | YES |

### BaseTreeHasPWODecisionMethod  (9 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Org | `varchar(38)` | NO |
| UID_PWODecisionMethod | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### BaseTreeHasQERAssign  (32 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Org | `varchar(38)` | NO |
| UID_QERAssign | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### BaseTreeHasQERResource  (8 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Org | `varchar(38)` | NO |
| UID_QERResource | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### BaseTreeHasQERReuse  (16 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Org | `varchar(38)` | NO |
| UID_QERReuse | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### BaseTreeHasQERReuseUS  (6 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Org | `varchar(38)` | NO |
| UID_QERReuseUS | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### BaseTreeHasRPSReport  (141 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Org | `varchar(38)` | NO |
| UID_RPSReport | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### BaseTreeHasTSBAccountDef  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Org | `varchar(38)` | NO |
| UID_TSBAccountDef | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### BaseTreeHasUNSGroupB  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Org | `varchar(38)` | NO |
| UID_UNSGroupB | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### BaseTreeHasUNSGroupB1  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Org | `varchar(38)` | NO |
| UID_UNSGroupB1 | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### BaseTreeHasUNSGroupB2  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Org | `varchar(38)` | NO |
| UID_UNSGroupB2 | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### BaseTreeHasUNSGroupB3  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Org | `varchar(38)` | NO |
| UID_UNSGroupB3 | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### BaseTreeOwnsObject  (132 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_BaseTreeOwnsObject | `varchar(38)` | NO |
| OwnerShipInfo | `int` | YES |
| ObjectKey | `varchar(138)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| UID_Org | `varchar(38)` | NO |

### CCC_DE_Recommendations  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CCC_DE_Recommendations | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| CCC_Detail | `nvarchar(MAX)` | YES |
| CCC_Display | `nvarchar(MAX)` | YES |
| CCC_RecKey1 | `nvarchar(MAX)` | YES |
| CCC_RecKey2 | `nvarchar(MAX)` | YES |
| CCC_RecKey3 | `nvarchar(MAX)` | YES |
| CCC_Weight | `int` | YES |

### CCCStaging  (30 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CCCStaging | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| CCC_Creator | `nvarchar(64)` | YES |
| CCC_ExpirationDate | `datetime` | YES |
| CCC_ITshop | `nvarchar(64)` | YES |
| CCC_Location | `nvarchar(64)` | YES |
| CCC_Name | `nvarchar(64)` | YES |
| CCC_ExpireDateString | `nvarchar(64)` | YES |

### ComplianceArea  (1 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ComplianceArea | `varchar(38)` | NO |
| Ident_ComplianceArea | `nvarchar(64)` | YES |
| Description | `nvarchar(512)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| UID_OrgResponsible | `varchar(38)` | YES |
| XObjectKey | `varchar(138)` | NO |
| UID_ComplianceAreaParent | `varchar(38)` | YES |
| XMarkedForDeletion | `int` | YES |

### ComplianceGroup  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ComplianceGroup | `varchar(38)` | NO |
| Ident_ComplianceGroup | `nvarchar(64)` | YES |
| Description | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| UID_ComplianceGroupParent | `varchar(38)` | YES |
| XMarkedForDeletion | `int` | YES |

### ComplianceRule  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ComplianceRule | `varchar(38)` | NO |
| UID_OrgAttestator | `varchar(38)` | YES |
| UID_NonCompliance | `varchar(38)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| RuleSeverity | `float` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| UID_OrgRuler | `varchar(38)` | YES |
| isToGrantEver | `bit` | YES |
| IsExceptionAllowed | `bit` | YES |
| IsInActive | `bit` | YES |
| IsWorkingCopy | `bit` | YES |
| UID_DialogScheduleFill | `varchar(38)` | YES |
| WhereClause | `nvarchar(MAX)` | YES |
| Ident_ComplianceRule | `nvarchar(128)` | YES |
| UID_PersonLastAudit | `varchar(38)` | YES |
| DateLastAudit | `datetime` | YES |
| RemarksLastAudit | `nvarchar(MAX)` | YES |
| VersionMajor | `int` | YES |
| VersionMinor | `int` | YES |
| VersionPatch | `int` | YES |
| UID_OrgResponsible | `varchar(38)` | YES |
| ImplementationNotes | `nvarchar(MAX)` | YES |
| Description | `nvarchar(512)` | YES |
| UID_ComplianceGroup | `varchar(38)` | YES |
| RuleNumber | `nvarchar(32)` | YES |
| StateInfo | `nvarchar(16)` | YES |
| ExceptionNotes | `nvarchar(MAX)` | YES |
| UID_ComplianceRuleWork | `varchar(38)` | YES |
| WhereClauseAddOn | `nvarchar(MAX)` | YES |
| IsSimpleMode | `bit` | YES |
| WhereClausePerson | `nvarchar(MAX)` | YES |
| WhereClausePersonAddOn | `nvarchar(MAX)` | YES |
| DetectRuleTypeForPWO | `nvarchar(16)` | YES |
| UID_DialogScheduleCheck | `varchar(38)` | YES |
| RiskIndex | `float` | YES |
| TransparencyIndex | `float` | YES |
| RuleViolationThreshold | `int` | YES |
| SignificancyClass | `int` | YES |
| UID_Department | `varchar(38)` | YES |
| UID_FunctionalArea | `varchar(38)` | YES |
| RiskIndexReduced | `float` | YES |
| ExceptionMaxValidDays | `int` | YES |
| IsPersonStoreInverted | `bit` | YES |
| IsCrossPersonCheck | `bit` | YES |
| UID_DialogRichMailNewViolation | `varchar(38)` | YES |
| RiskDescription | `nvarchar(MAX)` | YES |
| RiskScope | `nvarchar(MAX)` | YES |
| RiskObjectives | `nvarchar(MAX)` | YES |
| RiskOrgMitigationCtrl | `nvarchar(MAX)` | YES |

### ComplianceRuleHasMControl  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ComplianceRule | `varchar(38)` | NO |
| UID_MitigatingControl | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### ComplianceRuleInArea  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ComplianceRule | `varchar(38)` | NO |
| UID_ComplianceArea | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### ComplianceSubRule  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ComplianceSubRule | `varchar(38)` | NO |
| UID_ComplianceRule | `varchar(38)` | YES |
| WhereClause | `nvarchar(MAX)` | YES |
| WhereClauseAddOn | `nvarchar(MAX)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| Description | `nvarchar(MAX)` | YES |
| SortOrder | `nvarchar(32)` | YES |
| XMarkedForDeletion | `int` | YES |
| CountMatchesMin | `int` | YES |

### ComplianceSubRuleObject  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ComplianceSubRuleObject | `varchar(38)` | NO |
| UID_ComplianceSubRule | `varchar(38)` | YES |
| ObjectKeyElement | `varchar(138)` | YES |
| XTouched | `nchar(1)` | YES |

### ComplianceSubRulePerson  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Person | `varchar(38)` | NO |
| UID_ComplianceRule | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |

### CSMBaseTreeHasGroup  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMGroup | `varchar(38)` | NO |
| UID_Org | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XOrigin | `int` | YES |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XIsInEffect | `bit` | YES |

### CSMBaseTreeHasGroup1  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMGroup1 | `varchar(38)` | NO |
| UID_Org | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XOrigin | `int` | YES |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XIsInEffect | `bit` | YES |

### CSMBaseTreeHasGroup2  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMGroup2 | `varchar(38)` | NO |
| UID_Org | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XOrigin | `int` | YES |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XIsInEffect | `bit` | YES |

### CSMBaseTreeHasGroup3  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMGroup3 | `varchar(38)` | NO |
| UID_Org | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XOrigin | `int` | YES |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XIsInEffect | `bit` | YES |

### CSMContainer  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMContainer | `varchar(38)` | NO |
| UID_ParentCSMContainer | `varchar(38)` | YES |
| cn | `nvarchar(64)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| ObjectGUID | `varchar(256)` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| Description | `nvarchar(MAX)` | YES |
| XMarkedForDeletion | `int` | YES |
| UID_CSMRoot | `varchar(38)` | NO |
| UID_AERoleOwner | `varchar(38)` | YES |
| ObjectKeyManager | `varchar(138)` | YES |
| LastChangeDate | `datetime` | YES |

### CSMGroup  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMGroup | `varchar(38)` | NO |
| UID_AccProduct | `varchar(38)` | YES |
| UID_CSMRoot | `varchar(38)` | NO |
| UID_CSMContainer | `varchar(38)` | YES |
| DisplayName | `nvarchar(400)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| IsForITShop | `bit` | YES |
| IsITShopOnly | `bit` | YES |
| MatchPatternForMembership | `bigint` | YES |
| RiskIndex | `float` | YES |
| CustomString01 | `nvarchar(64)` | YES |
| CustomString02 | `nvarchar(64)` | YES |
| CustomString03 | `nvarchar(64)` | YES |
| CustomString04 | `nvarchar(64)` | YES |
| CustomString05 | `nvarchar(64)` | YES |
| CustomLob01 | `nvarchar(MAX)` | YES |
| CustomLob02 | `nvarchar(MAX)` | YES |
| CustomLob03 | `nvarchar(MAX)` | YES |
| CustomLob04 | `nvarchar(MAX)` | YES |
| CustomLob05 | `nvarchar(MAX)` | YES |
| CustomDate01 | `datetime` | YES |
| CustomDate02 | `datetime` | YES |
| CustomDate03 | `datetime` | YES |
| CustomBit01 | `bit` | YES |
| CustomBit02 | `bit` | YES |
| CustomBit03 | `bit` | YES |
| CustomBit04 | `bit` | YES |
| CustomBit05 | `bit` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| cn | `nvarchar(256)` | YES |
| Description | `nvarchar(MAX)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| ObjectGUID | `varchar(256)` | YES |
| ObjectKeyManager | `varchar(138)` | YES |
| GroupType | `nvarchar(64)` | YES |
| LastChangeDate | `datetime` | YES |
| EmailAddress | `nvarchar(512)` | YES |
| GroupName | `nvarchar(128)` | YES |
| ResourceType | `nvarchar(256)` | YES |

### CSMGroup1  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMGroup1 | `varchar(38)` | NO |
| UID_AccProduct | `varchar(38)` | YES |
| UID_CSMRoot | `varchar(38)` | NO |
| UID_CSMContainer | `varchar(38)` | YES |
| DisplayName | `nvarchar(400)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| IsForITShop | `bit` | YES |
| IsITShopOnly | `bit` | YES |
| MatchPatternForMembership | `bigint` | YES |
| RiskIndex | `float` | YES |
| CustomString01 | `nvarchar(64)` | YES |
| CustomString02 | `nvarchar(64)` | YES |
| CustomString03 | `nvarchar(64)` | YES |
| CustomString04 | `nvarchar(64)` | YES |
| CustomString05 | `nvarchar(64)` | YES |
| CustomLob01 | `nvarchar(MAX)` | YES |
| CustomLob02 | `nvarchar(MAX)` | YES |
| CustomLob03 | `nvarchar(MAX)` | YES |
| CustomLob04 | `nvarchar(MAX)` | YES |
| CustomLob05 | `nvarchar(MAX)` | YES |
| CustomDate01 | `datetime` | YES |
| CustomDate02 | `datetime` | YES |
| CustomDate03 | `datetime` | YES |
| CustomBit01 | `bit` | YES |
| CustomBit02 | `bit` | YES |
| CustomBit03 | `bit` | YES |
| CustomBit04 | `bit` | YES |
| CustomBit05 | `bit` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| cn | `nvarchar(256)` | YES |
| Description | `nvarchar(MAX)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| ObjectGUID | `varchar(256)` | YES |
| ObjectKeyManager | `varchar(138)` | YES |
| GroupType | `nvarchar(64)` | YES |
| LastChangeDate | `datetime` | YES |
| EmailAddress | `nvarchar(512)` | YES |
| GroupName | `nvarchar(128)` | YES |
| ResourceType | `nvarchar(256)` | YES |

### CSMGroup1Collection  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMGroup1Container | `varchar(38)` | NO |
| UID_CSMGroup1Member | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| LevelNumber | `int` | YES |
| IsCircular | `bit` | YES |
| XMarkedForDeletion | `int` | YES |

### CSMGroup1Exclusion  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMGroup1Lower | `varchar(38)` | NO |
| UID_CSMGroup1Higher | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |

### CSMGroup1InGroup1  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMGroup1Container | `varchar(38)` | NO |
| UID_CSMGroup1Member | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### CSMGroup2  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMGroup2 | `varchar(38)` | NO |
| UID_AccProduct | `varchar(38)` | YES |
| UID_CSMRoot | `varchar(38)` | NO |
| UID_CSMContainer | `varchar(38)` | YES |
| DisplayName | `nvarchar(400)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| IsForITShop | `bit` | YES |
| IsITShopOnly | `bit` | YES |
| MatchPatternForMembership | `bigint` | YES |
| RiskIndex | `float` | YES |
| CustomString01 | `nvarchar(64)` | YES |
| CustomString02 | `nvarchar(64)` | YES |
| CustomString03 | `nvarchar(64)` | YES |
| CustomString04 | `nvarchar(64)` | YES |
| CustomString05 | `nvarchar(64)` | YES |
| CustomLob01 | `nvarchar(MAX)` | YES |
| CustomLob02 | `nvarchar(MAX)` | YES |
| CustomLob03 | `nvarchar(MAX)` | YES |
| CustomLob04 | `nvarchar(MAX)` | YES |
| CustomLob05 | `nvarchar(MAX)` | YES |
| CustomDate01 | `datetime` | YES |
| CustomDate02 | `datetime` | YES |
| CustomDate03 | `datetime` | YES |
| CustomBit01 | `bit` | YES |
| CustomBit02 | `bit` | YES |
| CustomBit03 | `bit` | YES |
| CustomBit04 | `bit` | YES |
| CustomBit05 | `bit` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| cn | `nvarchar(256)` | YES |
| Description | `nvarchar(MAX)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| ObjectGUID | `varchar(256)` | YES |
| ObjectKeyManager | `varchar(138)` | YES |
| GroupType | `nvarchar(64)` | YES |
| LastChangeDate | `datetime` | YES |
| EmailAddress | `nvarchar(512)` | YES |
| GroupName | `nvarchar(128)` | YES |
| ResourceType | `nvarchar(256)` | YES |

### CSMGroup2Collection  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMGroup2Container | `varchar(38)` | NO |
| UID_CSMGroup2Member | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| LevelNumber | `int` | YES |
| IsCircular | `bit` | YES |
| XMarkedForDeletion | `int` | YES |

### CSMGroup2Exclusion  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMGroup2Lower | `varchar(38)` | NO |
| UID_CSMGroup2Higher | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |

### CSMGroup2InGroup2  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMGroup2Container | `varchar(38)` | NO |
| UID_CSMGroup2Member | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### CSMGroup3  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMGroup3 | `varchar(38)` | NO |
| UID_AccProduct | `varchar(38)` | YES |
| UID_CSMRoot | `varchar(38)` | NO |
| UID_CSMContainer | `varchar(38)` | YES |
| DisplayName | `nvarchar(400)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| IsForITShop | `bit` | YES |
| IsITShopOnly | `bit` | YES |
| MatchPatternForMembership | `bigint` | YES |
| RiskIndex | `float` | YES |
| CustomString01 | `nvarchar(64)` | YES |
| CustomString02 | `nvarchar(64)` | YES |
| CustomString03 | `nvarchar(64)` | YES |
| CustomString04 | `nvarchar(64)` | YES |
| CustomString05 | `nvarchar(64)` | YES |
| CustomLob01 | `nvarchar(MAX)` | YES |
| CustomLob02 | `nvarchar(MAX)` | YES |
| CustomLob03 | `nvarchar(MAX)` | YES |
| CustomLob04 | `nvarchar(MAX)` | YES |
| CustomLob05 | `nvarchar(MAX)` | YES |
| CustomDate01 | `datetime` | YES |
| CustomDate02 | `datetime` | YES |
| CustomDate03 | `datetime` | YES |
| CustomBit01 | `bit` | YES |
| CustomBit02 | `bit` | YES |
| CustomBit03 | `bit` | YES |
| CustomBit04 | `bit` | YES |
| CustomBit05 | `bit` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| cn | `nvarchar(256)` | YES |
| Description | `nvarchar(MAX)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| ObjectGUID | `varchar(256)` | YES |
| ObjectKeyManager | `varchar(138)` | YES |
| GroupType | `nvarchar(64)` | YES |
| LastChangeDate | `datetime` | YES |
| EmailAddress | `nvarchar(512)` | YES |
| GroupName | `nvarchar(128)` | YES |
| ResourceType | `nvarchar(256)` | YES |

### CSMGroup3Collection  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMGroup3Container | `varchar(38)` | NO |
| UID_CSMGroup3Member | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| LevelNumber | `int` | YES |
| IsCircular | `bit` | YES |
| XMarkedForDeletion | `int` | YES |

### CSMGroup3Exclusion  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMGroup3Lower | `varchar(38)` | NO |
| UID_CSMGroup3Higher | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |

### CSMGroup3InGroup3  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMGroup3Container | `varchar(38)` | NO |
| UID_CSMGroup3Member | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### CSMGroupCollection  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMGroupContainer | `varchar(38)` | NO |
| UID_CSMGroupMember | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| LevelNumber | `int` | YES |
| IsCircular | `bit` | YES |
| XMarkedForDeletion | `int` | YES |

### CSMGroupExclusion  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMGroupLower | `varchar(38)` | NO |
| UID_CSMGroupHigher | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |

### CSMGroupHasItem  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMItem | `varchar(38)` | NO |
| UID_CSMGroup | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |

### CSMGroupInGroup  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMGroupContainer | `varchar(38)` | NO |
| UID_CSMGroupMember | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### CSMItem  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMItem | `varchar(38)` | NO |
| UID_CSMRoot | `varchar(38)` | NO |
| Ident_CSMItem | `nvarchar(128)` | YES |
| Description | `nvarchar(MAX)` | YES |
| ItemType | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| CustomString01 | `nvarchar(64)` | YES |
| CustomString02 | `nvarchar(64)` | YES |
| CustomString03 | `nvarchar(64)` | YES |
| CustomString04 | `nvarchar(64)` | YES |
| CustomString05 | `nvarchar(64)` | YES |
| CustomLob01 | `nvarchar(MAX)` | YES |
| CustomLob02 | `nvarchar(MAX)` | YES |
| CustomLob03 | `nvarchar(MAX)` | YES |
| CustomLob04 | `nvarchar(MAX)` | YES |
| CustomLob05 | `nvarchar(MAX)` | YES |
| CustomDate01 | `datetime` | YES |
| CustomDate02 | `datetime` | YES |
| CustomDate03 | `datetime` | YES |
| CustomBit01 | `bit` | YES |
| CustomBit02 | `bit` | YES |
| CustomBit03 | `bit` | YES |
| CustomBit04 | `bit` | YES |
| CustomBit05 | `bit` | YES |
| LastChangeDate | `datetime` | YES |

### CSMRoot  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMRoot | `varchar(38)` | NO |
| IsUCIOffPrem | `bit` | YES |
| Ident_CSMRoot | `nvarchar(256)` | YES |
| DisplayName | `nvarchar(400)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| UID_TSBAccountDef | `varchar(38)` | YES |
| NamespaceManagedBy | `nvarchar(16)` | YES |
| UID_AERoleOwner | `varchar(38)` | YES |
| AccountToPersonMatchingRule | `nvarchar(MAX)` | YES |
| MatchPatternDisplay | `nvarchar(MAX)` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| Description | `nvarchar(MAX)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| AlternatePropertyCaptions | `nvarchar(MAX)` | YES |
| IsManualProvisioning | `bit` | YES |
| IsNoUserDelete | `bit` | YES |
| GroupUsageMask | `int` | YES |
| UserContainsGroupList | `int` | YES |
| DeleteDelayDays | `int` | YES |

### CSMUser  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMUser | `varchar(38)` | NO |
| UID_CSMRoot | `varchar(38)` | NO |
| DisplayName | `nvarchar(400)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| MatchPatternForMembership | `bigint` | YES |
| IsPrivilegedAccount | `bit` | YES |
| RiskIndexCalculated | `float` | YES |
| UID_Person | `varchar(38)` | YES |
| UID_TSBAccountDef | `varchar(38)` | YES |
| UID_TSBBehavior | `varchar(38)` | YES |
| IsGroupAccount | `bit` | YES |
| AccountDisabled | `bit` | YES |
| AccountExpires | `datetime` | YES |
| AccountName | `nvarchar(256)` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| cn | `nvarchar(256)` | YES |
| Description | `nvarchar(MAX)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| FirstName | `nvarchar(64)` | YES |
| LastLogon | `datetime` | YES |
| LastName | `nvarchar(64)` | YES |
| ObjectGUID | `varchar(256)` | YES |
| Password | `varchar(990)` | YES |
| PWDLastSet | `datetime` | YES |
| UID_CSMContainer | `varchar(38)` | YES |
| CustomString01 | `nvarchar(64)` | YES |
| CustomString02 | `nvarchar(64)` | YES |
| CustomString03 | `nvarchar(64)` | YES |
| CustomString04 | `nvarchar(64)` | YES |
| CustomString05 | `nvarchar(64)` | YES |
| CustomLob01 | `nvarchar(MAX)` | YES |
| CustomLob02 | `nvarchar(MAX)` | YES |
| CustomLob03 | `nvarchar(MAX)` | YES |
| CustomLob04 | `nvarchar(MAX)` | YES |
| CustomLob05 | `nvarchar(MAX)` | YES |
| CustomDate01 | `datetime` | YES |
| CustomDate02 | `datetime` | YES |
| CustomDate03 | `datetime` | YES |
| CustomBit01 | `bit` | YES |
| CustomBit02 | `bit` | YES |
| CustomBit03 | `bit` | YES |
| CustomBit04 | `bit` | YES |
| CustomBit05 | `bit` | YES |
| EmailAddress | `nvarchar(256)` | YES |
| Alias | `nvarchar(64)` | YES |
| EmailEncoding | `nvarchar(64)` | YES |
| UID_CSMGroupPrimary | `varchar(38)` | YES |
| UID_CSMGroupPrimary2 | `varchar(38)` | YES |
| UID_DialogCulture | `varchar(38)` | YES |
| Nickname | `nvarchar(64)` | YES |
| ObjectKeyManager | `varchar(138)` | YES |
| Department | `nvarchar(128)` | YES |
| City | `nvarchar(64)` | YES |
| ZIPCode | `nvarchar(16)` | YES |
| Street | `nvarchar(MAX)` | YES |
| PostOfficeBox | `nvarchar(64)` | YES |
| Room | `nvarchar(64)` | YES |
| Phone | `nvarchar(64)` | YES |
| Mobile | `nvarchar(64)` | YES |
| EmployeeNumber | `nvarchar(64)` | YES |
| EmployeeType | `nvarchar(256)` | YES |
| Initials | `nvarchar(10)` | YES |
| Homepage | `nvarchar(1024)` | YES |
| UID_DialogTimeZone | `varchar(38)` | YES |
| Salutation | `nvarchar(64)` | YES |
| Title | `nvarchar(256)` | YES |
| FullName | `nvarchar(256)` | YES |
| NameAddOn | `nvarchar(16)` | YES |
| UID_DialogCountry | `varchar(38)` | YES |
| UID_DialogState | `varchar(38)` | YES |
| LastChangeDate | `datetime` | YES |
| Division | `nvarchar(256)` | YES |
| Organization | `nvarchar(256)` | YES |
| FormattedAddress | `nvarchar(1024)` | YES |
| ResourceType | `nvarchar(256)` | YES |
| IdentityType | `varchar(32)` | YES |
| NeverConnectToPerson | `int` | YES |
| IsGroupAccount_CSMGroup | `bit` | YES |
| IsGroupAccount_CSMGroup1 | `bit` | YES |
| IsGroupAccount_CSMGroup2 | `bit` | YES |
| IsGroupAccount_CSMGroup3 | `bit` | YES |
| IsNeverConnectManual | `bit` | YES |

### CSMUserHasGroup  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMGroup | `varchar(38)` | NO |
| UID_CSMUser | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XIsInEffect | `bit` | YES |
| XOrigin | `int` | YES |
| RiskIndexCalculated | `float` | YES |

### CSMUserHasGroup1  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMUser | `varchar(38)` | NO |
| UID_CSMGroup1 | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XIsInEffect | `bit` | YES |
| XOrigin | `int` | YES |
| RiskIndexCalculated | `float` | YES |

### CSMUserHasGroup2  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMUser | `varchar(38)` | NO |
| UID_CSMGroup2 | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XIsInEffect | `bit` | YES |
| XOrigin | `int` | YES |
| RiskIndexCalculated | `float` | YES |

### CSMUserHasGroup3  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMUser | `varchar(38)` | NO |
| UID_CSMGroup3 | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XIsInEffect | `bit` | YES |
| XOrigin | `int` | YES |
| RiskIndexCalculated | `float` | YES |

### CSMUserHasItem  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMUser | `varchar(38)` | NO |
| UID_CSMItem | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |

### CSMUserInGroup  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMGroup | `varchar(38)` | NO |
| UID_CSMUser | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XIsInEffect | `bit` | YES |
| XOrigin | `int` | YES |
| RiskIndexCalculated | `float` | YES |

### CSMUserInGroup1  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMUser | `varchar(38)` | NO |
| UID_CSMGroup1 | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XIsInEffect | `bit` | YES |
| XOrigin | `int` | YES |
| RiskIndexCalculated | `float` | YES |

### CSMUserInGroup2  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMUser | `varchar(38)` | NO |
| UID_CSMGroup2 | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XIsInEffect | `bit` | YES |
| XOrigin | `int` | YES |
| RiskIndexCalculated | `float` | YES |

### CSMUserInGroup3  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_CSMUser | `varchar(38)` | NO |
| UID_CSMGroup3 | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XIsInEffect | `bit` | YES |
| XOrigin | `int` | YES |
| RiskIndexCalculated | `float` | YES |

### Delegation  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Delegation | `varchar(38)` | NO |
| UID_PersonReceiver | `varchar(38)` | NO |
| UID_PersonSender | `varchar(38)` | NO |
| UID_PersonWantsOrg | `varchar(38)` | NO |
| ObjectKeyDelegated | `varchar(138)` | NO |
| IsDelegable | `bit` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| KeepMeInformed | `bit` | YES |
| OrderState | `nvarchar(16)` | YES |
| XMarkedForDeletion | `int` | YES |

### DialogAEDS  (1,231 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogAEDS | `varchar(38)` | NO |
| FileName | `nvarchar(512)` | YES |
| CustomCode | `nvarchar(MAX)` | YES |
| Description | `nvarchar(1024)` | YES |
| XDateInserted | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| ObjectType | `nchar(2)` | YES |
| Configuration | `nvarchar(MAX)` | YES |
| SubObjectType | `nchar(30)` | YES |
| CustomConfiguration | `nvarchar(MAX)` | YES |
| UID_DialogProduct | `varchar(38)` | YES |
| XMarkedForDeletion | `int` | YES |
| UID_DialogAEDSParent | `varchar(38)` | YES |

### DialogAuthentifier  (26 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogAuthentifier | `varchar(38)` | NO |
| Ident_DialogAuthentifier | `nvarchar(64)` | YES |
| AssemblyName | `nvarchar(255)` | YES |
| Class | `nvarchar(255)` | YES |
| IsEnabled | `bit` | YES |
| InitialData | `nvarchar(1024)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| ShowInInterface | `bit` | YES |
| Caption | `nvarchar(64)` | YES |
| SortOrder | `int` | YES |
| XObjectKey | `varchar(138)` | NO |
| IsForSingleSignOn | `bit` | YES |
| AuthenticationType | `nvarchar(64)` | YES |
| XMarkedForDeletion | `int` | YES |

### DialogCalendar  (3,653 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogCalendar | `varchar(38)` | NO |
| CalendarYear | `int` | YES |
| CalendarQuarter | `int` | YES |
| CalendarMonth | `int` | YES |
| CalendarDay | `int` | YES |
| isYear | `bit` | YES |
| isQuarter | `bit` | YES |
| isMonth | `bit` | YES |
| DayOfWeek | `nvarchar(32)` | YES |
| DayOfYear | `int` | YES |
| WeekOfYear | `int` | YES |
| isWeek | `bit` | YES |
| CustomProperty01 | `nvarchar(64)` | YES |
| CustomProperty02 | `nvarchar(64)` | YES |
| CustomProperty03 | `nvarchar(64)` | YES |
| CustomProperty04 | `nvarchar(64)` | YES |
| CustomProperty05 | `nvarchar(64)` | YES |
| IsoDate | `nvarchar(10)` | YES |
| DisplayMonth | `nvarchar(32)` | YES |

### DialogColumn  (14,768 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogColumn | `varchar(38)` | NO |
| IndexWeight | `float` | YES |
| ColumnName | `varchar(30)` | NO |
| MinLen | `int` | YES |
| MaxLen | `int` | YES |
| Format | `int` | YES |
| DataType | `int` | YES |
| Template | `nvarchar(MAX)` | YES |
| IsOverwritingTemplate | `bit` | YES |
| FormatScript | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| IsPKMember | `bit` | YES |
| IsAlternatePKMember | `bit` | YES |
| IsToWatch | `bit` | YES |
| IsUID | `bit` | YES |
| CustomComment | `nvarchar(MAX)` | YES |
| IsNoCustomAllowed | `bit` | YES |
| HasDefaultValue | `bit` | YES |
| IsCrypted | `bit` | YES |
| XTouched | `nchar(1)` | YES |
| Caption | `nvarchar(256)` | YES |
| PreProcessorCondition | `nvarchar(255)` | YES |
| IsDeactivatedByPreProcessor | `bit` | YES |
| UID_BaseColumn | `varchar(38)` | YES |
| IsMultiValued | `bit` | YES |
| SyntaxType | `nvarchar(64)` | YES |
| CountDigits | `int` | YES |
| IsToIgnoreOnExport | `bit` | YES |
| IsToIgnoreOnImport | `bit` | YES |
| isSPML | `bit` | YES |
| IsTemplateChanged | `bit` | YES |
| SortOrder | `int` | YES |
| XObjectKey | `varchar(138)` | NO |
| IsFilterDesignerEnabled | `bit` | YES |
| ColumnGroup | `nvarchar(MAX)` | YES |
| IsParentConnectColumn | `bit` | YES |
| IsDynamicFK | `bit` | YES |
| UID_DialogColumnUnionView | `varchar(38)` | YES |
| isMultilineContent | `bit` | YES |
| TemplateLimitationInternal | `int` | YES |
| TemplateLimitationException | `int` | YES |
| isBlobExternal | `bit` | YES |
| AVGDataLenByte | `int` | YES |
| IsDescriptionColumn | `bit` | YES |
| IsHierarchyDisplay | `bit` | YES |
| IsNoAutoExtendPermissions | `bit` | YES |
| IsToWatchDelete | `bit` | YES |
| SchemaDataType | `nvarchar(64)` | YES |
| SchemaDataLen | `int` | YES |
| IsCustomConfigurable | `bit` | YES |
| UID_DialogTable | `varchar(38)` | NO |
| IsNoTransfer | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| IsForeignKey | `bit` | YES |
| MultiLanguageFlag | `int` | YES |
| Commentary | `nvarchar(1024)` | YES |
| IsNoAutoTrim | `bit` | YES |
| DoNotLogChanges | `bit` | YES |
| DateTimeDetail | `int` | YES |
| IsMAllKeyMember | `bit` | YES |
| SplittedLookupSupport | `varchar(16)` | YES |
| IsElementProperty | `bit` | YES |
| CanSeeScript | `nvarchar(MAX)` | YES |
| CanEditScript | `nvarchar(MAX)` | YES |
| HasLimitedValues | `bit` | YES |
| DisallowCustomLimitedValues | `bit` | YES |
| HasBitMaskConfig | `bit` | YES |
| DisallowCustomBitMaskConfig | `bit` | YES |
| BitMaskConfigOrder | `int` | YES |
| MultiValueSpecification | `int` | YES |
| ResultSortOrder | `int` | YES |
| CacheInfo | `int` | YES |
| SystemSyncDirection | `int` | YES |
| SyncInfo | `int` | YES |

### DialogColumnBulkDependencies  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogColumn | `varchar(38)` | NO |
| UID_QBMColumnBulkDepend | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| ObjectKeyDialogColumnPrior | `varchar(138)` | NO |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |

### DialogColumnGroupRight  (81,156 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogColumn | `varchar(38)` | NO |
| UID_DialogGroup | `varchar(38)` | NO |
| CanSee | `bit` | YES |
| CanEdit | `bit` | YES |
| CanInsert | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### DialogColumnHasSemaphor  (769 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogColumn | `varchar(38)` | NO |
| UID_DialogSemaphor | `varchar(38)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### DialogConfigParm  (774 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ConfigParm | `varchar(38)` | NO |
| ConfigParm | `nvarchar(64)` | NO |
| Value | `nvarchar(1024)` | NO |
| Enabled | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| UID_ParentConfigparm | `varchar(38)` | YES |
| FullPath | `nvarchar(256)` | NO |
| XTouched | `nchar(1)` | YES |
| IsPreprocessorCondition | `bit` | YES |
| IsCrypted | `bit` | YES |
| Description | `nvarchar(1024)` | YES |
| XObjectKey | `varchar(138)` | NO |
| DisplayName | `nvarchar(256)` | YES |
| SortOrder | `int` | YES |
| IsEnabledResulting | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| UID_QBMClrTypeEditor | `varchar(38)` | YES |

### DialogConfigParmOption  (545 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogConfigParmOption | `varchar(38)` | NO |
| UID_ConfigParm | `varchar(38)` | NO |
| OptionValue | `nvarchar(1024)` | YES |
| Description | `nvarchar(255)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| PreProcessorString | `nvarchar(64)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### DialogCountry  (251 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogCountry | `varchar(38)` | NO |
| NumericCode | `nvarchar(3)` | YES |
| Iso3166_2 | `nvarchar(2)` | YES |
| Iso3166_3 | `nvarchar(3)` | YES |
| CountryName | `nvarchar(64)` | YES |
| Description | `nvarchar(64)` | YES |
| LDAPObjectClass | `nvarchar(256)` | YES |
| LDAPSearchGuide | `nvarchar(256)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| IsInUse | `bit` | YES |
| Car | `nvarchar(16)` | YES |
| Telephone | `nvarchar(16)` | YES |
| AVGUTCOffset | `int` | YES |
| DefaultWorkingHours | `varchar(168)` | YES |
| IsDayLightSaving | `bit` | YES |
| NationalCountryName | `nvarchar(64)` | YES |
| CapitalName | `nvarchar(64)` | YES |
| NationalCapitalName | `nvarchar(64)` | YES |
| XMarkedForDeletion | `int` | YES |
| IsHistorical | `bit` | YES |

### DialogCountryHasCulture  (296 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogCountry | `varchar(38)` | NO |
| UID_DialogCulture | `varchar(38)` | NO |
| SortOrder | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### DialogCountryHasTimeZone  (755 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogTimeZone | `varchar(38)` | NO |
| UID_DialogCountry | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### DialogCountryHoliday  (14,235 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogCountryHoliday | `varchar(38)` | NO |
| UID_DialogCountry | `varchar(38)` | NO |
| IsoDate | `nvarchar(10)` | NO |
| XDateInserted | `datetime` | YES |
| Ident_DialogCountryHoliday | `nvarchar(64)` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| NationalHolidayName | `nvarchar(64)` | YES |
| XMarkedForDeletion | `int` | YES |
| IsToIgnore | `bit` | YES |

### DialogCustomizer  (289 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Customizer | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| SortOrder | `int` | YES |
| UID_QBMClrType | `varchar(38)` | YES |
| Description | `nvarchar(512)` | YES |
| PreProcessorCondition | `nvarchar(256)` | YES |
| IsDeactivatedByPreProcessor | `bit` | YES |

### DialogDashBoardContent  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogDashBoardContent | `varchar(38)` | NO |
| UID_DialogDashBoardDef | `varchar(38)` | YES |
| ElementName | `nvarchar(255)` | YES |
| ElementValue | `float` | YES |
| ElementValue100 | `float` | YES |
| ElementDate | `datetime` | YES |
| HistoryNumber | `int` | YES |
| ElementOrder | `int` | YES |
| ElementObjectKey | `varchar(138)` | YES |
| ElementValueZ | `float` | YES |
| ElementObjectKey2 | `varchar(138)` | YES |

### DialogDashBoardDef  (330 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogDashBoardDef | `varchar(38)` | NO |
| UID_DialogSchedule | `varchar(38)` | YES |
| Ident_DialogDashboardDef | `nvarchar(128)` | YES |
| DisplayName | `nvarchar(255)` | YES |
| QueryDefinition | `nvarchar(MAX)` | YES |
| QueryDefinition100 | `nvarchar(MAX)` | YES |
| GreenLimit | `float` | YES |
| RedLimit | `float` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| IsInActive | `bit` | YES |
| Description | `nvarchar(1024)` | YES |
| DisplayUnit | `nvarchar(32)` | YES |
| HistoryLength | `int` | YES |
| TimeScaleUnit | `nvarchar(16)` | YES |
| AccessWhereClause | `nvarchar(MAX)` | YES |
| AggregateFunction | `nvarchar(16)` | YES |
| AggregateFunction100 | `nvarchar(16)` | YES |
| PreProcessorCondition | `nvarchar(255)` | YES |
| IsDeactivatedByPreProcessor | `bit` | YES |
| IsAdHoc | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| IsManual | `bit` | YES |
| DashBoardType | `nvarchar(32)` | YES |

### DialogDatabase  (1 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Database | `varchar(38)` | NO |
| LastMigrationDate | `datetime` | YES |
| CustomerPrefix | `nvarchar(6)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| IsDBSchedulerDisabled | `bit` | YES |
| IsJobServiceDisabled | `bit` | YES |
| DataOrigin | `int` | YES |
| FESimulationStarted | `datetime` | YES |
| Description | `nvarchar(255)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| IsMainDatabase | `bit` | YES |
| UID_DialogAuthentifier | `varchar(38)` | YES |
| PublicKey | `varchar(671)` | YES |
| ConnectionProvider | `nvarchar(255)` | YES |
| CustomerName | `nvarchar(256)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| ConnectionString | `nvarchar(MAX)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| UID_DialogCultureDefault | `varchar(38)` | YES |
| ModuleOwner | `varchar(3)` | YES |
| XMarkedForDeletion | `int` | YES |
| ElementColor | `nvarchar(16)` | YES |
| ProductionLevel | `int` | YES |
| SingleUserProcess | `int` | YES |
| SingleUserStart | `datetime` | YES |
| EditionName | `varchar(3)` | YES |
| EditionVersion | `nvarchar(64)` | YES |
| EditionDescription | `nvarchar(MAX)` | YES |
| ProductionLevelAddOn | `varchar(16)` | YES |
| LicenceID | `varchar(16)` | YES |
| UpdatePhase | `int` | YES |
| UID_DialogCountryDefault | `varchar(38)` | YES |
| UID_CutOffTask | `varchar(38)` | YES |

### DialogDBQueue  (18 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogDBQueue | `varchar(38)` | NO |
| UID_Task | `varchar(38)` | YES |
| Object | `varchar(38)` | YES |
| SubObject | `varchar(38)` | YES |
| XTouched | `nchar(1)` | YES |
| GenProcID | `varchar(38)` | NO |
| Generation | `int` | YES |
| PathLength | `int` | YES |

### DialogDeferredOperation  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogDeferredOperation | `varchar(38)` | NO |
| ObjectKey | `varchar(138)` | YES |
| Operation | `nvarchar(32)` | YES |
| ObjectState | `nvarchar(MAX)` | YES |
| TargetDate | `datetime` | YES |
| UserInformation | `nvarchar(512)` | YES |
| GenProcID | `varchar(38)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| DisplayValue | `nvarchar(255)` | YES |
| UID_OperationRoot | `varchar(38)` | YES |
| Description | `nvarchar(MAX)` | YES |
| XObjectKey | `varchar(138)` | NO |

### DialogDeferredOperationColumn  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogDeferredOperation | `varchar(38)` | NO |
| UID_DialogColumn | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |

### DialogGroup  (163 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogGroup | `varchar(38)` | NO |
| GroupName | `nvarchar(64)` | NO |
| Description | `nvarchar(255)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| CustomRemarks | `nvarchar(255)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| PreProcessorCondition | `nvarchar(255)` | YES |
| IsDeactivatedByPreProcessor | `bit` | YES |
| GroupNumber | `int` | YES |
| GroupBitPattern | `varbinary` | YES |
| XMarkedForDeletion | `int` | YES |
| IsRoleBasedOnly | `bit` | YES |

### DialogGroupCollection  (345 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogGroup | `varchar(38)` | NO |
| UID_DialogGroupParent | `varchar(38)` | NO |

### DialogGroupHasAEDS  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogAEDS | `varchar(38)` | NO |
| UID_DialogGroup | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### DialogGroupHasFeature  (242 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogGroup | `varchar(38)` | NO |
| UID_DialogFeature | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### DialogGroupHasMethod  (174 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogMethod | `varchar(38)` | NO |
| UID_DialogGroup | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### DialogGroupHasSheet  (3,730 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogSheet | `varchar(38)` | NO |
| UID_DialogGroup | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### DialogGroupInGroup  (99 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogGroupChild | `varchar(38)` | NO |
| UID_DialogGroupParent | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### DialogGroupInProductLimited  (11 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogProduct | `varchar(38)` | NO |
| UID_DialogGroup | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### DialogHistoryDB  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogHistoryDB | `varchar(38)` | NO |
| ConnectionString | `varchar(990)` | YES |
| DisplayName | `nvarchar(255)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| IsInActive | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| TransportConnectionString | `varchar(MAX)` | YES |
| IsTransportTarget | `bit` | YES |

### DialogImage  (214 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogImage | `varchar(38)` | NO |
| ImageName | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| ContentNormal16 | `varbinary` | YES |
| ContentNormal24 | `varbinary` | YES |
| XObjectKey | `varchar(138)` | NO |
| ContentNormal32 | `varbinary` | YES |
| XMarkedForDeletion | `int` | YES |
| ContentInactive16 | `varbinary` | YES |
| ContentInvert16 | `varbinary` | YES |
| ContentInactive24 | `varbinary` | YES |
| ContentInvert24 | `varbinary` | YES |
| ContentInactive32 | `varbinary` | YES |
| ContentInvert32 | `varbinary` | YES |

### DialogJournal  (690 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogJournal | `varchar(38)` | NO |
| MessageType | `nchar(1)` | YES |
| MessageString | `nvarchar(MAX)` | YES |
| MessageDate | `datetime` | YES |
| ApplicationName | `nvarchar(64)` | YES |
| LogonUser | `nvarchar(64)` | YES |
| HostName | `nvarchar(64)` | YES |

### DialogLargeImage  (1 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogLargeImage | `varchar(38)` | NO |
| Ident_DialogLargeImage | `nvarchar(64)` | YES |
| ContentLarge | `varbinary` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### DialogLogicalForm  (705 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogLogicalForm | `varchar(38)` | NO |
| LogicalFormName | `nvarchar(64)` | YES |
| UID_DialogPhysicalForm | `varchar(38)` | NO |
| DialogFormDefinition | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| UID_DialogLogicalFormRoot | `varchar(38)` | YES |
| Description | `nvarchar(512)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### DialogLogicalFormHasTable  (742 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogLogicalForm | `varchar(38)` | NO |
| UID_DialogTable | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### DialogMailNoSubscription  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogMailNoSubscription | `varchar(38)` | NO |
| UID_DialogRichMail | `varchar(38)` | NO |
| SMTPAddress | `nvarchar(256)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### DialogMethod  (44 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogMethod | `varchar(38)` | NO |
| UID_DialogImage | `varchar(38)` | YES |
| MethodName | `nvarchar(64)` | NO |
| MethodScript | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| Caption | `nvarchar(256)` | YES |
| MethodEnabledFor | `int` | YES |
| IsDeactivated | `bit` | YES |
| XObjectKey | `varchar(138)` | NO |
| Description | `nvarchar(512)` | YES |
| MethodBehavior | `int` | YES |
| XMarkedForDeletion | `int` | YES |
| IsVisibleScript | `nvarchar(MAX)` | YES |

### DialogMultiLanguage  (51,142 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogMultiLanguage | `varchar(38)` | NO |
| EntryKey | `nvarchar(1024)` | NO |
| UID_DialogColumn | `varchar(38)` | NO |
| EntryValue | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| IsRevisited | `bit` | YES |
| XObjectKey | `varchar(138)` | NO |
| UID_DialogCulture | `varchar(38)` | NO |
| XMarkedForDeletion | `int` | YES |
| SourceType | `nvarchar(16)` | YES |
| SourceDetail | `nvarchar(1024)` | YES |

### DialogNextID  (2 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogNextID | `varchar(38)` | NO |
| Ident_DialogNextID | `nvarchar(64)` | NO |
| NextNumber | `int` | YES |
| XTouched | `nchar(1)` | YES |

### DialogNotification  (2,069 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogNotification | `varchar(38)` | NO |
| UID_DialogColumnSubscriber | `varchar(38)` | NO |
| UID_DialogColumnSender | `varchar(38)` | NO |
| WhereClause | `nvarchar(MAX)` | YES |
| XTouched | `nchar(1)` | YES |
| NotificationType | `int` | YES |

### DialogObject  (1,252 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogObject | `varchar(38)` | NO |
| UID_DialogImage | `varchar(38)` | YES |
| ObjectName | `nvarchar(64)` | NO |
| SelectScript | `nvarchar(MAX)` | YES |
| OrderNumber | `int` | YES |
| WhereClause | `nvarchar(1024)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| InsertValues | `nvarchar(MAX)` | YES |
| DisplayName | `nvarchar(128)` | YES |
| CustomRemarks | `nvarchar(255)` | YES |
| DisplayPattern | `nvarchar(255)` | YES |
| IsExclusive | `bit` | YES |
| XTouched | `nchar(1)` | YES |
| CaptionResult | `nvarchar(128)` | YES |
| CaptionForm | `nvarchar(128)` | YES |
| PreProcessorCondition | `nvarchar(255)` | YES |
| IsDeactivatedByPreProcessor | `bit` | YES |
| XObjectKey | `varchar(138)` | NO |
| ElementColor | `nvarchar(16)` | YES |
| UID_DialogTable | `varchar(38)` | NO |
| XMarkedForDeletion | `int` | YES |

### DialogObjectHasMethod  (87 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogMethod | `varchar(38)` | NO |
| UID_DialogObject | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### DialogObjectHasSheet  (1,303 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogObject | `varchar(38)` | NO |
| UID_DialogSheet | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### DialogParameter  (391 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogParameter | `varchar(38)` | NO |
| UID_DialogColumnQuery | `varchar(38)` | YES |
| UID_DialogParameterSet | `varchar(38)` | NO |
| ParameterName | `nvarchar(255)` | NO |
| ParameterType | `nvarchar(32)` | YES |
| DisplayName | `nvarchar(256)` | YES |
| ParameterValue | `nvarchar(MAX)` | YES |
| DefaultValue | `nvarchar(MAX)` | YES |
| ExampleValue | `nvarchar(MAX)` | YES |
| DataType | `int` | YES |
| IsMandatory | `int` | YES |
| IsVisibleForChildren | `int` | YES |
| IsOverridable | `int` | YES |
| DataSourceType | `varchar(16)` | YES |
| LimitedValues | `nvarchar(MAX)` | YES |
| QueryWhereClause | `nvarchar(MAX)` | YES |
| SortOrder | `nvarchar(16)` | YES |
| ValidationScript | `nvarchar(MAX)` | YES |
| UID_DialogColumnCalculate | `varchar(38)` | YES |
| ValueScript | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| IsEmptyValueOverrides | `bit` | YES |
| IsMultiValue | `int` | YES |
| IsMultiLine | `int` | YES |
| CalculateWhereClause | `nvarchar(MAX)` | YES |
| IsRange | `int` | YES |
| UsePredefinedRange | `int` | YES |
| DisplayForParameterValue | `nvarchar(1024)` | YES |
| XMarkedForDeletion | `int` | YES |
| Description | `nvarchar(1024)` | YES |
| DataDisplayPattern | `nvarchar(512)` | YES |
| DateTimeDetail | `int` | YES |
| OnPropertyChangedScript | `nvarchar(MAX)` | YES |
| QueryDisplayType | `int` | YES |

### DialogParameterSet  (205 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogParameterSet | `varchar(38)` | NO |
| UID_DialogParameterSetParent | `varchar(38)` | YES |
| Description | `nvarchar(MAX)` | YES |
| DisplayName | `nvarchar(256)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| ObjectKeyUsedBy | `varchar(138)` | NO |
| Category | `nvarchar(64)` | YES |
| XMarkedForDeletion | `int` | YES |

### DialogPhysicalForm  (228 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogPhysicalForm | `varchar(38)` | NO |
| FormName | `nvarchar(255)` | YES |
| FileName | `nvarchar(255)` | YES |
| FormEnabledFor | `int` | YES |
| FormType | `nchar(1)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| Description | `nvarchar(512)` | YES |
| UID_DialogPhysicalFormAlternat | `varchar(38)` | YES |
| XObjectKey | `varchar(138)` | NO |
| ControlAssembly | `nvarchar(256)` | YES |
| ControlClass | `nvarchar(256)` | YES |
| FormSourceType | `nvarchar(10)` | YES |
| XMarkedForDeletion | `int` | YES |

### DialogProcess  (495 rows)

| Column | Type | Nullable |
|--------|------|----------|
| GenProcID | `varchar(38)` | NO |
| BasisObjectType | `nvarchar(32)` | YES |
| ObjectKey | `varchar(138)` | YES |
| ProcessState | `nchar(1)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| CustomComment | `nvarchar(255)` | YES |
| XTouched | `nchar(1)` | YES |
| DisplayName | `nvarchar(1024)` | YES |
| GenProcIDGroup | `varchar(38)` | YES |
| ReadyForDeleteOrExport | `int` | YES |

### DialogProcessChain  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Tree | `varchar(38)` | NO |
| GenProcID | `varchar(38)` | NO |
| JobChainName | `nvarchar(255)` | YES |
| BasisObjectType | `nvarchar(32)` | YES |
| ObjectKey | `varchar(138)` | YES |
| ProcessState | `nchar(1)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| DisplayName | `nvarchar(1024)` | YES |
| ReadyForDeleteOrExport | `int` | YES |

### DialogProcessStep  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Job | `varchar(38)` | NO |
| UID_Tree | `varchar(38)` | YES |
| ProcessTask | `nvarchar(255)` | YES |
| ProcessState | `nchar(1)` | YES |
| ProcessStateAddOn | `nvarchar(32)` | YES |
| ProcessInfoLevel | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| UID_ParentJob | `varchar(38)` | YES |
| XTouched | `nchar(1)` | YES |
| DisplayName | `nvarchar(1024)` | YES |

### DialogProcessSubstitute  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| GenProcIDNew | `varchar(38)` | NO |
| GenProcIDOrigin | `varchar(38)` | NO |
| ReadyForDeleteOrExport | `int` | YES |

### DialogProductHasAuthentifier  (153 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogAuthentifier | `varchar(38)` | NO |
| UID_DialogProduct | `varchar(38)` | NO |
| XUserUpdated | `nvarchar(64)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XDateUpdated | `datetime` | YES |
| XDateInserted | `datetime` | YES |
| IsInActive | `bit` | YES |
| XMarkedForDeletion | `int` | YES |

### DialogProductHasSheet  (1,169 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogSheet | `varchar(38)` | NO |
| UID_DialogProduct | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### DialogReport  (93 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogReport | `varchar(38)` | NO |
| ReportName | `nvarchar(64)` | NO |
| Description | `nvarchar(255)` | YES |
| ReportDefinition | `nvarchar(MAX)` | YES |
| CustomProperty01 | `nvarchar(64)` | YES |
| CustomProperty02 | `nvarchar(64)` | YES |
| CustomProperty03 | `nvarchar(64)` | YES |
| CustomProperty04 | `nvarchar(64)` | YES |
| CustomProperty05 | `nvarchar(64)` | YES |
| CustomProperty06 | `nvarchar(64)` | YES |
| CustomProperty07 | `nvarchar(64)` | YES |
| CustomProperty08 | `nvarchar(64)` | YES |
| CustomProperty09 | `nvarchar(64)` | YES |
| CustomProperty10 | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| DisplayName | `nvarchar(255)` | YES |
| XObjectKey | `varchar(138)` | NO |
| FilterCriteria | `nvarchar(255)` | YES |
| ReportClass | `nvarchar(16)` | YES |
| PreProcessorCondition | `nvarchar(255)` | YES |
| IsDeactivatedByPreProcessor | `bit` | YES |
| UID_DialogTableBase | `varchar(38)` | YES |
| XMarkedForDeletion | `int` | YES |
| MaxSecondsRuntime | `int` | YES |

### DialogReportQuery  (698 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogReportQuery | `varchar(38)` | NO |
| UID_DialogReport | `varchar(38)` | NO |
| QueryName | `nvarchar(255)` | YES |
| QueryDefinition | `nvarchar(MAX)` | YES |
| Description | `nvarchar(255)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| SortOrder | `int` | YES |
| ViewName | `nvarchar(64)` | YES |
| ViewWhereClause | `nvarchar(MAX)` | YES |
| ViewOrderClause | `nvarchar(255)` | YES |
| ObjectColumns | `nvarchar(MAX)` | YES |
| ObjectWhereClause | `nvarchar(MAX)` | YES |
| ObjectOrderClause | `nvarchar(255)` | YES |
| XObjectKey | `varchar(138)` | NO |
| HListBackTo | `nvarchar(32)` | YES |
| HListResolveFKs | `bit` | YES |
| HObjObjectKey | `nvarchar(264)` | YES |
| HObjBackTo | `nvarchar(32)` | YES |
| HObjResolveFKs | `bit` | YES |
| ObjectResolveFKs | `bit` | YES |
| HAssignBackTo | `nvarchar(32)` | YES |
| HAssignCriteriaColumn | `nvarchar(32)` | YES |
| HAssignCriteriaValue | `nvarchar(256)` | YES |
| HAssignDeactivationFlagColumn | `nvarchar(32)` | YES |
| UID_DialogReportQueryParent | `varchar(38)` | YES |
| HAssignObjectColumns | `nvarchar(MAX)` | YES |
| QueryData | `nvarchar(MAX)` | YES |
| UID_DialogReportQueryModule | `varchar(38)` | YES |
| UID_DialogTableObject | `varchar(38)` | YES |
| UID_DialogTableHList | `varchar(38)` | YES |
| UID_DialogTableHAssign | `varchar(38)` | YES |
| XMarkedForDeletion | `int` | YES |
| MaxRowCount | `int` | YES |
| HObjColumns | `nvarchar(MAX)` | YES |
| HListColumns | `nvarchar(MAX)` | YES |
| HAssignFKColumn | `nvarchar(32)` | YES |
| HAssignType | `int` | YES |

### DialogReportQueryModule  (8 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogReportQueryModule | `varchar(38)` | NO |
| Ident_DialogReportQueryModule | `varchar(64)` | NO |
| ModuleAssembly | `nvarchar(256)` | NO |
| ModuleClass | `nvarchar(256)` | NO |
| DisplayValue | `nvarchar(256)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| PreProcessorCondition | `nvarchar(255)` | YES |
| SortOrder | `int` | YES |
| XMarkedForDeletion | `int` | YES |

### DialogRichMail  (68 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogRichMail | `varchar(38)` | NO |
| UID_DialogParameterSet | `varchar(38)` | YES |
| Ident_DialogRichMail | `nvarchar(64)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| Sensitivity | `nvarchar(32)` | YES |
| Importance | `int` | YES |
| AllowUnsubscribe | `bit` | YES |
| MailDesignType | `int` | YES |
| TargetFormat | `nvarchar(16)` | NO |
| Description | `nvarchar(256)` | YES |
| UID_DialogTableBaseObject | `varchar(38)` | YES |
| XMarkedForDeletion | `int` | YES |
| IsInActive | `bit` | YES |
| AttachmentFileName | `nvarchar(256)` | YES |

### DialogRichMailBody  (133 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogRichMailBody | `varchar(38)` | NO |
| UID_DialogRichMail | `varchar(38)` | NO |
| RichMailBody | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RichMailSubject | `nvarchar(MAX)` | YES |
| UID_DialogCulture | `varchar(38)` | NO |
| XMarkedForDeletion | `int` | YES |

### DialogRichMailImage  (64 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogRichMailImage | `varchar(38)` | NO |
| UID_DialogRichMailBody | `varchar(38)` | YES |
| FileType | `nvarchar(16)` | YES |
| FileContent | `varbinary` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| HashValue | `nvarchar(40)` | YES |
| XMarkedForDeletion | `int` | YES |

### DialogSchedule  (64 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogSchedule | `varchar(38)` | NO |
| UID_DialogTableBelongsTo | `varchar(38)` | YES |
| Name | `nvarchar(255)` | NO |
| Enabled | `bit` | YES |
| StartDate | `datetime` | YES |
| EndDate | `datetime` | YES |
| Frequency | `int` | YES |
| FrequencyType | `nvarchar(5)` | YES |
| StartTime | `varchar(256)` | YES |
| NextRun | `datetime` | YES |
| LastRun | `datetime` | YES |
| Description | `nvarchar(1024)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| FrequencySubType | `nvarchar(256)` | YES |
| UID_DialogTimeZone | `varchar(38)` | NO |
| XMarkedForDeletion | `int` | YES |

### DialogScript  (307 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogScript | `varchar(38)` | NO |
| ScriptName | `nvarchar(64)` | NO |
| ScriptCode | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| IsLocked | `bit` | YES |
| XTouched | `nchar(1)` | YES |
| Description | `nvarchar(1023)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### DialogScriptAssembly  (26 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogScriptAssembly | `varchar(38)` | NO |
| Name | `nvarchar(128)` | YES |
| Assembly | `varbinary` | YES |
| XDateInserted | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| IsValid | `bit` | YES |

### DialogSemaphor  (26 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogSemaphor | `varchar(38)` | NO |
| ChangeContext | `nvarchar(32)` | YES |
| ChangeCounter | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |

### DialogSheet  (1,171 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogSheet | `varchar(38)` | NO |
| UID_DialogImage | `varchar(38)` | YES |
| UID_DialogLogicalForm | `varchar(38)` | YES |
| InsertValues | `nvarchar(MAX)` | YES |
| SortOrder | `nvarchar(7)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| Caption | `nvarchar(128)` | NO |
| ConfigurationInfo | `nvarchar(MAX)` | YES |
| IsDeactivated | `bit` | YES |
| PreProcessorCondition | `nvarchar(255)` | YES |
| IsDeactivatedByPreProcessor | `bit` | YES |
| Description | `nvarchar(512)` | YES |
| SheetName | `nvarchar(255)` | YES |
| HelpKey | `nvarchar(100)` | YES |
| XObjectKey | `varchar(138)` | NO |
| IsShowModal | `bit` | YES |
| IsForceOpenInNewTab | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| DisableControlItems | `int` | YES |

### DialogState  (4,831 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogState | `varchar(38)` | NO |
| UID_DialogCountry | `varchar(38)` | NO |
| ShortName | `nvarchar(16)` | YES |
| Ident_DialogState | `nvarchar(64)` | YES |
| AVGUTCOffset | `int` | YES |
| IsInUse | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| DefaultWorkingHours | `varchar(168)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| IsDayLightSaving | `bit` | YES |
| NationalStateName | `nvarchar(64)` | YES |
| CapitalName | `nvarchar(64)` | YES |
| NationalCapitalName | `nvarchar(64)` | YES |
| XMarkedForDeletion | `int` | YES |
| IsHistorical | `bit` | YES |

### DialogStateHasCulture  (140 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogState | `varchar(38)` | NO |
| UID_DialogCulture | `varchar(38)` | NO |
| SortOrder | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### DialogStateHasTimeZone  (1,450 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogTimeZone | `varchar(38)` | NO |
| UID_DialogState | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### DialogStateHoliday  (8,613 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogStateHoliday | `varchar(38)` | NO |
| UID_DialogState | `varchar(38)` | NO |
| IsoDate | `nvarchar(10)` | YES |
| XDateInserted | `datetime` | YES |
| Ident_DialogStateHoliday | `nvarchar(64)` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| NationalHolidayName | `nvarchar(64)` | YES |
| XMarkedForDeletion | `int` | YES |
| IsToIgnore | `bit` | YES |

### DialogTable  (961 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogTable | `varchar(38)` | NO |
| TableName | `varchar(30)` | NO |
| XDateInserted | `datetime` | YES |
| UID_DialogImage | `varchar(38)` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| CustomRemarks | `nvarchar(255)` | YES |
| DisplayPattern | `nvarchar(255)` | YES |
| XTouched | `nchar(1)` | YES |
| PreProcessorCondition | `nvarchar(255)` | YES |
| IsDeactivatedByPreProcessor | `bit` | YES |
| TableType | `nvarchar(1)` | YES |
| SelectScript | `nvarchar(MAX)` | YES |
| InsertValues | `nvarchar(MAX)` | YES |
| DisplayName | `nvarchar(64)` | YES |
| ViewWhereClause | `nvarchar(MAX)` | YES |
| LayoutInformation | `nvarchar(MAX)` | YES |
| isSPML | `bit` | YES |
| XObjectKey | `varchar(138)` | NO |
| OnSavingScript | `nvarchar(MAX)` | YES |
| OnDiscardingScript | `nvarchar(MAX)` | YES |
| OnDiscardedScript | `nvarchar(MAX)` | YES |
| OnLoadedScript | `nvarchar(MAX)` | YES |
| OnSavedScript | `nvarchar(MAX)` | YES |
| DefaultDisplayFKList | `nvarchar(256)` | YES |
| isMNTable | `bit` | YES |
| IsTransportDisabled | `bit` | YES |
| CountRows | `int` | YES |
| SizeMB | `float` | YES |
| BaseRecordLen | `int` | YES |
| UsageType | `nvarchar(16)` | YES |
| isAssignmentWithEvent | `bit` | YES |
| IsResident | `bit` | YES |
| ElementColor | `nvarchar(16)` | YES |
| CacheInfo | `int` | YES |
| DisplayPatternLong | `nvarchar(256)` | YES |
| UID_DialogTableBase | `varchar(38)` | YES |
| UID_DialogTableUnion | `varchar(38)` | YES |
| IsModuleGUIDAllowed | `bit` | YES |
| IsModuleGUIDDefault | `bit` | YES |
| ExtensionForProxyTable | `nvarchar(MAX)` | YES |
| XMarkedForDeletion | `int` | YES |
| DeleteDelayDays | `int` | YES |
| IsMAllTable | `bit` | YES |
| ScopeReferenceColumns | `nvarchar(MAX)` | YES |
| TransportWhereClause | `nvarchar(MAX)` | YES |
| UID_QBMDiskStoreLogical | `varchar(38)` | YES |
| PKName1 | `varchar(30)` | YES |
| PKName2 | `varchar(30)` | YES |
| PendingChangeBehavior | `int` | YES |
| DisplayNameSingular | `nvarchar(64)` | YES |
| SplittedLookupSupport | `varchar(1024)` | YES |
| DeleteDelayScript | `nvarchar(MAX)` | YES |
| TransportSingleUser | `nvarchar(MAX)` | YES |
| IsApiServerEnabled | `int` | YES |
| IsNoProcessMonitoring | `bit` | YES |
| SystemSyncMode | `int` | YES |
| SystemSyncKeyColumns | `varchar(128)` | YES |
| UID_SystemSyncConfigCLRType | `varchar(38)` | YES |

### DialogTableGroupRight  (6,624 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogGroup | `varchar(38)` | NO |
| UID_DialogTable | `varchar(38)` | NO |
| CanSee | `bit` | YES |
| CanEdit | `bit` | YES |
| CanInsert | `bit` | YES |
| CanDelete | `bit` | YES |
| SelectWhereClause | `nvarchar(MAX)` | YES |
| UpdateWhereClause | `nvarchar(MAX)` | YES |
| InsertWhereClause | `nvarchar(MAX)` | YES |
| DeleteWhereClause | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### DialogTableHasCustomizer  (1,128 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogTable | `varchar(38)` | NO |
| UID_Customizer | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |

### DialogTag  (44 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogTag | `varchar(38)` | NO |
| Ident_DialogTag | `nvarchar(64)` | NO |
| Description | `nvarchar(255)` | YES |
| TagType | `nvarchar(16)` | YES |
| CurrentState | `nvarchar(64)` | YES |
| CurrentStateRemarks | `nvarchar(255)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| IsClosed | `bit` | YES |
| Commentary | `nvarchar(MAX)` | YES |
| UID_DialogTagParent | `varchar(38)` | YES |
| XMarkedForDeletion | `int` | YES |
| SortOrder | `nvarchar(64)` | YES |

### DialogTaggedItem  (21 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogTaggedItem | `varchar(38)` | NO |
| UID_DialogTag | `varchar(38)` | NO |
| IsDelete | `bit` | YES |
| ObjectKey | `varchar(138)` | NO |
| AlternateKey | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| IsContainerItem | `bit` | YES |

### DialogTimeZone  (655 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogTimeZone | `varchar(38)` | NO |
| Ident_DialogTimeZone | `nvarchar(64)` | YES |
| Commentary | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| UTCOffset | `int` | YES |
| ShortName | `nvarchar(8)` | YES |
| IsDayLightSaving | `bit` | YES |
| CurrentUTCOffset | `int` | YES |
| XMarkedForDeletion | `int` | YES |
| UID_TimeZoneMS | `varchar(38)` | YES |

### DialogUser  (9 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogUser | `varchar(38)` | NO |
| UserName | `nvarchar(64)` | NO |
| Password | `varchar(218)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| CustomRemarks | `nvarchar(255)` | YES |
| IsReadOnly | `bit` | YES |
| XTouched | `nchar(1)` | YES |
| Salt | `nvarchar(16)` | YES |
| XObjectKey | `varchar(138)` | NO |
| IsDynamicUser | `bit` | YES |
| LastLogin | `datetime` | YES |
| XMarkedForDeletion | `int` | YES |
| IsAdmin | `bit` | YES |
| IsServiceAccount | `bit` | YES |
| IsPwdExternalManaged | `bit` | YES |
| AuthentifierLogins | `nvarchar(MAX)` | YES |
| PasswordLastSet | `datetime` | YES |
| BadPasswordAttempts | `int` | YES |
| PasswordNeverExpires | `bit` | YES |
| IsLockedOut | `bit` | YES |
| IsDisabledForDirectLogin | `bit` | YES |

### DialogUserConfiguration  (1 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogProduct | `varchar(38)` | NO |
| UID_QBMXUser | `varchar(38)` | NO |
| ConfigurationData | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |

### DialogUserDisplayConfig  (2 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogUserDisplayConfig | `varchar(38)` | NO |
| UID_QBMXUser | `varchar(38)` | YES |
| ConfigContext | `nvarchar(64)` | YES |
| Element | `nvarchar(1024)` | YES |
| Operation | `nvarchar(32)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| UID_DialogProduct | `varchar(38)` | YES |

### DialogUserInGroup  (187 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogGroup | `varchar(38)` | NO |
| UID_DialogUser | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### DialogValidDynamicRef  (704 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogColumn | `varchar(38)` | NO |
| UID_DialogTableReference | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| IsConnectedInTransport | `int` | YES |
| ParentRestriction | `nchar(2)` | NO |
| ParentExecuteBy | `nchar(1)` | YES |
| ChildRestriction | `nchar(2)` | NO |
| ChildExecuteBy | `nchar(1)` | YES |
| XMarkedForDeletion | `int` | YES |
| IsForAddElementAffected | `bit` | YES |

### DialogWatchOperation  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogWatchOperation | `varchar(38)` | NO |
| GenProcID | `varchar(38)` | NO |
| OperationType | `nchar(1)` | YES |
| OperationDate | `datetime` | YES |
| OperationUser | `nvarchar(64)` | YES |
| ObjectKeyOfRow | `varchar(138)` | NO |
| OperationLevel | `int` | YES |
| DisplayValue | `nvarchar(255)` | YES |
| ReadyForDeleteOrExport | `int` | YES |

### DialogWatchProperty  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogWatchProperty | `varchar(38)` | NO |
| UID_DialogWatchOperation | `varchar(38)` | YES |
| UID_DialogColumn | `varchar(38)` | YES |
| ContentShort | `nvarchar(400)` | YES |
| HasContentFull | `bit` | YES |
| ContentFull | `nvarchar(MAX)` | YES |

### DialogWebService  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogWebService | `varchar(38)` | NO |
| Ident_DialogWebService | `nvarchar(128)` | NO |
| WebServiceUrl | `nvarchar(MAX)` | YES |
| WsdlUrl | `nvarchar(MAX)` | YES |
| UserName | `nvarchar(64)` | YES |
| UserDomain | `nvarchar(128)` | YES |
| UserPassword | `varchar(990)` | YES |
| ProxyUrl | `nvarchar(MAX)` | YES |
| ProxyUserName | `nvarchar(64)` | YES |
| ProxyPassword | `varchar(990)` | YES |
| ProxyDomain | `nvarchar(128)` | YES |
| Namespace | `nvarchar(256)` | NO |
| CustomCMD | `nvarchar(MAX)` | YES |
| ProxyCode | `nvarchar(MAX)` | YES |
| LastProxyCodeUpdate | `datetime` | YES |
| WebServiceClass | `nvarchar(128)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| Description | `nvarchar(MAX)` | YES |
| IsLocked | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| ServiceType | `nvarchar(64)` | YES |

### DomainTrustsDomain  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ADSDomainTrusts | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| UID_ADSDomainTrusted | `varchar(38)` | NO |

### DPRAttachedDataStore  (15 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRAttachedDataStore | `varchar(38)` | NO |
| UID_DataQBMClrType | `varchar(38)` | YES |
| OwnerObject | `varchar(138)` | NO |
| OwnerProperty | `nvarchar(512)` | YES |
| OwnerSchema | `nvarchar(256)` | YES |
| HasDataFull | `bit` | YES |
| DataShort | `nvarchar(400)` | YES |
| DataFull | `nvarchar(MAX)` | YES |
| SourceInfo | `nvarchar(256)` | YES |
| CreationDate | `datetime` | YES |

### DPRJournal  (3 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRJournal | `varchar(38)` | NO |
| CreationTime | `datetime` | YES |
| UID_DPRProjectionConfig | `varchar(38)` | YES |
| ProjectionContext | `nvarchar(32)` | YES |
| ProjectionConfigDisplay | `nvarchar(256)` | YES |
| ProjectionState | `varchar(64)` | YES |
| UID_DPRSystemVariableSet | `varchar(38)` | YES |
| SystemVariableSetDisplay | `nvarchar(256)` | YES |
| UID_DPRProjectionStartInfo | `varchar(38)` | YES |
| ProjectionStartInfoDisplay | `nvarchar(256)` | YES |
| CompletionTime | `datetime` | YES |
| CausingEntityKey | `varchar(138)` | YES |
| CausingEntityDisplay | `nvarchar(256)` | YES |
| JobId | `varchar(40)` | YES |

### DPRJournalFailure  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRJournalFailure | `varchar(38)` | NO |
| UID_DPRJournal | `varchar(38)` | NO |
| ObjectDisplay | `nvarchar(256)` | YES |
| ObjectState | `nvarchar(64)` | YES |
| Reason | `nvarchar(MAX)` | YES |
| UID_DPRProjectionConfigStep | `varchar(38)` | YES |
| ProjectionStepDisplay | `nvarchar(256)` | YES |
| SchemaTypeName | `nvarchar(256)` | NO |
| SchemaUid | `varchar(40)` | NO |
| ObjectIdentifier | `nvarchar(400)` | NO |

### DPRJournalMessage  (26 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRJournalMessage | `varchar(38)` | NO |
| MessageString | `nvarchar(MAX)` | YES |
| MessageContext | `nvarchar(64)` | YES |
| MessageParameter1 | `nvarchar(256)` | YES |
| MessageParameter2 | `nvarchar(256)` | YES |
| MessageSource | `nvarchar(256)` | YES |
| MessageType | `nvarchar(1)` | YES |
| UID_DPRJournal | `varchar(38)` | YES |
| SequenceNumber | `int` | YES |

### DPRJournalObject  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRJournalObject | `varchar(38)` | NO |
| UID_DPRJournal | `varchar(38)` | NO |
| Method | `nvarchar(128)` | YES |
| ObjectDisplay | `nvarchar(256)` | YES |
| SchemaTypeName | `nvarchar(256)` | NO |
| ObjectState | `nvarchar(64)` | YES |
| SchemaUid | `varchar(40)` | NO |
| ObjectIdentifier | `nvarchar(400)` | NO |
| IsImport | `bit` | YES |
| SequenceNumber | `int` | YES |
| UID_DPRJournalFailure | `varchar(38)` | YES |

### DPRJournalProperty  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRJournalProperty | `varchar(38)` | NO |
| UID_DPRJournalObject | `varchar(38)` | NO |
| PropertyName | `nvarchar(256)` | NO |
| NewValueShort | `nvarchar(400)` | YES |
| IsNewValueFull | `bit` | YES |
| NewValueFull | `nvarchar(MAX)` | YES |
| OldValueShort | `nvarchar(400)` | YES |
| IsOldValueFull | `bit` | YES |
| OldValueFull | `nvarchar(MAX)` | YES |

### DPRJournalSetup  (36 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRJournalSetup | `varchar(38)` | NO |
| UID_DPRJournalSetupParent | `varchar(38)` | YES |
| OptionName | `nvarchar(128)` | NO |
| OptionValue | `nvarchar(128)` | YES |
| OptionContext | `nvarchar(256)` | YES |
| UID_DPRJournal | `varchar(38)` | NO |
| OptionContextDisplay | `nvarchar(256)` | YES |

### DPRMemberShipAction  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRMemberShipAction | `varchar(38)` | NO |
| ObjectKeyMN | `varchar(138)` | NO |
| Operation | `varchar(3)` | NO |
| ObjectKeyBase | `varchar(138)` | NO |
| ObjectKeyMember | `varchar(138)` | NO |
| OperationDate | `datetime` | YES |
| OperationDateAddOn | `timestamp` | YES |
| XObjectKey | `varchar(138)` | NO |
| UID_DPRNameSpace | `varchar(38)` | NO |

### DPRNameSpace  (7 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRNameSpace | `varchar(38)` | NO |
| Ident_DPRNameSpace | `nvarchar(64)` | YES |
| Description | `nvarchar(1024)` | YES |
| IsExtendedInheritance | `bit` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| DisplayName | `nvarchar(1024)` | YES |
| AdditionalSystemTypes | `nvarchar(MAX)` | YES |
| IsFilterDesignerEnabled | `bit` | YES |
| FilterDesignerText | `nvarchar(1024)` | YES |

### DPRNameSpaceHasDialogTable  (223 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRNameSpace | `varchar(38)` | NO |
| UID_DialogTable | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| CanPublish | `bit` | YES |
| IsAdHocSingleMemberShip | `bit` | YES |
| WhereClause | `nvarchar(MAX)` | YES |
| RootObjectPath | `nvarchar(MAX)` | YES |

### DPRObjectOperation  (12 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRObjectOperation | `varchar(38)` | NO |
| UID_DialogTable | `varchar(38)` | NO |
| UID_DPRSystemConnection | `varchar(38)` | NO |
| UID_DPRProjectionConfig | `varchar(38)` | NO |
| Name | `nvarchar(128)` | NO |
| DisplayName | `nvarchar(128)` | YES |
| Description | `nvarchar(1024)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |

### DPRProjectionConfig  (9 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRProjectionConfig | `varchar(38)` | NO |
| UID_DPRShell | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| Description | `nvarchar(1024)` | YES |
| DisplayName | `nvarchar(256)` | YES |
| ExceptionHandling | `nvarchar(32)` | YES |
| Name | `nvarchar(256)` | NO |
| NameFormat | `nvarchar(32)` | YES |
| ProjectionDirection | `nvarchar(32)` | YES |
| SerializationBag | `nvarchar(MAX)` | YES |
| UID_QBMClrType | `varchar(38)` | NO |
| UseRevision | `nvarchar(32)` | YES |
| ConflictResolution | `nvarchar(16)` | YES |
| DisplayNameQualified | `nvarchar(256)` | YES |
| LogVariableSetContents | `bit` | YES |
| JournalMessageContexts | `nvarchar(MAX)` | YES |
| GeneralConcurrenceStrategy | `varchar(32)` | YES |

### DPRProjectionConfigHasConnect  (18 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRProjectionConfig | `varchar(38)` | NO |
| UID_DPRSystemConnection | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |

### DPRProjectionConfigStep  (36 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRProjectionConfigStep | `varchar(38)` | NO |
| UID_LeftDPRSystemConnection | `varchar(38)` | NO |
| UID_RightDPRSystemConnection | `varchar(38)` | NO |
| UID_LeftDPRProjectionQuota | `varchar(38)` | YES |
| UID_RightDPRProjectionQuota | `varchar(38)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| Description | `nvarchar(1024)` | YES |
| DisplayName | `nvarchar(256)` | YES |
| ExceptionHandling | `nvarchar(32)` | YES |
| Name | `nvarchar(256)` | NO |
| NameFormat | `nvarchar(32)` | YES |
| ProjectionDirection | `nvarchar(32)` | YES |
| RuleBlackList | `nvarchar(MAX)` | YES |
| RuleWhiteList | `nvarchar(MAX)` | YES |
| SerializationBag | `nvarchar(MAX)` | YES |
| UID_QBMClrType | `varchar(38)` | NO |
| UseRevision | `nvarchar(32)` | YES |
| UID_DPRProjectionConfig | `varchar(38)` | NO |
| UID_DPRSystemObjectMatchSets | `varchar(38)` | NO |
| UID_DPRSystemMap | `varchar(38)` | NO |
| IsDeactivated | `bit` | YES |
| Sequence | `int` | YES |
| IsImport | `bit` | YES |
| IsPostProcessingStep | `bit` | YES |
| PerformanceMemoryFactor | `float` | YES |
| LoadPartitionedThreshold | `int` | YES |
| CommitPropertiesMode | `nvarchar(16)` | YES |
| CommitPropertiesLeft | `nvarchar(MAX)` | YES |
| CommitPropertiesRight | `nvarchar(MAX)` | YES |
| DoNotRespectOutstanding | `bit` | YES |

### DPRProjectionDependency  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRProjectionDependency | `varchar(38)` | NO |
| UID_DPRShell | `varchar(38)` | NO |
| UID_DPRSchemaTypePrior | `varchar(38)` | NO |
| UID_DPRSchemaType | `varchar(38)` | NO |
| DependencyType | `int` | YES |
| Name | `nvarchar(256)` | NO |
| DisplayName | `nvarchar(256)` | YES |
| NameFormat | `nvarchar(32)` | YES |
| Description | `nvarchar(1024)` | YES |
| XObjectKey | `varchar(138)` | NO |
| SerializationBag | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| UID_QBMClrType | `varchar(38)` | NO |

### DPRProjectionObjectState  (3 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRProjectionObjectState | `varchar(38)` | NO |
| UID_DPRProjectionConfig | `varchar(38)` | NO |
| UID_DPRSystemVariableSet | `varchar(38)` | YES |
| UID_ObjectKeyQBMClrType | `varchar(38)` | NO |
| ObjectKey | `nvarchar(256)` | NO |
| ObjectState | `int` | YES |
| SchemaTypeKey | `nvarchar(512)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |

### DPRProjectionStartInfo  (9 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRProjectionStartInfo | `varchar(38)` | NO |
| UID_DPRProjectionConfig | `varchar(38)` | YES |
| UID_DPRSystemVariableSet | `varchar(38)` | YES |
| DebugMode | `bit` | YES |
| ProjectionDirection | `nvarchar(32)` | YES |
| RevisionHandling | `nvarchar(32)` | YES |
| PartitionSize | `int` | YES |
| LoadPartitionedThreshold | `int` | YES |
| Name | `nvarchar(256)` | YES |
| DisplayName | `nvarchar(256)` | YES |
| NameFormat | `nvarchar(32)` | YES |
| Description | `nvarchar(1024)` | YES |
| UID_DPRShell | `varchar(38)` | NO |
| SerializationBag | `nvarchar(MAX)` | YES |
| UID_QBMClrType | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| LastStart | `datetime` | YES |
| UseSingleProcessContextExec | `bit` | YES |
| UID_DPRRootObjConnectionInfo | `varchar(38)` | YES |
| BulkLevel | `int` | YES |
| MaintenanceType | `nvarchar(32)` | YES |
| MaintenanceRetryCycles | `int` | YES |
| StartGroupName | `nvarchar(64)` | YES |
| StartGroupConcurrenceBehavior | `nvarchar(16)` | YES |
| ProgressText | `nvarchar(256)` | YES |
| ProgressValue | `float` | YES |
| CurrentJobReference | `varchar(40)` | YES |
| SysConcurrenceCheckMode | `nvarchar(32)` | YES |
| SysConcurrenceCacheLifeTime | `int` | YES |
| FailureHandlingMode | `nvarchar(32)` | YES |
| FailureHandlingRetryCycles | `int` | YES |

### DPRProjectionStepQuota  (72 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRProjectionStepQuota | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| Description | `nvarchar(1024)` | YES |
| DisplayName | `nvarchar(256)` | YES |
| MethodQuotas | `nvarchar(MAX)` | YES |
| Name | `nvarchar(256)` | NO |
| NameFormat | `nvarchar(32)` | YES |
| SerializationBag | `nvarchar(MAX)` | YES |
| UID_QBMClrType | `varchar(38)` | NO |
| Settings | `nvarchar(32)` | YES |

### DPRRevisionStore  (30 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRRevisionStore | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| SchemaTypeKey | `nvarchar(512)` | NO |
| UID_ValueQBMClrType | `varchar(38)` | NO |
| Value | `nvarchar(256)` | YES |
| RevisionDate | `datetime` | NO |
| UID_DPRSystemVariableSet | `varchar(38)` | YES |
| UID_DPRProjectionConfig | `varchar(38)` | NO |
| ValueType | `int` | YES |

### DPRRootObjConnectionInfo  (4 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRRootObjConnectionInfo | `varchar(38)` | NO |
| UID_DPRSystemConnection | `varchar(38)` | NO |
| UID_DPRSystemVariableSet | `varchar(38)` | NO |
| ObjectKeyRoot | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| UID_QBMServer | `varchar(38)` | YES |
| UID_QBMServerTag | `varchar(38)` | YES |
| IsOffline | `bit` | YES |
| IsOfflineModeAvailable | `bit` | YES |

### DPRSchema  (8 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRSchema | `varchar(38)` | NO |
| SystemSubType | `nvarchar(64)` | YES |
| UID_DPRShell | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| Description | `nvarchar(1024)` | YES |
| DisplayName | `nvarchar(256)` | YES |
| Name | `nvarchar(256)` | NO |
| SystemId | `nvarchar(256)` | NO |
| UID_QBMClrType | `varchar(38)` | NO |
| SerializationBag | `nvarchar(MAX)` | YES |
| NameFormat | `nvarchar(32)` | YES |
| IsLocked | `bit` | YES |
| IsPartial | `bit` | YES |
| SystemType | `nvarchar(32)` | YES |
| SystemDisplay | `nvarchar(256)` | YES |
| SystemVersion | `nvarchar(64)` | YES |
| SystemCapabilities | `nvarchar(128)` | YES |
| FunctionalLevel | `int` | YES |

### DPRSchemaAccess  (1,505 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRSchemaAccess | `varchar(38)` | NO |
| UID_DPRSchemaPropertyTrg | `varchar(38)` | NO |
| UID_DPRSchemaPropertySrc | `varchar(38)` | NO |
| AccessMode | `nvarchar(16)` | NO |
| AccessType | `nvarchar(16)` | NO |
| ObjectKeyAccessor | `varchar(138)` | NO |

### DPRSchemaClass  (356 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRSchemaClass | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| Description | `nvarchar(1024)` | YES |
| DisplayName | `nvarchar(256)` | YES |
| Filter | `nvarchar(MAX)` | YES |
| Name | `nvarchar(256)` | NO |
| NameFormat | `nvarchar(32)` | YES |
| SerializationBag | `nvarchar(MAX)` | YES |
| UID_DPRSchemaType | `varchar(38)` | NO |
| UID_QBMClrType | `varchar(38)` | NO |
| UID_FilterQBMClrType | `varchar(38)` | YES |
| IsLocked | `bit` | YES |
| IsObsolete | `bit` | YES |

### DPRSchemaMethHasProperty  (1,067 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRSchemaMethod | `varchar(38)` | NO |
| UID_DPRSchemaProperty | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |

### DPRSchemaMethod  (1,019 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRSchemaMethod | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| Description | `nvarchar(1024)` | YES |
| DisplayName | `nvarchar(256)` | YES |
| IsReadOnly | `bit` | YES |
| Name | `nvarchar(256)` | NO |
| UID_DPRSchemaType | `varchar(38)` | NO |
| UID_QBMClrType | `varchar(38)` | NO |
| SerializationBag | `nvarchar(MAX)` | YES |
| NameFormat | `nvarchar(32)` | YES |
| IsLocked | `bit` | YES |
| AcceptPartialLoadedObjects | `bit` | YES |
| MetaData | `nvarchar(1024)` | YES |
| IsNotCapableForImport | `bit` | YES |
| IsObsolete | `bit` | YES |
| MethodType | `nvarchar(16)` | YES |

### DPRSchemaProperty  (41,026 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRSchemaProperty | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| AccessConstraint | `nvarchar(32)` | YES |
| DataType | `nvarchar(16)` | YES |
| Description | `nvarchar(1024)` | YES |
| DisplayName | `nvarchar(256)` | YES |
| IsAdditional | `int` | YES |
| IsLargeObject | `int` | YES |
| IsLocked | `bit` | YES |
| IsMultiValue | `int` | YES |
| IsReference | `int` | YES |
| IsUniqueKey | `int` | YES |
| IsVirtual | `bit` | YES |
| MaximumLength | `int` | YES |
| Name | `nvarchar(256)` | NO |
| UID_DPRSchemaType | `varchar(38)` | NO |
| UID_ConverterQBMClrType | `varchar(38)` | YES |
| ValueFormat | `nvarchar(32)` | YES |
| UID_DPRSchemaPropertyReference | `varchar(38)` | YES |
| SerializationBag | `nvarchar(MAX)` | YES |
| DataTypeSize | `int` | YES |
| NameFormat | `nvarchar(32)` | YES |
| ConverterConfig | `nvarchar(MAX)` | YES |
| UID_BaseDPRSchemaProperty | `varchar(38)` | YES |
| UID_QBMClrType | `varchar(38)` | NO |
| IsRevisionCounter | `bit` | YES |
| IsHierarchySortCriterion | `bit` | YES |
| IsSecretValue | `int` | YES |
| MandatoryBehavior | `nvarchar(64)` | YES |
| MetaData | `nvarchar(1024)` | YES |
| IsPreferredKey | `bit` | YES |
| AutoFillBehavior | `nvarchar(64)` | YES |
| IsObsolete | `bit` | YES |
| IsMvpOrderSignificant | `bit` | YES |

### DPRSchemaPropertyReference  (12,545 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRSchemaPropertyReference | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| Description | `nvarchar(1024)` | YES |
| DisplayName | `nvarchar(256)` | YES |
| IsReferentialIntegrityEnabled | `bit` | YES |
| IsScopeReference | `bit` | YES |
| Name | `nvarchar(256)` | NO |
| ReferenceType | `nvarchar(16)` | YES |
| UID_QBMClrType | `varchar(38)` | NO |
| SerializationBag | `nvarchar(MAX)` | YES |
| NameFormat | `nvarchar(32)` | YES |
| UID_DPRSchema | `varchar(38)` | NO |
| IsLocked | `bit` | YES |
| UID_TargetDetectorQBMClrType | `varchar(38)` | YES |
| MetaData | `nvarchar(1024)` | YES |
| TargetsUniqueByFilter | `nvarchar(MAX)` | YES |

### DPRSchemaPropertyRefHasTarget  (822 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRSchemaPropertyReference | `varchar(38)` | NO |
| UID_DPRSchemaProperty | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |

### DPRSchemaType  (322 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRSchemaType | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| Description | `nvarchar(1024)` | YES |
| DisplayName | `nvarchar(256)` | YES |
| DisplayPattern | `nvarchar(256)` | YES |
| IsAdditional | `bit` | YES |
| IsMNType | `bit` | YES |
| IsReadOnly | `bit` | YES |
| IsVirtual | `bit` | YES |
| IsInActive | `bit` | YES |
| Name | `nvarchar(256)` | NO |
| UID_QBMClrType | `varchar(38)` | NO |
| UID_DPRSchema | `varchar(38)` | NO |
| SerializationBag | `nvarchar(MAX)` | YES |
| NameFormat | `nvarchar(32)` | YES |
| IsLocked | `bit` | YES |
| MetaData | `nvarchar(1024)` | YES |
| DesignTags | `nvarchar(64)` | YES |
| IsObsolete | `bit` | YES |
| ShrinkLock | `int` | YES |

### DPRScript  (3 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRScript | `varchar(38)` | NO |
| Name | `nvarchar(256)` | NO |
| NameFormat | `nvarchar(32)` | YES |
| DisplayName | `nvarchar(256)` | YES |
| Description | `nvarchar(1024)` | YES |
| SerializationBag | `nvarchar(MAX)` | YES |
| ScriptCode | `nvarchar(MAX)` | YES |
| UID_DPRShell | `varchar(38)` | YES |
| UID_QBMClrType | `varchar(38)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| IsMasterScript | `bit` | YES |
| XTouched | `nchar(1)` | YES |
| UID_DPRSchemaType | `varchar(38)` | YES |
| IsExternal | `bit` | YES |

### DPRServiceGate  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRServiceGate | `varchar(38)` | NO |
| Receiver | `nvarchar(256)` | NO |
| RequestTime | `datetime` | NO |
| RequestType | `nvarchar(256)` | NO |
| RequestData | `nvarchar(MAX)` | YES |
| ResponseState | `nvarchar(16)` | NO |
| ResponseData | `nvarchar(MAX)` | YES |
| ResponseErrorMessage | `nvarchar(MAX)` | YES |
| XObjectKey | `varchar(138)` | NO |
| UID_QBMServer | `varchar(38)` | NO |

### DPRShell  (4 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRShell | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| Description | `nvarchar(1024)` | YES |
| DisplayName | `nvarchar(256)` | YES |
| Name | `nvarchar(256)` | NO |
| NameFormat | `nvarchar(32)` | YES |
| SerializationBag | `nvarchar(MAX)` | YES |
| UID_QBMClrType | `varchar(38)` | NO |
| ScriptLanguage | `nvarchar(16)` | YES |
| UID_DPRSystemVariableSetDef | `varchar(38)` | YES |
| IsFinalized | `int` | YES |
| OriginInfo | `nvarchar(MAX)` | YES |
| MigrationState | `nvarchar(MAX)` | YES |
| EditedBy | `nvarchar(64)` | YES |
| EditedSince | `datetime` | YES |
| ShadowCopyMode | `nvarchar(32)` | YES |
| ShadowCopy | `nvarchar(MAX)` | YES |
| SupportedFeatureSet | `int` | YES |
| Tags | `nvarchar(MAX)` | YES |
| LastMigrationError | `nvarchar(MAX)` | YES |
| IsAutomaticallyManaged | `bit` | YES |

### DPRShellPatch  (261 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRShellPatch | `varchar(38)` | NO |
| DisplayName | `nvarchar(256)` | NO |
| PatchNumber | `varchar(16)` | NO |
| SelectScript | `nvarchar(MAX)` | YES |
| PatchScript | `nvarchar(MAX)` | YES |
| Description | `nvarchar(MAX)` | YES |
| Capabilities | `int` | YES |
| PatchType | `nvarchar(16)` | NO |
| Prerequisites | `int` | YES |
| PatchContext | `nvarchar(16)` | NO |
| PatchContextVersion | `nvarchar(16)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| ScriptLanguage | `nvarchar(16)` | NO |
| IsAutoPatch | `bit` | YES |

### DPRShellPatchDependsOn  (16 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRShellPatch | `varchar(38)` | NO |
| UID_DPRShellPatchPrior | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |

### DPRStartSequence  (1 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRStartSequence | `varchar(38)` | NO |
| UID_DPRStartSequenceTemplate | `varchar(38)` | YES |
| SequenceName | `nvarchar(64)` | YES |
| Description | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| IsAllowMultipleInstances | `bit` | YES |
| XObjectKey | `varchar(138)` | NO |
| ExecutionError | `nvarchar(MAX)` | YES |
| ExecutionState | `nvarchar(16)` | NO |
| ConcurrConflHandling | `nvarchar(32)` | YES |

### DPRStartSequenceHasProjection  (2 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRStartSequence | `varchar(38)` | NO |
| UID_DPRProjectionStartInfo | `varchar(38)` | NO |
| SortOrder | `int` | YES |
| IsBreakOnError | `bit` | YES |
| IsParallelExecutionEnabled | `bit` | YES |
| ExecutionState | `varchar(32)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| ExecutionError | `nvarchar(MAX)` | YES |
| ExecutionGroup | `nvarchar(64)` | YES |
| CurrentJobReference | `varchar(40)` | YES |

### DPRSystemConnection  (8 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRSystemConnection | `varchar(38)` | NO |
| JournalLogFailedObjectChanges | `bit` | YES |
| UID_DPRSystemScope | `varchar(38)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| ConnectionParameter | `nvarchar(MAX)` | YES |
| Description | `nvarchar(1024)` | YES |
| DisplayName | `nvarchar(256)` | YES |
| Name | `nvarchar(256)` | NO |
| UID_ConnectorQBMClrType | `varchar(38)` | YES |
| UID_DPRSchema | `varchar(38)` | NO |
| SerializationBag | `nvarchar(MAX)` | YES |
| NameFormat | `nvarchar(32)` | YES |
| UID_QBMClrType | `varchar(38)` | NO |
| IsReadOnly | `bit` | YES |
| WriteJournal | `bit` | YES |
| UID_DPRShell | `varchar(38)` | NO |
| JournalLogObjectChanges | `bit` | YES |
| JournalLogPropertyChanges | `bit` | YES |
| JournalMessageContexts | `nvarchar(MAX)` | YES |
| DefaultDisplay | `nvarchar(255)` | YES |
| UID_ParamDescriptorQBMClrType | `varchar(38)` | YES |
| UID_DPRSystemScopeForRefer | `varchar(38)` | YES |
| ConnectRetryDelay | `int` | YES |
| ConnectRetryCount | `int` | YES |
| DisplayNameQualified | `nvarchar(256)` | YES |

### DPRSystemMap  (33 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRSystemMap | `varchar(38)` | NO |
| UID_LeftDPRSchemaClass | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| Description | `nvarchar(1024)` | YES |
| DisplayName | `nvarchar(256)` | YES |
| MappingDirection | `nvarchar(32)` | YES |
| Name | `nvarchar(256)` | NO |
| NameFormat | `nvarchar(32)` | YES |
| IsTemplate | `bit` | YES |
| SerializationBag | `nvarchar(MAX)` | YES |
| UID_QBMClrType | `varchar(38)` | NO |
| UID_RightDPRSchemaClass | `varchar(38)` | NO |
| UID_BaseDPRSystemMap | `varchar(38)` | YES |
| UID_DPRShell | `varchar(38)` | NO |
| Capabilities | `nvarchar(64)` | YES |
| IsHierarchyProjection | `bit` | YES |

### DPRSystemMappingRule  (592 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRSystemMappingRule | `varchar(38)` | NO |
| UID_DPRSystemMap | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| Description | `nvarchar(1024)` | YES |
| DisplayName | `nvarchar(256)` | YES |
| DoNotOverrideLeft | `bit` | YES |
| DoNotOverrideRight | `bit` | YES |
| HandleAsSingleValueLeft | `bit` | YES |
| HandleAsSingleValueRight | `bit` | YES |
| IgnoreCase | `bit` | YES |
| IsKeyRule | `bit` | YES |
| MappingDirection | `nvarchar(32)` | YES |
| Name | `nvarchar(256)` | NO |
| NameFormat | `nvarchar(32)` | YES |
| PerformMappingContraProjection | `bit` | YES |
| PropertyLeft | `nvarchar(256)` | YES |
| PropertyRight | `nvarchar(256)` | YES |
| UID_QBMClrType | `varchar(38)` | NO |
| SerializationBag | `nvarchar(MAX)` | YES |
| SortOrder | `float` | YES |
| UID_MappingCondQBMClrType | `varchar(38)` | YES |
| MappingCondition | `nvarchar(MAX)` | YES |
| IsRogueCorrectionEnabled | `bit` | YES |
| IsRogueDetectionEnabled | `bit` | YES |
| IgnoreCaseDifferencesOnly | `bit` | YES |
| IgnoreMappingDirectionByCreate | `bit` | YES |
| ConcurrenceBehavior | `nvarchar(32)` | YES |
| DisableMergeModeSupport | `bit` | YES |
| MvpOrderBehavior | `nvarchar(32)` | YES |

### DPRSystemObjectMatchSet  (144 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRSystemObjectMatchSet | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| Description | `nvarchar(1024)` | YES |
| DisplayName | `nvarchar(256)` | YES |
| Name | `nvarchar(256)` | NO |
| NameFormat | `nvarchar(32)` | YES |
| SerializationBag | `nvarchar(MAX)` | YES |
| UID_QBMClrType | `varchar(38)` | NO |

### DPRSystemObjectMatchSetMAsgn  (103 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRSystemObjectMatchSetMA | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| ConditionData | `nvarchar(MAX)` | YES |
| Description | `nvarchar(1024)` | YES |
| DisplayName | `nvarchar(256)` | YES |
| Name | `nvarchar(256)` | NO |
| NameFormat | `nvarchar(32)` | YES |
| SerializationBag | `nvarchar(MAX)` | YES |
| TargetProjectionDirection | `nvarchar(32)` | YES |
| UID_DPRSchemaMethod | `varchar(38)` | NO |
| UID_QBMClrType | `varchar(38)` | NO |
| UID_DPRSystemObjectMatchSet | `varchar(38)` | NO |
| Side | `nvarchar(16)` | NO |
| UID_ConditionQBMClrType | `varchar(38)` | YES |
| Sequence | `int` | YES |

### DPRSystemObjectMatchSets  (36 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRSystemObjectMatchSets | `varchar(38)` | NO |
| UID_DifferenceRightToLeftSet | `varchar(38)` | YES |
| UID_IntersectionDifferenceSet | `varchar(38)` | YES |
| UID_IntersectionEqualitySet | `varchar(38)` | YES |
| UID_DifferenceLeftToRightSet | `varchar(38)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| Description | `nvarchar(1024)` | YES |
| DisplayName | `nvarchar(256)` | YES |
| Name | `nvarchar(256)` | NO |
| NameFormat | `nvarchar(32)` | YES |
| UID_QBMClrType | `varchar(38)` | NO |

### DPRSystemScope  (6 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRSystemScope | `varchar(38)` | NO |
| UID_DPRShell | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| CheckUpdates | `bit` | YES |
| Description | `nvarchar(1024)` | YES |
| DisplayName | `nvarchar(256)` | YES |
| HashThreshold | `int` | YES |
| Name | `nvarchar(256)` | NO |
| NameFormat | `nvarchar(32)` | YES |
| SerializationBag | `nvarchar(MAX)` | YES |
| UID_DPRSchema | `varchar(38)` | NO |
| UID_QBMClrType | `varchar(38)` | NO |
| UID_HierarchyFilterQBMClrType | `varchar(38)` | YES |
| HierarchyFilter | `varchar(MAX)` | YES |

### DPRSystemScopeFilter  (17 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRSystemScopeFilter | `varchar(38)` | NO |
| UID_DPRSystemScope | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| Description | `nvarchar(1024)` | YES |
| DisplayName | `nvarchar(256)` | YES |
| Filter | `nvarchar(MAX)` | YES |
| Name | `nvarchar(256)` | NO |
| NameFormat | `nvarchar(32)` | YES |
| SerializationBag | `nvarchar(MAX)` | YES |
| UID_DPRSchemaType | `varchar(38)` | NO |
| UID_FilterQBMClrType | `varchar(38)` | YES |
| UID_QBMClrType | `varchar(38)` | NO |

### DPRSystemSyncDependency  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRSystemSyncDependency | `varchar(38)` | NO |
| UID_DialogTablePrior | `varchar(38)` | NO |
| UID_DialogTable | `varchar(38)` | NO |
| DependencyType | `int` | YES |
| Name | `nvarchar(256)` | NO |
| Description | `nvarchar(1024)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |

### DPRSystemVariable  (10 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRSystemVariable | `varchar(38)` | NO |
| Name | `nvarchar(256)` | YES |
| DisplayName | `nvarchar(256)` | YES |
| NameFormat | `nvarchar(32)` | YES |
| Value | `nvarchar(MAX)` | YES |
| Description | `nvarchar(1024)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| UID_DPRSystemVariableSet | `varchar(38)` | NO |
| UID_QBMClrType | `varchar(38)` | NO |
| IsSecret | `bit` | YES |
| IsSystemVariable | `bit` | YES |
| GenerateValueScript | `nvarchar(MAX)` | YES |
| ScriptLanguage | `nvarchar(16)` | YES |

### DPRSystemVariableSet  (5 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRSystemVariableSet | `varchar(38)` | NO |
| Name | `nvarchar(256)` | YES |
| DisplayName | `nvarchar(256)` | YES |
| NameFormat | `nvarchar(32)` | YES |
| Description | `nvarchar(1024)` | YES |
| UID_DPRShell | `varchar(38)` | YES |
| UID_DPRSystemVariableSetParent | `varchar(38)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| UID_QBMClrType | `varchar(38)` | NO |

### DPRTemplate  (18 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DPRTemplate | `varchar(38)` | NO |
| ConnectedSystemSubType | `nvarchar(256)` | YES |
| DisplayName | `nvarchar(256)` | YES |
| Description | `nvarchar(1024)` | YES |
| ScriptCode | `nvarchar(MAX)` | YES |
| ScriptLanguage | `nvarchar(16)` | NO |
| ConnectedSystem | `nvarchar(32)` | NO |
| ConnectedSystemVersion | `varchar(256)` | NO |
| TemplateType | `nvarchar(32)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| IsGenerated | `bit` | YES |
| SupportedScriptLanguages | `nvarchar(32)` | NO |
| Revision | `int` | YES |
| SortOrder | `int` | YES |

### DynamicGroup  (13 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DynamicGroup | `varchar(38)` | NO |
| UID_DialogTableObjectClass | `varchar(38)` | YES |
| UID_DialogSchedule | `varchar(38)` | YES |
| DisplayName | `nvarchar(256)` | YES |
| WhereClause | `nvarchar(MAX)` | YES |
| Description | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| WhereClauseAddOn | `nvarchar(MAX)` | YES |
| XObjectKey | `varchar(138)` | NO |
| ObjectKeyBaseTree | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| IsRecalculationDeactivated | `bit` | YES |
| IsCalculateImmediately | `bit` | YES |

### DynamicGroupHasImmediateColumn  (22 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DynamicGroupHasImmediate | `varchar(38)` | NO |
| UID_DynamicGroup | `varchar(38)` | NO |
| ObjectKeyDialogColumn | `varchar(138)` | NO |
| IsInActive | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### ESet  (31 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ESet | `varchar(38)` | NO |
| DisplayName | `nvarchar(255)` | YES |
| Ident_ESet | `nvarchar(256)` | YES |
| IsForITShop | `bit` | YES |
| IsITShopOnly | `bit` | YES |
| IsInActive | `bit` | YES |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XMarkedForDeletion | `int` | YES |
| Commentary | `nvarchar(256)` | YES |
| CustomDate01 | `datetime` | YES |
| CustomDate02 | `datetime` | YES |
| CustomFreetext01 | `nvarchar(MAX)` | YES |
| CustomFreetext02 | `nvarchar(MAX)` | YES |
| CustomFreetext03 | `nvarchar(MAX)` | YES |
| CustomProperty01 | `nvarchar(64)` | YES |
| CustomProperty02 | `nvarchar(64)` | YES |
| CustomProperty03 | `nvarchar(64)` | YES |
| CustomProperty04 | `nvarchar(64)` | YES |
| CustomProperty05 | `nvarchar(64)` | YES |
| CustomProperty06 | `nvarchar(64)` | YES |
| CustomProperty07 | `nvarchar(64)` | YES |
| CustomProperty08 | `nvarchar(64)` | YES |
| CustomProperty09 | `nvarchar(64)` | YES |
| CustomProperty10 | `nvarchar(64)` | YES |
| CustomProperty11 | `nvarchar(64)` | YES |
| CustomProperty12 | `nvarchar(64)` | YES |
| CustomProperty13 | `nvarchar(64)` | YES |
| Description | `nvarchar(MAX)` | YES |
| InternalProductName | `nvarchar(64)` | YES |
| ReleaseDate | `datetime` | YES |
| Remarks | `nvarchar(MAX)` | YES |
| RiskIndexCalculated | `float` | YES |
| UID_AccProduct | `varchar(38)` | YES |
| UID_ESetType | `varchar(38)` | YES |
| UID_PersonResponsible | `varchar(38)` | YES |

### ESetCollection  (31 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ESet | `varchar(38)` | NO |
| UID_ESetChild | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |

### ESetExcludesESet  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ESet | `varchar(38)` | NO |
| UID_ESetExcluded | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### ESetHasEntitlement  (5 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ESetHasEntitlement | `varchar(38)` | NO |
| UID_ESet | `varchar(38)` | NO |
| Entitlement | `varchar(138)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### ESetType  (2 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ESetType | `varchar(38)` | NO |
| Ident_ESetType | `nvarchar(64)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| Description | `nvarchar(MAX)` | YES |
| XMarkedForDeletion | `int` | YES |

### EX0ActiveSyncMBPolicy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0ActiveSyncMBPolicy | `varchar(38)` | NO |
| UID_EX0Organization | `varchar(38)` | NO |
| Name | `nvarchar(64)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| PasswordHistory | `int` | YES |
| DevicePasswordEnabled | `bit` | YES |
| AlphaNumericPasswordRequired | `bit` | YES |
| PasswordRecoveryEnabled | `bit` | YES |
| DeviceEncryptionEnabled | `bit` | YES |
| AllowSimplePassword | `bit` | YES |
| AllowNonProvisionableDevices | `bit` | YES |
| AttachementsEnabled | `bit` | YES |
| MaxAttachmentSize | `int` | YES |
| UNCAccessEnabled | `bit` | YES |
| WSSAccessEnabled | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| ObjectGUID | `varchar(36)` | YES |
| PasswordExpiration | `bigint` | YES |
| MaxInactivityTimeDeviceLock | `bigint` | YES |
| MinPasswordLength | `int` | YES |
| MaxPasswordFailedAttempts | `bigint` | YES |
| IsDefault | `bit` | YES |

### EX0AddrBookPolicy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0AddrBookPolicy | `varchar(38)` | NO |
| PolicyName | `nvarchar(64)` | YES |
| DistinguishedName | `nvarchar(1000)` | YES |
| ObjectGUID | `varchar(36)` | YES |
| AdminDisplayName | `nvarchar(128)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| UID_EX0Organization | `varchar(38)` | YES |

### EX0AddrList  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0AddrList | `varchar(38)` | NO |
| UID_EX0Organization | `varchar(38)` | NO |
| Name | `nvarchar(64)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| LDAPRecipientFilter | `nvarchar(MAX)` | YES |
| AdminDescription | `nvarchar(512)` | YES |
| ObjectGUID | `varchar(36)` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| UID_ParentAddressList | `varchar(38)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RecipientFilter | `nvarchar(MAX)` | YES |
| IncludeAllRecipients | `bit` | YES |
| IncludeMailBoxUsers | `bit` | YES |
| IncludeMailUsers | `bit` | YES |
| IncludeNone | `bit` | YES |
| IncludeMailContacts | `bit` | YES |
| IncludeMailGroups | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| IsGlobalAddressList | `bit` | YES |
| DisplayName | `nvarchar(256)` | YES |
| UID_ADSContainerRecipient | `varchar(38)` | YES |
| IncludeResources | `bit` | YES |

### EX0AddrListEntry  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0AddrListEntry | `varchar(38)` | NO |
| UID_EX0AddrList | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| ObjectKeyEntry | `varchar(138)` | NO |

### EX0AddrListInEX0OfflAddrBook  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0AddrList | `varchar(38)` | NO |
| UID_EX0OfflAddrBook | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### EX0DAG  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0DAG | `varchar(38)` | NO |
| UID_EX0Organization | `varchar(38)` | NO |
| Ident_EX0DAG | `nvarchar(256)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| ObjectGUID | `varchar(40)` | YES |
| AdminDisplayName | `nvarchar(256)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### EX0DL  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0DL | `varchar(38)` | NO |
| UID_EX0ExpansionServer | `varchar(38)` | YES |
| UID_ADSGroup | `varchar(38)` | NO |
| SimpleDisplayName | `nvarchar(MAX)` | YES |
| EmailAddressPolicyEnabled | `bit` | YES |
| HiddenFromAddressListsEnabled | `bit` | YES |
| Alias | `nvarchar(64)` | YES |
| MemberJoinRestriction | `int` | YES |
| MemberDepartRestriction | `int` | YES |
| RequireSenderAuthentication | `bit` | YES |
| ModerationEnabled | `bit` | YES |
| SendModerationNotifications | `int` | YES |
| EmailAddresses | `nvarchar(MAX)` | YES |
| ReportToManagerEnabled | `bit` | YES |
| ReportToOriginatorEnabled | `bit` | YES |
| SendOofMessageToOriginator | `bit` | YES |
| DistinguishedName | `nvarchar(1000)` | YES |
| CanonicalName | `nvarchar(1000)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| UID_EX0Organization | `varchar(38)` | NO |
| MaxSendSize | `bigint` | YES |
| MaxReceiveSize | `bigint` | YES |
| XDateSubItem | `datetime` | YES |
| RecipientType | `nvarchar(64)` | YES |
| RecipientTypeDetails | `nvarchar(64)` | YES |
| IsHierarchicalGroup | `bit` | YES |
| SeniorityIndex | `bigint` | YES |
| PhoneticDisplayName | `nvarchar(256)` | YES |

### EX0DLAcceptRcpt  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0DLAcceptRcpt | `varchar(38)` | NO |
| UID_EX0DL | `varchar(38)` | NO |
| ObjectKeyAccepted | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### EX0DLByPassMod  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0DLByPassMod | `varchar(38)` | NO |
| UID_EX0DL | `varchar(38)` | NO |
| ObjectKeyBypassModFor | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### EX0DLCoManagedBy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0DLCoManagedBy | `varchar(38)` | NO |
| UID_EX0DL | `varchar(38)` | NO |
| ObjectKeyCoManager | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### EX0DLModBy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0DLModBy | `varchar(38)` | NO |
| UID_EX0DL | `varchar(38)` | NO |
| ObjectKeyModerator | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### EX0DLRejectRcpt  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0DLRejectRcpt | `varchar(38)` | NO |
| UID_EX0DL | `varchar(38)` | NO |
| ObjectKeyRejected | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### EX0DLSendAsPerm  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0DLSendAsPerm | `varchar(38)` | NO |
| UID_EX0DL | `varchar(38)` | NO |
| ObjectKeyPrincipalCanSendAs | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### EX0DLSendOnBehalfPerm  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0DLSendOnBehalfPerm | `varchar(38)` | NO |
| UID_EX0DL | `varchar(38)` | NO |
| ObjectKeyCanSendOnBehalfOf | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### EX0DynDL  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0DynDL | `varchar(38)` | NO |
| UID_EX0ExpansionServer | `varchar(38)` | YES |
| UID_ADSContainer | `varchar(38)` | YES |
| UID_ADSDomain | `varchar(38)` | NO |
| DistinguishedName | `nvarchar(1000)` | YES |
| CanonicalName | `nvarchar(1000)` | YES |
| Name | `nvarchar(64)` | YES |
| ObjectGUID | `varchar(40)` | YES |
| WindowsEmailAddress | `nvarchar(256)` | YES |
| DisplayName | `nvarchar(128)` | YES |
| SimpleDisplayName | `nvarchar(MAX)` | YES |
| EmailAddressPolicyEnabled | `bit` | YES |
| HiddenFromAddressListsEnabled | `bit` | YES |
| Alias | `nvarchar(64)` | YES |
| RequireSenderAuthentication | `bit` | YES |
| EmailAddresses | `nvarchar(MAX)` | YES |
| ReportToManagerEnabled | `bit` | YES |
| ReportToOriginatorEnabled | `bit` | YES |
| SendOofMessageToOriginator | `bit` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| UID_EX0Organization | `varchar(38)` | NO |
| UID_ADSContainerRecipient | `varchar(38)` | YES |
| LDAPRecipientFilter | `nvarchar(MAX)` | YES |
| RecipientFilter | `nvarchar(MAX)` | YES |
| IncludeAllRecipients | `bit` | YES |
| IncludeMailBoxUsers | `bit` | YES |
| IncludeResources | `bit` | YES |
| IncludeMailContacts | `bit` | YES |
| IncludeMailUsers | `bit` | YES |
| IncludeMailGroups | `bit` | YES |
| MaxReceiveSize | `bigint` | YES |
| IncludeNone | `bit` | YES |

### EX0DynDLAcceptRcpt  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0DynDLAcceptRcpt | `varchar(38)` | NO |
| UID_EX0DynDL | `varchar(38)` | NO |
| ObjectKeyAccepted | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### EX0DynDLInEX0DL  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0DL | `varchar(38)` | NO |
| UID_EX0DynDL | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### EX0DynDLRejectRcpt  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0DynDLRejectRcpt | `varchar(38)` | NO |
| UID_EX0DynDL | `varchar(38)` | NO |
| ObjectKeyRejected | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### EX0DynDLSendOnBehalfPerm  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0DynDLSendOnBehalfPerm | `varchar(38)` | NO |
| UID_EX0DynDL | `varchar(38)` | NO |
| ObjectKeyCanSendOnBehalfOf | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### EX0MailBox  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0MailBox | `varchar(38)` | NO |
| UID_Person | `varchar(38)` | YES |
| UID_TSBAccountDef | `varchar(38)` | YES |
| UID_TSBBehavior | `varchar(38)` | YES |
| UID_ADSAccountLinkedMaster | `varchar(38)` | YES |
| UID_ADSAccount | `varchar(38)` | NO |
| AddAdditionalResponse | `bit` | YES |
| AdditionalResponse | `nvarchar(MAX)` | YES |
| AddOrganizerToSubject | `bit` | YES |
| AllBookInPolicy | `bit` | YES |
| AllowConflicts | `bit` | YES |
| AllowRecurringMeetings | `bit` | YES |
| AllRequestInPolicy | `bit` | YES |
| AllRequestOutOfPolicy | `bit` | YES |
| ArchiveName | `nvarchar(256)` | YES |
| EmailAddressPolicyEnabled | `bit` | YES |
| BookingWindowInDays | `int` | YES |
| ConflictPercentageAllowed | `int` | YES |
| ItemCount | `int` | YES |
| DeleteAttachments | `bit` | YES |
| DeleteComments | `bit` | YES |
| DeleteNonCalendarItems | `bit` | YES |
| DeleteSubject | `bit` | YES |
| DeliverToMailBoxAndForward | `bit` | YES |
| SimpleDisplayName | `nvarchar(MAX)` | YES |
| legacyExchangeDN | `nvarchar(255)` | YES |
| ExchangeGuid | `varchar(40)` | YES |
| Alias | `nvarchar(64)` | YES |
| MaximumConflictInstances | `int` | YES |
| MaximumDurationInMinutes | `int` | YES |
| RemovePrivateProperty | `bit` | YES |
| RetentionComment | `nvarchar(400)` | YES |
| RetentionUrl | `nvarchar(400)` | YES |
| DistinguishedName | `nvarchar(1000)` | YES |
| CanonicalName | `nvarchar(1000)` | YES |
| UID_EX0MailBoxDatabaseArchive | `varchar(38)` | YES |
| UID_EX0MailBoxDatabase | `varchar(38)` | YES |
| UID_EX0ActiveSyncMBPolicy | `varchar(38)` | YES |
| UID_EX0RoleAssignPolicy | `varchar(38)` | YES |
| UID_EX0SharingPolicy | `varchar(38)` | YES |
| UID_EX0RetentionPolicy | `varchar(38)` | YES |
| ArchiveGuid | `varchar(40)` | YES |
| EndDateForRetentionHold | `datetime` | YES |
| StartDateForRetentionHold | `datetime` | YES |
| RetentionHoldEnabled | `bit` | YES |
| EnforceSchedulingHorizon | `bit` | YES |
| ForwardRequestsToDelegates | `bit` | YES |
| RetainDeletedItemsUntilBackup | `bit` | YES |
| IsArchiveEnabled | `bit` | YES |
| LitigationHoldEnabled | `bit` | YES |
| IsLocked | `bit` | YES |
| ProcessExternalMeetingMsg | `bit` | YES |
| RemoveForwardedMeetingNtfy | `bit` | YES |
| RemoveOldMeetingMsg | `bit` | YES |
| TentativePendingApproval | `bit` | YES |
| RecipientTypeDetails | `varchar(64)` | YES |
| UseDatabaseQuotaDefaults | `bit` | YES |
| ActiveSyncEnabled | `bit` | YES |
| OWAEnabled | `bit` | YES |
| PopEnabled | `bit` | YES |
| ImapEnabled | `bit` | YES |
| MapiEnabled | `bit` | YES |
| HiddenFromAddressListsEnabled | `bit` | YES |
| RecipientLimits | `int` | YES |
| OrganizerInfo | `bit` | YES |
| EmailAddresses | `nvarchar(MAX)` | YES |
| ScheduleOnlyDuringWorkHours | `bit` | YES |
| ObjectKeyForwardingAddress | `varchar(138)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| UID_EX0Organization | `varchar(38)` | NO |
| AddNewRequestsTentatively | `bit` | YES |
| RequireSenderAuthEnabled | `bit` | YES |
| UID_EX0ManagedFolderPolicy | `varchar(38)` | YES |
| RetainDeletedItemsFor | `bigint` | YES |
| ResourceCapacity | `int` | YES |
| MaxSendSize | `bigint` | YES |
| MaxReceiveSize | `bigint` | YES |
| ProhibitSendReceiveQuota | `bigint` | YES |
| ProhibitSendQuota | `bigint` | YES |
| ArchiveQuota | `bigint` | YES |
| IssueWarningQuota | `bigint` | YES |
| TotalItemSize | `bigint` | YES |
| ArchiveWarningQuota | `bigint` | YES |
| AutomateProcessing | `nvarchar(32)` | YES |
| UseDatabaseRetentionDefaults | `bit` | YES |
| FldHrchyChildCountWarnQuota | `bigint` | YES |
| FldHrchyChildCountRcvQuota | `bigint` | YES |
| FldHrchyDepthRcvQuota | `bigint` | YES |
| FldHrchyDepthWrnQuota | `bigint` | YES |
| DmpMsgPerFldCountRcvQuota | `bigint` | YES |
| DmpMsgPerFldCountWrnQuota | `bigint` | YES |
| XDateSubItem | `datetime` | YES |
| UID_EX0OwaMailboxPolicy | `varchar(38)` | YES |
| UID_EX0AddrBookPolicy | `varchar(38)` | YES |
| IsSingleItemRecoveryEnabled | `bit` | YES |
| NeverConnectToPerson | `int` | YES |
| IsNeverConnectManual | `bit` | YES |
| SeniorityIndex | `bigint` | YES |
| PhoneticDisplayName | `nvarchar(256)` | YES |

### EX0MailBoxAcceptRcpt  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0MailBoxAcceptRcpt | `varchar(38)` | NO |
| UID_EX0MailBox | `varchar(38)` | NO |
| ObjectKeyAccepted | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### EX0MailBoxBookInPerm  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0MailBoxBookInPerm | `varchar(38)` | NO |
| UID_EX0MailBox | `varchar(38)` | NO |
| ObjectKeyCanBookIn | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### EX0MailBoxDatabase  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0MailBoxDatabase | `varchar(38)` | NO |
| UID_EX0OfflAddrBook | `varchar(38)` | YES |
| UID_EX0PublicFolderDatabase | `varchar(38)` | YES |
| UID_EX0StorageGroup | `varchar(38)` | YES |
| MailBoxRetention | `bigint` | YES |
| DeletedItemRetention | `bigint` | YES |
| EDBFilePath | `nvarchar(MAX)` | YES |
| RetainDeletedItemsUntilBackup | `bit` | YES |
| ProhibitSendReceiveQuota | `bigint` | YES |
| Name | `nvarchar(64)` | YES |
| ProhibitSendQuota | `bigint` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| AdminDescription | `nvarchar(512)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| QuotaNotificationSchedule | `nvarchar(MAX)` | YES |
| MaintenanceSchedule | `nvarchar(MAX)` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| ObjectGUID | `varchar(36)` | YES |
| IsCircularLoggingEnabled | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| ObjectKeyJournalRcpt | `varchar(138)` | YES |
| IsMounted | `bit` | YES |
| UID_EX0Organization | `varchar(38)` | NO |
| IssueWarningQuota | `bigint` | YES |
| ObjectKeySrvOrDAG | `varchar(138)` | YES |
| MasterType | `nvarchar(64)` | YES |
| IsRecovery | `bit` | YES |
| IsExcludedFromProvisioning | `bit` | YES |
| IsSuspendedFromProvisioning | `bit` | YES |

### EX0MailBoxDatabaseOnEX0Server  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0MailBoxDatabase | `varchar(38)` | NO |
| UID_EX0Server | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### EX0MailboxFullAccessPerm  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0MailboxFullAccessPerm | `varchar(38)` | NO |
| UID_EX0MailBox | `varchar(38)` | NO |
| ObjectKeyPrincipalFullAccess | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### EX0MailBoxRejectRcpt  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0MailBoxRejectRcpt | `varchar(38)` | NO |
| UID_EX0MailBox | `varchar(38)` | NO |
| ObjectKeyRejected | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### EX0MailBoxReqInPolPerm  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0MailBoxReqInPolPerm | `varchar(38)` | NO |
| UID_EX0MailBox | `varchar(38)` | NO |
| ObjectKeyCanReqInPolicy | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### EX0MailBoxReqOutOfPolPerm  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0MailBoxReqOutOfPolPerm | `varchar(38)` | NO |
| UID_EX0MailBox | `varchar(38)` | NO |
| ObjectKeyReqOutOfPolicy | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### EX0MailboxSendAsPerm  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0MailboxSendAsPerm | `varchar(38)` | NO |
| UID_EX0MailBox | `varchar(38)` | NO |
| ObjectKeyPrincipalCanSendAs | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### EX0MailBoxSendOnBehalfPerm  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0MailBoxSendOnBehalfPerm | `varchar(38)` | NO |
| UID_EX0MailBox | `varchar(38)` | NO |
| ObjectKeyCanSendOnBehalfOf | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### EX0MailContact  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0MailContact | `varchar(38)` | NO |
| UID_Person | `varchar(38)` | YES |
| UID_TSBBehavior | `varchar(38)` | YES |
| UID_TSBAccountDef | `varchar(38)` | YES |
| UID_ADSContact | `varchar(38)` | NO |
| ExternalEmailAddress | `nvarchar(1024)` | YES |
| ExternalEmailAddressType | `nvarchar(64)` | YES |
| SimpleDisplayName | `nvarchar(MAX)` | YES |
| EmailAddresses | `nvarchar(MAX)` | YES |
| HiddenFromAddressListsEnabled | `bit` | YES |
| UseMapiRichTextFormat | `int` | YES |
| EmailAddressPolicyEnabled | `bit` | YES |
| Alias | `nvarchar(64)` | YES |
| DistinguishedName | `nvarchar(1000)` | YES |
| CanonicalName | `nvarchar(1000)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| UID_EX0Organization | `varchar(38)` | NO |
| MaxReceiveSize | `bigint` | YES |
| RequireSenderAuthEnabled | `bit` | YES |
| MaxSendSize | `bigint` | YES |
| XDateSubItem | `datetime` | YES |
| NeverConnectToPerson | `int` | YES |
| IsNeverConnectManual | `bit` | YES |
| SeniorityIndex | `bigint` | YES |
| PhoneticDisplayName | `nvarchar(256)` | YES |

### EX0MailContactAcceptRcpt  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0MailContactAcceptRcpt | `varchar(38)` | NO |
| UID_EX0MailContact | `varchar(38)` | NO |
| ObjectKeyAccepted | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### EX0MailContactRejectRcpt  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0MailContactRejectRcpt | `varchar(38)` | NO |
| UID_EX0MailContact | `varchar(38)` | NO |
| ObjectKeyRejected | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### EX0MailPFAcceptRcpt  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0MailPFAcceptRcpt | `varchar(38)` | NO |
| UID_EX0MailPublicFolder | `varchar(38)` | NO |
| ObjectKeyAccepted | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### EX0MailPFRejectRcpt  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0MailPFRejectRcpt | `varchar(38)` | NO |
| UID_EX0MailPublicFolder | `varchar(38)` | NO |
| ObjectKeyRejected | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### EX0MailPFSendOnBehalfPerm  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0MailPFSendOnBehalfPerm | `varchar(38)` | NO |
| UID_EX0MailPublicFolder | `varchar(38)` | NO |
| ObjectKeyCanSendOnBehalfOf | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### EX0MailPublicFolder  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0MailPublicFolder | `varchar(38)` | NO |
| UID_EX0Organization | `varchar(38)` | NO |
| UID_EX0PublicFolder | `varchar(38)` | YES |
| UID_ADSContainer | `varchar(38)` | YES |
| UID_ADSDomain | `varchar(38)` | YES |
| Name | `nvarchar(128)` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| ObjectGUID | `varchar(36)` | YES |
| DisplayName | `nvarchar(1024)` | YES |
| EmailAddresses | `nvarchar(MAX)` | YES |
| WindowsEmailAddress | `nvarchar(256)` | YES |
| HiddenFromAddressListsEnabled | `bit` | YES |
| SimpleDisplayName | `nvarchar(128)` | YES |
| Alias | `nvarchar(256)` | YES |
| DeliverToMailBoxAndForward | `bit` | YES |
| ObjectKeyForwardingAddress | `varchar(138)` | YES |
| MaxSendSize | `bigint` | YES |
| MaxReceiveSize | `bigint` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### EX0MailUser  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0MailUser | `varchar(38)` | NO |
| UID_Person | `varchar(38)` | YES |
| UID_TSBBehavior | `varchar(38)` | YES |
| UID_TSBAccountDef | `varchar(38)` | YES |
| UID_ADSAccount | `varchar(38)` | NO |
| ExternalEmailAddress | `nvarchar(1024)` | YES |
| ExternalEmailAddressType | `nvarchar(64)` | YES |
| SimpleDisplayName | `nvarchar(MAX)` | YES |
| EmailAddresses | `nvarchar(MAX)` | YES |
| HiddenFromAddressListsEnabled | `bit` | YES |
| UseMapiRichTextFormat | `int` | YES |
| EmailAddressPolicyEnabled | `bit` | YES |
| Alias | `nvarchar(64)` | YES |
| DistinguishedName | `nvarchar(1000)` | YES |
| CanonicalName | `nvarchar(1000)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| RequireSenderAuthEnabled | `bit` | YES |
| MaxSendSize | `bigint` | YES |
| MaxReceiveSize | `bigint` | YES |
| UID_EX0Organization | `varchar(38)` | NO |
| XDateSubItem | `datetime` | YES |
| NeverConnectToPerson | `int` | YES |
| IsNeverConnectManual | `bit` | YES |
| SeniorityIndex | `bigint` | YES |
| PhoneticDisplayName | `nvarchar(256)` | YES |

### EX0MailUserAcceptRcpt  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0MailUserAcceptRcpt | `varchar(38)` | NO |
| UID_EX0MailUser | `varchar(38)` | NO |
| ObjectKeyAccepted | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### EX0MailUserRejectRcpt  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0MailUserRejectRcpt | `varchar(38)` | NO |
| UID_EX0MailUser | `varchar(38)` | NO |
| ObjectKeyRejected | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### EX0ManagedFolderPolicy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0ManagedFolderPolicy | `varchar(38)` | NO |
| UID_EX0Organization | `varchar(38)` | NO |
| Name | `nvarchar(64)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| ObjectGUID | `varchar(36)` | YES |

### EX0OfflAddrBook  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0OfflAddrBook | `varchar(38)` | NO |
| UID_EX0Organization | `varchar(38)` | NO |
| UID_EX0ServerGenerator | `varchar(38)` | YES |
| Name | `nvarchar(64)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| AdminDescription | `nvarchar(512)` | YES |
| ObjectGUID | `varchar(36)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| Schedule | `nvarchar(MAX)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| IsDefault | `bit` | YES |
| IsPublicFolderDistribution | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| Versions | `nvarchar(256)` | YES |

### EX0Organization  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0Organization | `varchar(38)` | NO |
| Name | `nvarchar(64)` | YES |
| DistinguishedName | `nvarchar(512)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| AdminDescription | `nvarchar(512)` | YES |
| IsMixedMode | `bit` | YES |
| legacyExchangeDN | `nvarchar(255)` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| UID_ADSForest | `varchar(38)` | YES |
| ExchangeVersion | `varchar(128)` | YES |
| UID_AERoleOwner | `varchar(38)` | YES |
| NamespaceManagedBy | `nvarchar(16)` | YES |
| UID_EX0DLHABRoot | `varchar(38)` | YES |
| IsHybridConfigurationEnabled | `bit` | YES |
| UID_AADOrganizationOffPrem | `varchar(38)` | YES |

### EX0OwaMailboxPolicy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| Name | `nvarchar(256)` | YES |
| UID_EX0OwaMailboxPolicy | `varchar(38)` | NO |
| Identifier | `nvarchar(256)` | NO |
| DistinguishedName | `nvarchar(400)` | YES |
| ActiveSyncIntegrationIsEnabled | `bit` | YES |
| AllAddressListsIsEnabled | `bit` | YES |
| AllowCpyContactsToDevAddrBook | `bit` | YES |
| CalendarIsEnabled | `bit` | YES |
| ChangePasswordIsEnabled | `bit` | YES |
| ContactsIsEnabled | `bit` | YES |
| DelegateAccessIsEnabled | `bit` | YES |
| DirectFileAccOnPrivComputers | `bit` | YES |
| DirectFileAccOnPubComputers | `bit` | YES |
| DisplayPhotosIsEnabled | `bit` | YES |
| ExplicitLogonIsEnabled | `bit` | YES |
| FacebookIsEnabled | `bit` | YES |
| ForceSaveAttmntFiltering | `bit` | YES |
| ForceWacViewFirstPrivComputer | `bit` | YES |
| ForceWacViewFirstPubComputer | `bit` | YES |
| ForceWRDocVwFirstOnPrivComp | `bit` | YES |
| ForceWRDocVwFirstOnPubComp | `bit` | YES |
| GlobalAddressListIsEnabled | `bit` | YES |
| InstantMessagingIsEnabled | `bit` | YES |
| IRMIsEnabled | `bit` | YES |
| IsDefault | `bit` | YES |
| IsValid | `bit` | YES |
| JournalIsEnabled | `bit` | YES |
| JunkEmailIsEnabled | `bit` | YES |
| LinkedInIsEnabled | `bit` | YES |
| NotesIsEnabled | `bit` | YES |
| OrganizationIsEnabled | `bit` | YES |
| OWALightIsEnabled | `bit` | YES |
| PhoneticSupportIsEnabled | `bit` | YES |
| PlacesIsEnabled | `bit` | YES |
| PredictedActionsIsEnabled | `bit` | YES |
| PremiumClientIsEnabled | `bit` | YES |
| PublicFoldersIsEnabled | `bit` | YES |
| RecoverDeletedItemsIsEnabled | `bit` | YES |
| RemindersAndNotifications | `bit` | YES |
| ReportJunkEmailIsEnabled | `bit` | YES |
| RulesIsEnabled | `bit` | YES |
| SearchFoldersIsEnabled | `bit` | YES |
| SetPhotoIsEnabled | `bit` | YES |
| SignaturesIsEnabled | `bit` | YES |
| SilverlightIsEnabled | `bit` | YES |
| SMimeIsEnabled | `bit` | YES |
| SpellCheckerIsEnabled | `bit` | YES |
| TasksIsEnabled | `bit` | YES |
| TextMessagingIsEnabled | `bit` | YES |
| ThemeSelectionIsEnabled | `bit` | YES |
| UMIntegrationIsEnabled | `bit` | YES |
| UNCAccessOnPrivateComputers | `bit` | YES |
| UNCAccessOnPublicComputers | `bit` | YES |
| UseGB18030 | `bit` | YES |
| UseISO885915 | `bit` | YES |
| UserDiagnosticIsEnabled | `bit` | YES |
| WacOMEXIsEnabled | `bit` | YES |
| WacViewingOnPrivateComputers | `bit` | YES |
| WacViewingOnPublicComputers | `bit` | YES |
| WebRdyDocViewAllSupportedTypes | `bit` | YES |
| WebRdyDocViewOnPrivComputers | `bit` | YES |
| WebRdyDocViewOnPubComputers | `bit` | YES |
| WSSAccessOnPrivateComputers | `bit` | YES |
| WSSAccessOnPublicComputers | `bit` | YES |
| ActionUnknownFileAndMIMETypes | `nvarchar(256)` | YES |
| AdminDisplayName | `nvarchar(256)` | YES |
| AllowOfflineOn | `nvarchar(256)` | YES |
| DefaultTheme | `nvarchar(256)` | YES |
| InstantMessagingType | `nvarchar(256)` | YES |
| OutboundCharset | `nvarchar(256)` | YES |
| SetPhotoURL | `nvarchar(256)` | YES |
| WebPartsFrameOptionsType | `nvarchar(256)` | YES |
| AllowedFileTypes | `nvarchar(MAX)` | YES |
| AllowedMimeTypes | `nvarchar(MAX)` | YES |
| BlockedFileTypes | `nvarchar(MAX)` | YES |
| BlockedMimeTypes | `nvarchar(MAX)` | YES |
| ForceSaveFileTypes | `nvarchar(MAX)` | YES |
| ForceSaveMimeTypes | `nvarchar(MAX)` | YES |
| ObjectClass | `nvarchar(MAX)` | YES |
| WebRdyDocViewSupFileTypes | `nvarchar(MAX)` | YES |
| WebRdyDocViewSupMIMETypes | `nvarchar(MAX)` | YES |
| WebReadyFileTypes | `nvarchar(MAX)` | YES |
| WebReadyMimeTypes | `nvarchar(MAX)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| UID_EX0Organization | `varchar(38)` | NO |

### EX0PublicFolder  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0PublicFolder | `varchar(38)` | NO |
| UID_EX0PublicFolderParent | `varchar(38)` | YES |
| Path | `nvarchar(1024)` | YES |
| Name | `nvarchar(256)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| UID_EX0Organization | `varchar(38)` | NO |
| PerUserReadStateEnabled | `bit` | YES |

### EX0PublicFolderDatabase  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0PublicFolderDatabase | `varchar(38)` | NO |
| UID_EX0StorageGroup | `varchar(38)` | YES |
| cn | `nvarchar(64)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| legacyExchangeDN | `nvarchar(255)` | YES |
| EDBFilePath | `nvarchar(MAX)` | YES |
| ObjectGUID | `varchar(36)` | YES |
| Description | `nvarchar(512)` | YES |
| RetainDeletedItemsUntilBackup | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| UID_EX0Server | `varchar(38)` | YES |
| CircularLoggingEnabled | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| IsMounted | `bit` | YES |
| UID_EX0Organization | `varchar(38)` | NO |
| IssueWarningQuota | `bigint` | YES |
| ItemRetentionPeriod | `bigint` | YES |
| ProhibitPostQuota | `bigint` | YES |
| MaxItemSize | `bigint` | YES |
| ReplicationMessageSize | `bigint` | YES |
| ReplicationPeriod | `bigint` | YES |
| DeletedItemRetention | `bigint` | YES |

### EX0RetentionPolicy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0RetentionPolicy | `varchar(38)` | NO |
| UID_EX0Organization | `varchar(38)` | NO |
| DistinguishedName | `nvarchar(400)` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| ObjectGUID | `varchar(36)` | YES |
| AdminDisplayName | `nvarchar(256)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| Name | `nvarchar(64)` | YES |
| XMarkedForDeletion | `int` | YES |

### EX0RoleAssignPolicy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0RoleAssignPolicy | `varchar(38)` | NO |
| UID_EX0Organization | `varchar(38)` | NO |
| DistinguishedName | `nvarchar(400)` | YES |
| Description | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| AdminDisplayName | `nvarchar(256)` | YES |
| IsDefault | `bit` | YES |
| Name | `nvarchar(64)` | YES |
| XObjectKey | `varchar(138)` | NO |
| ObjectGUID | `varchar(36)` | YES |
| XMarkedForDeletion | `int` | YES |

### EX0Server  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0Server | `varchar(38)` | NO |
| UID_ADSMachine | `varchar(38)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| UID_EX0Organization | `varchar(38)` | NO |
| legacyExchangeDN | `nvarchar(255)` | YES |
| ExchangeVersion | `nvarchar(64)` | YES |
| ServerRole | `nvarchar(1024)` | YES |
| Name | `nvarchar(128)` | YES |

### EX0SharingPolicy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0SharingPolicy | `varchar(38)` | NO |
| Name | `nvarchar(256)` | YES |
| DistinguishedName | `nvarchar(400)` | NO |
| ObjectGUID | `varchar(36)` | YES |
| IsEnabled | `bit` | YES |
| Domains | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| UID_EX0Organization | `varchar(38)` | NO |
| XMarkedForDeletion | `int` | YES |
| IsDefault | `bit` | YES |

### EX0StorageGroup  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EX0StorageGroup | `varchar(38)` | NO |
| UID_EX0Server | `varchar(38)` | YES |
| Name | `nvarchar(64)` | YES |
| LogFolderPath | `nvarchar(MAX)` | YES |
| SystemFolderPath | `nvarchar(MAX)` | YES |
| IsZeroDatabasePagesEnabled | `bit` | YES |
| IsCircularLoggingEnabled | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| LogFileSize | `nvarchar(12)` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| AdminDescription | `nvarchar(512)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| ObjectGUID | `varchar(36)` | YES |
| XMarkedForDeletion | `int` | YES |

### EXHRemoteMailbox  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EXHRemoteMailbox | `varchar(38)` | NO |
| UID_EX0Organization | `varchar(38)` | NO |
| UID_ADSAccount | `varchar(38)` | YES |
| UID_Person | `varchar(38)` | YES |
| UID_TSBAccountDef | `varchar(38)` | YES |
| UID_TSBBehavior | `varchar(38)` | YES |
| Alias | `varchar(64)` | YES |
| CanonicalName | `nvarchar(1000)` | YES |
| DistinguishedName | `nvarchar(1000)` | YES |
| ExchangeGuid | `varchar(40)` | YES |
| HiddenFromAddressListsEnabled | `bit` | YES |
| RequireSenderAuthEnabled | `bit` | YES |
| ImmutableId | `nvarchar(512)` | YES |
| UserPrincipalName | `nvarchar(512)` | YES |
| IsModerationEnabled | `bit` | YES |
| RemoteRecipientType | `nvarchar(512)` | YES |
| RecipientTypeDetails | `nvarchar(64)` | YES |
| RemoteRoutingAddress | `nvarchar(512)` | YES |
| SendModerationNotifications | `varchar(256)` | YES |
| IsArchiveEnabled | `bit` | YES |
| ArchiveName | `nvarchar(256)` | YES |
| ArchiveGuid | `varchar(36)` | YES |
| ArchiveState | `nvarchar(256)` | YES |
| XDateSubItem | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| ADSGuid | `varchar(40)` | YES |
| DisplayName | `nvarchar(256)` | YES |
| UID_AADUser | `varchar(38)` | YES |
| UID_O3EMailbox | `varchar(38)` | YES |
| EmailAddressPolicyEnabled | `bit` | YES |
| EmailAddresses | `nvarchar(MAX)` | YES |
| NeverConnectToPerson | `int` | YES |
| IsNeverConnectManual | `bit` | YES |
| SeniorityIndex | `bigint` | YES |
| PhoneticDisplayName | `nvarchar(256)` | YES |

### EXHRemoteMbxAcceptRcpt  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EXHRemoteMbxAcceptRcpt | `varchar(38)` | NO |
| ObjectKeyAccepted | `varchar(138)` | NO |
| UID_EXHRemoteMailbox | `varchar(38)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### EXHRemoteMbxByPassMod  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EXHRemoteMbxByPassMod | `varchar(38)` | NO |
| ObjectKeyBypassModFor | `varchar(138)` | NO |
| UID_EXHRemoteMailbox | `varchar(38)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### EXHRemoteMbxModBy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EXHRemoteMbxModBy | `varchar(38)` | NO |
| ObjectKeyModBy | `varchar(138)` | NO |
| UID_EXHRemoteMailbox | `varchar(38)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### EXHRemoteMbxRejectRcpt  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_EXHRemoteMbxRejectRcpt | `varchar(38)` | NO |
| ObjectKeyRejected | `varchar(138)` | NO |
| UID_EXHRemoteMailbox | `varchar(38)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### ExtendedAttribute  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ExtendedAttribute | `varchar(38)` | NO |
| Ident_ExtendedAttribute | `nvarchar(64)` | YES |
| Description | `nvarchar(512)` | YES |
| CustomProperty01 | `nvarchar(64)` | YES |
| CustomProperty02 | `nvarchar(64)` | YES |
| CustomProperty03 | `nvarchar(64)` | YES |
| CustomProperty04 | `nvarchar(64)` | YES |
| CustomProperty05 | `nvarchar(64)` | YES |
| CustomProperty06 | `nvarchar(64)` | YES |
| CustomProperty07 | `nvarchar(64)` | YES |
| CustomProperty08 | `nvarchar(64)` | YES |
| CustomProperty09 | `nvarchar(64)` | YES |
| CustomProperty10 | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| UID_ExtendedAttributeGroup | `varchar(38)` | YES |
| LowerLimit | `nvarchar(64)` | YES |
| UpperLimit | `nvarchar(64)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### ExtendedAttributeGroup  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ExtendedAttributeGroup | `varchar(38)` | NO |
| Ident_ExtendedAttributeGroup | `nvarchar(64)` | YES |
| Description | `nvarchar(512)` | YES |
| CustomProperty01 | `nvarchar(64)` | YES |
| CustomProperty02 | `nvarchar(64)` | YES |
| CustomProperty03 | `nvarchar(64)` | YES |
| CustomProperty04 | `nvarchar(64)` | YES |
| CustomProperty05 | `nvarchar(64)` | YES |
| CustomProperty06 | `nvarchar(64)` | YES |
| CustomProperty07 | `nvarchar(64)` | YES |
| CustomProperty08 | `nvarchar(64)` | YES |
| CustomProperty09 | `nvarchar(64)` | YES |
| CustomProperty10 | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### ExtendedAttributeInGroup  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ExtendedAttribute | `varchar(38)` | NO |
| UID_ExtendedAttributeGroup | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### FirmPartner  (3 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_FirmPartner | `varchar(38)` | NO |
| Ident_FirmPartner | `nvarchar(64)` | NO |
| Name1 | `nvarchar(MAX)` | YES |
| Name2 | `nvarchar(64)` | YES |
| Street | `nvarchar(MAX)` | YES |
| City | `nvarchar(64)` | YES |
| ZIPCode | `nvarchar(16)` | YES |
| ShortName | `nvarchar(32)` | YES |
| Phone | `nvarchar(MAX)` | YES |
| Fax | `nvarchar(MAX)` | YES |
| Remarks | `nvarchar(MAX)` | YES |
| CustomerNumber | `nvarchar(32)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| EMail | `nvarchar(256)` | YES |
| FirmPartnerURL | `nvarchar(MAX)` | YES |
| Contact | `nvarchar(MAX)` | YES |
| IsLeasingPartner | `bit` | YES |
| VendorNumber | `nvarchar(64)` | YES |
| IsManufacturer | `bit` | YES |
| IsVendor | `bit` | YES |
| IsPartner | `bit` | YES |
| Building | `nvarchar(32)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| UID_DialogCountry | `varchar(38)` | YES |
| UID_DialogState | `varchar(38)` | YES |
| XMarkedForDeletion | `int` | YES |

### FunctionalArea  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_FunctionalArea | `varchar(38)` | NO |
| Ident_FunctionalArea | `nvarchar(64)` | YES |
| Description | `nvarchar(1024)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| UID_ParentFunctionalArea | `varchar(38)` | YES |
| XMarkedForDeletion | `int` | YES |
| RuleViolationThreshold | `int` | YES |

### Hardware  (1 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Hardware | `varchar(38)` | NO |
| UID_Locality | `varchar(38)` | YES |
| UID_Department | `varchar(38)` | YES |
| UID_ProfitCenter | `varchar(38)` | YES |
| IsPC | `bit` | YES |
| UID_WorkDesk | `varchar(38)` | YES |
| UID_HardwareType | `varchar(38)` | YES |
| LocalityFree | `nvarchar(MAX)` | YES |
| UseDHCP | `bit` | YES |
| DefaultGateway | `varchar(39)` | YES |
| SubnetMask | `nvarchar(16)` | YES |
| UseDNS | `bit` | YES |
| DNSServer1 | `varchar(39)` | YES |
| DNSServer2 | `varchar(39)` | YES |
| DNSServer3 | `varchar(39)` | YES |
| UseWINS | `bit` | YES |
| WINSPrimary | `nvarchar(16)` | YES |
| WINSSecondary | `nvarchar(16)` | YES |
| DNSName | `nvarchar(255)` | YES |
| ScopeID | `nvarchar(32)` | YES |
| DiskCapacity | `int` | YES |
| AdditionalHardware | `nvarchar(MAX)` | YES |
| SerialNumber | `nvarchar(MAX)` | YES |
| DeliveryDate | `datetime` | YES |
| DeliveryNumber | `nvarchar(MAX)` | YES |
| EstablishDate | `datetime` | YES |
| Currency | `nvarchar(32)` | YES |
| Guaranty | `datetime` | YES |
| GuarantyNumber | `nvarchar(MAX)` | YES |
| EndOfUse | `datetime` | YES |
| Remarks | `nvarchar(MAX)` | YES |
| MACID | `nchar(12)` | YES |
| Processor | `nvarchar(MAX)` | YES |
| RAM | `int` | YES |
| HD1 | `int` | YES |
| HD2 | `int` | YES |
| RemoteBoot | `bit` | YES |
| GraphicsType | `nvarchar(MAX)` | YES |
| FloppyDrive | `bit` | YES |
| FloppyDriveLocked | `bit` | YES |
| CDDrive | `bit` | YES |
| StreamerDrive | `bit` | YES |
| Typ | `nvarchar(MAX)` | YES |
| Frequency | `int` | YES |
| NetConnector | `nvarchar(MAX)` | YES |
| Inventory | `nvarchar(MAX)` | YES |
| BuyDate | `datetime` | YES |
| RemoteBootType | `nchar(3)` | YES |
| AssetNumber | `nvarchar(MAX)` | YES |
| TokenRingNumber | `nvarchar(32)` | YES |
| MainBoard | `nvarchar(MAX)` | YES |
| BIOSName | `nvarchar(MAX)` | YES |
| BIOSVersion | `nvarchar(MAX)` | YES |
| CPUCount | `int` | YES |
| Category | `nvarchar(MAX)` | YES |
| NETConnectorType | `nvarchar(MAX)` | YES |
| GraphicChip | `nvarchar(MAX)` | YES |
| ScreenSize | `int` | YES |
| TransferRate | `int` | YES |
| DriveLetter | `nvarchar(20)` | YES |
| ScanSizeX | `int` | YES |
| ScanSizeY | `int` | YES |
| MaxXResolution | `int` | YES |
| MaxYResolution | `int` | YES |
| HardwareLabel | `nvarchar(MAX)` | YES |
| ConnectType | `nvarchar(MAX)` | YES |
| IsColour | `bit` | YES |
| MAXDisplayBitsPerPel | `int` | YES |
| FileSystem | `nvarchar(MAX)` | YES |
| CountKeys | `int` | YES |
| ChangeMedium | `bit` | YES |
| Description | `nvarchar(MAX)` | YES |
| UID_FirmPartnerVendor | `varchar(38)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| IsDuplex | `bit` | YES |
| PagesPerMinute | `int` | YES |
| UID_ParentHardware | `varchar(38)` | YES |
| Ident_Hardwarelist | `nvarchar(64)` | YES |
| IsLocalPeripher | `bit` | YES |
| CustomProperty01 | `nvarchar(64)` | YES |
| CustomProperty02 | `nvarchar(64)` | YES |
| CustomProperty03 | `nvarchar(64)` | YES |
| CustomProperty04 | `nvarchar(64)` | YES |
| CustomProperty05 | `nvarchar(64)` | YES |
| CustomProperty06 | `nvarchar(64)` | YES |
| CustomProperty07 | `nvarchar(64)` | YES |
| CustomProperty08 | `nvarchar(64)` | YES |
| CustomProperty09 | `nvarchar(64)` | YES |
| CustomProperty10 | `nvarchar(64)` | YES |
| DVDDrive | `bit` | YES |
| IsModemBuiltIn | `bit` | YES |
| IsLeasingAsset | `bit` | YES |
| UID_FirmPartnerOwner | `varchar(38)` | YES |
| IsServer | `bit` | YES |
| PaperSize | `nvarchar(MAX)` | YES |
| AssetIdent | `nvarchar(MAX)` | YES |
| RentCharge | `int` | YES |
| AssetActivate | `datetime` | YES |
| AssetDeActivate | `datetime` | YES |
| AssetValueNew | `int` | YES |
| AssetValueCurrent | `int` | YES |
| AssetOwnership | `bit` | YES |
| AssetReceiptNumber | `nvarchar(MAX)` | YES |
| AssetPSP | `int` | YES |
| AssetInventory | `datetime` | YES |
| AssetInventoryText | `nvarchar(MAX)` | YES |
| AssetDeliveryRemarks | `nvarchar(MAX)` | YES |
| AssetPSPChar | `nvarchar(12)` | YES |
| OperatingSystemHotfix | `nvarchar(MAX)` | YES |
| OperatingSystemServicePack | `nvarchar(MAX)` | YES |
| OperatingSystemVersion | `nvarchar(MAX)` | YES |
| UID_FirmPartnerManufacturer | `varchar(38)` | YES |
| OperatingSystem | `nvarchar(MAX)` | YES |
| printMaxResolutionSupported | `int` | YES |
| DisplayName | `nvarchar(255)` | YES |
| InHouseCharge | `int` | YES |
| AssetAmortizationMonth | `int` | YES |
| PurchasePrice | `float` | YES |
| SalesPrice | `float` | YES |
| InternalPrice | `float` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| IsNoInherite | `bit` | YES |
| UID_ADSCountryCode | `varchar(38)` | YES |
| UID_HardwareVMHost | `varchar(38)` | YES |
| IsVMClient | `bit` | YES |
| IsVMHost | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| UID_AssetClass | `varchar(38)` | YES |
| UID_AssetType | `varchar(38)` | YES |
| UID_HardwareState | `varchar(38)` | YES |
| UID_Investment | `varchar(38)` | YES |
| IPV4 | `varchar(15)` | YES |
| IPV6 | `varchar(39)` | YES |
| Phone | `nvarchar(64)` | YES |
| UID_PersonOwner | `varchar(38)` | YES |
| Carrier | `nvarchar(64)` | YES |
| IMEI | `nvarchar(18)` | YES |
| ICCIC | `nvarchar(24)` | YES |
| ImportSource | `varchar(32)` | YES |
| UID_Org | `varchar(38)` | YES |
| DNSHostName | `nvarchar(64)` | YES |
| NetBootMachineFilePath | `nvarchar(MAX)` | YES |

### HardwareInBaseTree  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Org | `varchar(38)` | NO |
| UID_Hardware | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |

### HardwareState  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_HardwareState | `varchar(38)` | NO |
| Ident_HardwareState | `nvarchar(64)` | NO |
| ShortDescription | `nvarchar(64)` | YES |
| Description | `nvarchar(1024)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### HardwareType  (7 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_HardwareType | `varchar(38)` | NO |
| UID_AccProduct | `varchar(38)` | YES |
| UID_PersonPurchase | `varchar(38)` | YES |
| Ident_HardwareType | `nvarchar(64)` | NO |
| Ident_HardwareBasicType | `nvarchar(32)` | NO |
| Description | `nvarchar(MAX)` | YES |
| IsLocalPeripher | `bit` | YES |
| ManufacturerURL | `nvarchar(MAX)` | YES |
| UID_FirmPartner | `varchar(38)` | YES |
| UID_FirmPartnerDefaultVendor | `varchar(38)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| IsPC | `bit` | YES |
| IsServer | `bit` | YES |
| GuarantyMonths | `int` | YES |
| GuarantyMonthsAdditional | `int` | YES |
| UsageMonths | `int` | YES |
| StockMin | `int` | YES |
| StockLimit | `int` | YES |
| UID_HardwareTypeAlternate | `varchar(38)` | YES |
| ArticleCode | `nvarchar(64)` | YES |
| OrderUnit | `nvarchar(32)` | YES |
| OrderQuantityMin | `int` | YES |
| LastOfferDate | `datetime` | YES |
| LastOfferPrice | `int` | YES |
| LastDeliverDate | `datetime` | YES |
| LastDeliverPrice | `int` | YES |
| AdditionalInformation | `nvarchar(MAX)` | YES |
| XTouched | `nchar(1)` | YES |
| IsInActive | `bit` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### HelperAttestationPolicy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_HelperAttestationPolicy | `varchar(38)` | NO |
| ObjectKeyBase | `varchar(138)` | NO |
| UID_AttestationPolicy | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| DisplayName | `nvarchar(256)` | YES |

### HelperHardwareOrg  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Hardware | `varchar(38)` | NO |
| UID_Org | `varchar(38)` | NO |

### HelperHeadOrg  (6 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_PersonHead | `varchar(38)` | NO |
| UID_Org | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |

### HelperHeadPerson  (29 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_PersonHead | `varchar(38)` | NO |
| UID_Person | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |

### HelperPersonOrg  (26 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Person | `varchar(38)` | NO |
| UID_Org | `varchar(38)` | NO |

### HelperPWOCompliance  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_HelperPWOCompliance | `varchar(38)` | NO |
| UID_PersonWantsOrg | `varchar(38)` | YES |
| UID_Person | `varchar(38)` | YES |
| UID_ComplianceRule | `varchar(38)` | YES |

### HelperPWOPersonHasObject  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_HelperPWOPersonHasObject | `varchar(38)` | NO |
| UID_Person | `varchar(38)` | YES |
| UID_PersonWantsOrg | `varchar(38)` | YES |
| ObjectKey | `varchar(138)` | YES |
| UID_OrgRelated | `varchar(38)` | YES |
| IsExisting | `bit` | YES |
| IsFromSubIdentityOnly | `bit` | YES |

### HelperWorkDeskOrg  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_WorkDesk | `varchar(38)` | NO |
| UID_Org | `varchar(38)` | NO |

### Investment  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Investment | `varchar(38)` | NO |
| Ident_Investment | `nvarchar(64)` | NO |
| Description | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| UID_PersonResponsible | `varchar(38)` | YES |
| InvestmentDate | `datetime` | YES |
| Remarks | `nvarchar(MAX)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### Job  (1,043 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Job | `varchar(38)` | NO |
| UID_QBMServerTag | `varchar(38)` | YES |
| UID_JobChain | `varchar(38)` | YES |
| UID_JobTask | `varchar(38)` | YES |
| Name | `nvarchar(255)` | YES |
| Description | `nvarchar(1023)` | YES |
| GenCondition | `nvarchar(MAX)` | YES |
| Retries | `int` | YES |
| UID_SuccessJob | `varchar(38)` | YES |
| UID_ErrorJob | `varchar(38)` | YES |
| Priority | `int` | YES |
| ServerDetectScript | `nvarchar(MAX)` | YES |
| DeferOnError | `bit` | YES |
| MinutesToDefer | `int` | YES |
| IgnoreErrors | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| ProcessTracking | `int` | YES |
| ProcessDisplay | `nvarchar(MAX)` | YES |
| ProcessInfoLevel | `int` | YES |
| IsSplitOnly | `bit` | YES |
| ErrorNotify | `bit` | YES |
| NotifyAddress | `nvarchar(MAX)` | YES |
| NotifySubject | `nvarchar(MAX)` | YES |
| NotifyBody | `nvarchar(MAX)` | YES |
| NotifySender | `nvarchar(MAX)` | YES |
| SuccessNotify | `bit` | YES |
| NotifyAddressSuccess | `nvarchar(MAX)` | YES |
| NotifySubjectSuccess | `nvarchar(MAX)` | YES |
| NotifyBodySuccess | `nvarchar(MAX)` | YES |
| NotifySenderSuccess | `nvarchar(MAX)` | YES |
| XTouched | `nchar(1)` | YES |
| IsToFreezeOnError | `bit` | YES |
| PreProcessorCondition | `nvarchar(255)` | YES |
| PreCode | `nvarchar(MAX)` | YES |
| XObjectKey | `varchar(138)` | NO |
| IsErrorLogToJournal | `bit` | YES |
| IsDeactivatedByPreProcessor | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| LogMode | `varchar(8)` | YES |
| PriorityDefinition | `nvarchar(MAX)` | YES |
| IsForHistory | `bit` | YES |
| IsNoDBQueueDefer | `bit` | YES |

### JobAutoStart  (36 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_JobAutoStart | `varchar(38)` | NO |
| UID_DialogSchedule | `varchar(38)` | YES |
| Name | `nvarchar(255)` | NO |
| WhereClause | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| Description | `nvarchar(1024)` | YES |
| XObjectKey | `varchar(138)` | NO |
| StopTime | `nchar(8)` | YES |
| ParameterList | `nvarchar(MAX)` | YES |
| XMarkedForDeletion | `int` | YES |
| ObjectKeyTarget | `varchar(138)` | YES |
| UID_QBMEvent | `varchar(38)` | YES |

### JobChain  (559 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_JobChain | `varchar(38)` | NO |
| UID_JobChainCopiedFrom | `varchar(38)` | YES |
| UID_Job | `varchar(38)` | YES |
| Name | `nvarchar(255)` | NO |
| NoGenerate | `bit` | YES |
| GenCondition | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| ProcessTracking | `int` | YES |
| ProcessDisplay | `nvarchar(MAX)` | YES |
| CustomRemarks | `nvarchar(255)` | YES |
| Description | `nvarchar(1023)` | YES |
| LayoutPositions | `nvarchar(MAX)` | YES |
| XTouched | `nchar(1)` | YES |
| PreProcessorCondition | `nvarchar(255)` | YES |
| LimitationCount | `int` | YES |
| PreCode | `nvarchar(MAX)` | YES |
| XObjectKey | `varchar(138)` | NO |
| LimitationWarning | `int` | YES |
| IsDeactivatedByPreProcessor | `bit` | YES |
| UID_DialogTable | `varchar(38)` | NO |
| XMarkedForDeletion | `int` | YES |

### JobComponent  (21 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_JobComponent | `varchar(38)` | NO |
| ComponentClass | `nvarchar(200)` | YES |
| ComponentAssembly | `nvarchar(128)` | YES |
| Description | `nvarchar(1023)` | YES |
| MaxInstance | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| CustomRemarks | `nvarchar(255)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| ConfigOptions | `nvarchar(MAX)` | YES |
| DefaultParameters | `nvarchar(MAX)` | YES |
| XMarkedForDeletion | `int` | YES |
| DisplayName | `nvarchar(256)` | YES |

### JobEventGen  (724 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_JobEventGen | `varchar(38)` | NO |
| UID_JobChain | `varchar(38)` | YES |
| OrderNr | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| ProcessDisplay | `nvarchar(1024)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| UID_QBMEvent | `varchar(38)` | YES |

### JobHistory  (38,185 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_JobHistory | `varchar(38)` | NO |
| UID_Job | `varchar(38)` | NO |
| UID_Tree | `varchar(38)` | NO |
| Queue | `nvarchar(128)` | YES |
| ComponentClass | `nvarchar(200)` | YES |
| ComponentAssembly | `nvarchar(255)` | YES |
| TaskName | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| ParamIN | `nvarchar(MAX)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| Priority | `int` | YES |
| EndedAt | `datetime` | YES |
| StartAt | `datetime` | YES |
| JobChainName | `nvarchar(255)` | YES |
| WasError | `bit` | YES |
| IsRootJob | `bit` | YES |
| UID_JobError | `varchar(38)` | YES |
| UID_JobSuccess | `varchar(38)` | YES |
| XTouched | `nchar(1)` | YES |
| GenProcID | `varchar(38)` | NO |
| UID_JobOrigin | `varchar(38)` | YES |
| BasisObjectKey | `varchar(138)` | YES |
| ErrorMessages | `nvarchar(MAX)` | YES |
| ReadyForDeleteOrExport | `int` | YES |
| LogMode | `varchar(8)` | YES |

### JobParameter  (1,384 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_JobParameter | `varchar(38)` | NO |
| UID_JobTask | `varchar(38)` | NO |
| Name | `nvarchar(255)` | NO |
| ValueTemplateDefault | `nvarchar(1023)` | YES |
| Type | `nvarchar(32)` | YES |
| IsOptional | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| IsCrypted | `bit` | YES |
| IsHidden | `bit` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| Description | `nvarchar(255)` | YES |
| ValueTemplateExample | `nvarchar(MAX)` | YES |
| IsPartialCrypted | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| IsCompressed | `bit` | YES |

### JobPerformance  (31 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_JobPerformance | `varchar(38)` | NO |
| Queue | `nvarchar(128)` | NO |
| ComponentClass | `nvarchar(200)` | NO |
| TaskName | `nvarchar(64)` | NO |
| CountPerMinute | `int` | YES |
| XTouched | `nchar(1)` | YES |

### JobQueue  (5 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Job | `varchar(38)` | NO |
| UID_JobSameServer | `varchar(38)` | YES |
| UID_Tree | `varchar(38)` | NO |
| Queue | `nvarchar(128)` | NO |
| ComponentClass | `nvarchar(200)` | YES |
| ExecutionType | `nvarchar(16)` | YES |
| ComponentAssembly | `nvarchar(255)` | YES |
| TaskName | `nvarchar(64)` | NO |
| ParamIN | `nvarchar(MAX)` | YES |
| Ready2EXE | `nvarchar(32)` | NO |
| StartAt | `datetime` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| Retries | `int` | YES |
| Priority | `int` | YES |
| DeferOnError | `bit` | YES |
| MinutesToDefer | `int` | YES |
| UID_JobError | `varchar(38)` | YES |
| UID_JobSuccess | `varchar(38)` | YES |
| IgnoreErrors | `bit` | YES |
| MaxInstance | `int` | YES |
| JobChainName | `nvarchar(255)` | NO |
| ProcessTracking | `bit` | YES |
| IsSplitOnly | `bit` | YES |
| WasError | `bit` | YES |
| ErrorNotify | `bit` | YES |
| NotifyAddress | `nvarchar(MAX)` | YES |
| NotifySubject | `nvarchar(MAX)` | YES |
| NotifyBody | `nvarchar(MAX)` | YES |
| NotifySender | `nvarchar(MAX)` | YES |
| SuccessNotify | `bit` | YES |
| NotifyAddressSuccess | `nvarchar(MAX)` | YES |
| NotifySubjectSuccess | `nvarchar(MAX)` | YES |
| NotifyBodySuccess | `nvarchar(MAX)` | YES |
| NotifySenderSuccess | `nvarchar(MAX)` | YES |
| IsRootJob | `bit` | YES |
| GenProcID | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| IsToFreezeOnError | `bit` | YES |
| LimitationCount | `int` | YES |
| UID_JobOrigin | `varchar(38)` | YES |
| BasisObjectKey | `varchar(138)` | YES |
| ErrorMessages | `nvarchar(MAX)` | YES |
| LimitationWarning | `int` | YES |
| LogMode | `varchar(8)` | YES |
| IsForHistory | `bit` | YES |
| IsNoDBQueueDefer | `bit` | YES |

### JobQueueStats  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_JobQueueStats | `varchar(38)` | NO |
| Queue | `nvarchar(128)` | YES |
| JobYear | `int` | YES |
| JobMonth | `int` | YES |
| JobDay | `int` | YES |
| JobHour | `int` | YES |
| countInserted | `int` | YES |
| countActivated | `int` | YES |
| countDeleted | `int` | YES |
| XTouched | `nchar(1)` | YES |

### JobRunParameter  (22,313 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Job | `varchar(38)` | NO |
| UID_JobParameter | `varchar(38)` | NO |
| ValueTemplate | `nvarchar(MAX)` | YES |
| Name | `nvarchar(255)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| IsCrypted | `bit` | YES |
| IsHidden | `bit` | YES |
| XObjectKey | `varchar(138)` | NO |
| XTouched | `nchar(1)` | YES |
| IsPartialCrypted | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| IsCompressed | `bit` | YES |

### JobTask  (132 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_JobTask | `varchar(38)` | NO |
| UID_JobComponent | `varchar(38)` | YES |
| TaskName | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| MaxInstance | `int` | YES |
| ExecutionType | `nvarchar(16)` | NO |
| IsEndOfSubTree | `bit` | YES |
| RunningOS | `nvarchar(16)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| Description | `nvarchar(255)` | YES |
| XMarkedForDeletion | `int` | YES |
| IsExclusivePerObject | `bit` | YES |
| IsDBConnectNeeded | `bit` | YES |
| IsNoDBQueueDefer | `bit` | YES |

### JobTreeParamColl  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_JobTreeParamColl | `varchar(38)` | NO |
| UID_Tree | `varchar(38)` | NO |
| ParameterValue | `nvarchar(MAX)` | YES |
| ParameterName | `nvarchar(255)` | NO |
| XTouched | `nchar(1)` | YES |
| IsCrypted | `bit` | YES |
| IsHidden | `bit` | YES |

### MitigatingControl  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_MitigatingControl | `varchar(38)` | NO |
| Ident_MitigatingControl | `nvarchar(64)` | YES |
| Description | `nvarchar(MAX)` | YES |
| SignificancyReduction | `float` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| UID_FunctionalArea | `varchar(38)` | YES |
| UID_Department | `varchar(38)` | YES |
| XMarkedForDeletion | `int` | YES |

### O3EAADUserInUnifiedGroup  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADUser | `varchar(38)` | NO |
| UID_O3EUnifiedGroup | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XIsInEffect | `bit` | YES |
| RiskIndexCalculated | `float` | YES |

### O3EAADUserOwnsUnifiedGroup  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADUser | `varchar(38)` | NO |
| UID_O3EUnifiedGroup | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### O3EAADUserSubscrUnifiedGroup  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_AADUser | `varchar(38)` | NO |
| UID_O3EUnifiedGroup | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### O3EBaseTreeHasDL  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Org | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XIsInEffect | `bit` | YES |
| UID_O3EDL | `varchar(38)` | NO |
| RiskIndexCalculated | `float` | YES |

### O3EBaseTreeHasUnifiedGroup  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Org | `varchar(38)` | NO |
| UID_O3EUnifiedGroup | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XIsInEffect | `bit` | YES |
| RiskIndexCalculated | `float` | YES |

### O3EConAcceptRcpt  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EConAcceptRcpt | `varchar(38)` | NO |
| UID_O3EMailContact | `varchar(38)` | NO |
| ObjectKeyAcceptRcpt | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### O3EConGrantSendOnBehalfTo  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EConGrantSendOnBehalfTo | `varchar(38)` | NO |
| UID_O3EMailContact | `varchar(38)` | NO |
| ObjectKeyGrantSendOnBehalfTo | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### O3EConModBy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EMailContact | `varchar(38)` | NO |
| UID_O3EConModBy | `varchar(38)` | NO |
| ObjectKeyModBy | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### O3EConRejectRcpt  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EConRejectRcpt | `varchar(38)` | NO |
| UID_O3EMailContact | `varchar(38)` | NO |
| ObjectKeyRejectRcpt | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### O3EDL  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EDL | `varchar(38)` | NO |
| XDateSubItem | `datetime` | YES |
| Identifier | `nvarchar(256)` | YES |
| SimpleDisplayName | `nvarchar(256)` | YES |
| Name | `nvarchar(256)` | NO |
| GroupType | `nvarchar(256)` | YES |
| Alias | `nvarchar(256)` | NO |
| BypassNestedModerationEnabled | `bit` | YES |
| MemberJoinRestriction | `nvarchar(256)` | YES |
| MemberDepartRestriction | `nvarchar(256)` | YES |
| ReportToManagerIsEnabled | `bit` | YES |
| SendModerationNotifications | `nvarchar(256)` | YES |
| ReportToOriginatorIsEnabled | `bit` | YES |
| EmailAddresses | `nvarchar(MAX)` | YES |
| SendOofMessageToOriginator | `bit` | YES |
| DisplayName | `nvarchar(400)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| ModerationIsEnabled | `bit` | YES |
| HiddenFromAddressListsEnabled | `bit` | YES |
| RecipientType | `nvarchar(256)` | YES |
| RecipientTypeDetails | `nvarchar(256)` | YES |
| RequireSenderAuth | `bit` | YES |
| WindowsEmailAddress | `nvarchar(256)` | YES |
| ObjectGUID | `varchar(36)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| UID_AADOrganization | `varchar(38)` | NO |
| IsForITShop | `bit` | YES |
| IsITShopOnly | `bit` | YES |
| UID_AccProduct | `varchar(38)` | YES |
| MatchPatternForMembership | `bigint` | YES |
| UID_AADGroup | `varchar(38)` | YES |
| ExternalDirectoryObjectId | `nvarchar(256)` | YES |
| RiskIndex | `float` | YES |
| UNSDisplay | `nvarchar(400)` | YES |
| IsHierarchicalGroup | `bit` | YES |
| SeniorityIndex | `bigint` | YES |
| PhoneticDisplayName | `nvarchar(256)` | YES |

### O3EDLAcceptRcpt  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EDLAcceptRcpt | `varchar(38)` | NO |
| UID_O3EDL | `varchar(38)` | NO |
| ObjectKeyAcceptRcpt | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### O3EDLCollection  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EDLParent | `varchar(38)` | NO |
| UID_O3EDLChild | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| LevelNumber | `int` | YES |
| XMarkedForDeletion | `int` | YES |

### O3EDLGrantSendOnBehalfTo  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EDLGrantSendOnBehalfTo | `varchar(38)` | NO |
| UID_O3EDL | `varchar(38)` | NO |
| ObjectKeyGrantSendOnBehalfTo | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### O3EDLInDL  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EDLParent | `varchar(38)` | NO |
| UID_O3EDLChild | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### O3EDLManagedBy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EDLManagedBy | `varchar(38)` | NO |
| UID_O3EDL | `varchar(38)` | NO |
| ObjectKeyManagedBy | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### O3EDLModBy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EDLModBy | `varchar(38)` | NO |
| UID_O3EDL | `varchar(38)` | NO |
| ObjectKeyModBy | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### O3EDLRejectRcpt  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EDLRejectRcpt | `varchar(38)` | NO |
| UID_O3EDL | `varchar(38)` | NO |
| ObjectKeyRejectRcpt | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### O3EDynDL  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EDynDL | `varchar(38)` | NO |
| XDateSubItem | `datetime` | YES |
| Identifier | `nvarchar(256)` | YES |
| IncludedRecipients | `nvarchar(256)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| Name | `nvarchar(256)` | NO |
| ObjectKeyManagedBy | `varchar(138)` | YES |
| ObjectGUID | `varchar(36)` | YES |
| WindowsEmailAddress | `nvarchar(256)` | YES |
| RecipientFilterType | `nvarchar(256)` | YES |
| DisplayName | `nvarchar(400)` | YES |
| SimpleDisplayName | `nvarchar(256)` | YES |
| Alias | `nvarchar(256)` | NO |
| EmailAddresses | `nvarchar(MAX)` | YES |
| Notes | `nvarchar(1024)` | YES |
| PhoneticDisplayName | `nvarchar(256)` | YES |
| SendOofMessageToOriginator | `bit` | YES |
| ReportToManagerIsEnabled | `bit` | YES |
| HiddenFromAddressListsEnabled | `bit` | YES |
| LDAPRecipientFilter | `nvarchar(MAX)` | YES |
| RecipientFilter | `nvarchar(MAX)` | YES |
| ReportToOriginatorIsEnabled | `bit` | YES |
| RecipientContainer | `nvarchar(256)` | YES |
| ModerationIsEnabled | `bit` | YES |
| RequireSenderAuth | `bit` | YES |
| SendModerationNotifications | `nvarchar(256)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| UID_AADOrganization | `varchar(38)` | NO |

### O3EDynDLAcceptRcpt  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EDynDLAcceptRcpt | `varchar(38)` | NO |
| UID_O3EDynDL | `varchar(38)` | NO |
| ObjectKeyAcceptRcpt | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### O3EDynDLGrantSendOnBehalf  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EDynDLGrantSendOnBehalf | `varchar(38)` | NO |
| UID_O3EDynDL | `varchar(38)` | NO |
| ObjectKeyGrantSendOnBehalfTo | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### O3EDynDLInO3EDL  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EDL | `varchar(38)` | NO |
| UID_O3EDynDL | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### O3EDynDLModBy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EDynDLModBy | `varchar(38)` | NO |
| UID_O3EDynDL | `varchar(38)` | NO |
| ObjectKeyModBy | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### O3EDynDLRejectRcpt  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EDynDLRejectRcpt | `varchar(38)` | NO |
| UID_O3EDynDL | `varchar(38)` | NO |
| ObjectKeyRejectRcpt | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### O3EMailbox  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EMailbox | `varchar(38)` | NO |
| MicrosoftOnlineServicesID | `nvarchar(256)` | YES |
| Identifier | `nvarchar(256)` | YES |
| Name | `nvarchar(256)` | NO |
| AddAdditionalResponse | `bit` | YES |
| AdditionalResponse | `nvarchar(MAX)` | YES |
| AddOrganizerToSubject | `bit` | YES |
| AllBookInPolicy | `bit` | YES |
| AllowConflicts | `bit` | YES |
| DisplayName | `nvarchar(400)` | YES |
| AllowRecurringMeetings | `bit` | YES |
| AllRequestInPolicy | `bit` | YES |
| AllRequestOutOfPolicy | `bit` | YES |
| ArchiveName | `nvarchar(256)` | YES |
| RecipientType | `nvarchar(256)` | YES |
| BookingWindowInDays | `bigint` | YES |
| ConflictPercentageAllowed | `bigint` | YES |
| DeliverToO3EMailboxAndForward | `bit` | YES |
| ItemCount | `bigint` | YES |
| DeleteAttachments | `bit` | YES |
| DeleteComments | `bit` | YES |
| HiddenFromAddressListsEnabled | `bit` | YES |
| DeleteNonCalendarItems | `bit` | YES |
| MsgTrackingReadStatusIsEnabled | `bit` | YES |
| DeleteSubject | `bit` | YES |
| RequireSenderAuth | `bit` | YES |
| SimpleDisplayName | `nvarchar(256)` | YES |
| OWAIsEnabled | `bit` | YES |
| ExchangeGuid | `nvarchar(256)` | YES |
| ActiveSyncIsEnabled | `bit` | YES |
| Alias | `nvarchar(256)` | NO |
| PopIsEnabled | `bit` | YES |
| MaximumConflictInstances | `bigint` | YES |
| ImapIsEnabled | `bit` | YES |
| MaximumDurationInMinutes | `bigint` | YES |
| MAPIIsEnabled | `bit` | YES |
| RemovePrivateProperty | `bit` | YES |
| EwsIsEnabled | `bit` | YES |
| RetentionComment | `nvarchar(256)` | YES |
| RetentionUrl | `nvarchar(256)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| UID_O3ESharingPolicy | `varchar(38)` | YES |
| UID_O3ERetentionPolicy | `varchar(38)` | YES |
| ArchiveGuid | `nvarchar(256)` | YES |
| RulesQuota | `bigint` | YES |
| EndDateForRetentionHold | `datetime` | YES |
| StartDateForRetentionHold | `datetime` | YES |
| EnforceSchedulingHorizon | `bit` | YES |
| ForwardRequestsToDelegates | `bit` | YES |
| LitigationHoldIsEnabled | `bit` | YES |
| TentativePendingApproval | `bit` | YES |
| DumpstMsgPerFldCountRcvQuota | `bigint` | YES |
| DumpstMsgPerFldCountWarnQuota | `bigint` | YES |
| RecipientTypeDetails | `nvarchar(256)` | NO |
| UseDatabaseQuotaDefaults | `bit` | YES |
| ModerationIsEnabled | `bit` | YES |
| RemoveFwdMeetingNotifications | `bit` | YES |
| RemoveOldMeetingMessages | `bit` | YES |
| SendModerationNotifications | `nvarchar(256)` | YES |
| ProcessExternalMeetingMessages | `bit` | YES |
| CalendarRepairDisabled | `bit` | YES |
| LitigationHoldDate | `datetime` | YES |
| LitigationHoldOwner | `nvarchar(256)` | YES |
| OrganizerInfo | `bit` | YES |
| EmailAddresses | `nvarchar(MAX)` | YES |
| ScheduleOnlyDuringWorkHours | `bit` | YES |
| RetentionHoldIsEnabled | `bit` | YES |
| ObjectKeyForwardingAddress | `varchar(138)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| AddNewRequestsTentatively | `bit` | YES |
| RetainDeletedItemsFor | `bigint` | YES |
| CalendarVersionStoreDisabled | `bit` | YES |
| AuditAdmin | `nvarchar(MAX)` | YES |
| ResourceCapacity | `bigint` | YES |
| AuditDelegate | `nvarchar(MAX)` | YES |
| AuditIsEnabled | `bit` | YES |
| TotalItemSize | `bigint` | YES |
| AuditLogAgeLimit | `bigint` | YES |
| AuditOwner | `nvarchar(MAX)` | YES |
| AutomateProcessing | `nvarchar(256)` | YES |
| XDateSubItem | `datetime` | YES |
| TotalDeletedItemSize | `bigint` | YES |
| StorageLimitStatus | `nvarchar(256)` | YES |
| DeletedItemCount | `bigint` | YES |
| LastLoggedOnUserAccount | `nvarchar(256)` | YES |
| LastLogonTime | `datetime` | YES |
| LastLogOffTime | `datetime` | YES |
| AssociatedItemCount | `bigint` | YES |
| ArchiveIsEnabled | `bit` | YES |
| EnableResponseDetails | `bit` | YES |
| UID_O3EMobileDeviceMBPolicy | `varchar(38)` | YES |
| UID_O3ERoleAssignmentPolicy | `varchar(38)` | YES |
| UID_AADOrganization | `varchar(38)` | NO |
| UID_O3EOwaMailboxPolicy | `varchar(38)` | YES |
| MatchPatternForMembership | `bigint` | YES |
| IsGroupAccount | `bit` | YES |
| UID_AADUser | `varchar(38)` | YES |
| ExternalDirectoryObjectId | `nvarchar(256)` | YES |
| RiskIndexCalculated | `float` | YES |
| NeverConnectToPerson | `int` | YES |
| UID_Person | `varchar(38)` | YES |
| IsNeverConnectManual | `bit` | YES |
| ProhibitSendQuota | `bigint` | YES |
| ProhibitSendReceiveQuota | `bigint` | YES |
| IssueWarningQuota | `bigint` | YES |
| SeniorityIndex | `bigint` | YES |
| PhoneticDisplayName | `nvarchar(256)` | YES |

### O3EMailboxFullAccessPerm  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EMailboxFullAccessPerm | `varchar(38)` | NO |
| UID_O3EMailbox | `varchar(38)` | NO |
| ObjectKeyPrincipalFullAccess | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### O3EMailboxInDL  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EMailbox | `varchar(38)` | NO |
| UID_O3EDL | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XIsInEffect | `bit` | YES |
| RiskIndexCalculated | `float` | YES |

### O3EMailboxSendAsPerm  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EMailboxSendAsPerm | `varchar(38)` | NO |
| UID_O3EMailbox | `varchar(38)` | NO |
| ObjectKeyPrincipalCanSendAs | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### O3EMailContact  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EMailContact | `varchar(38)` | NO |
| ExternalEmailAddressType | `nvarchar(256)` | YES |
| ObjectKeyManager | `varchar(138)` | YES |
| Identifier | `nvarchar(256)` | YES |
| UID_Person | `varchar(38)` | YES |
| UID_TSBBehavior | `varchar(38)` | YES |
| Name | `nvarchar(256)` | NO |
| UID_TSBAccountDef | `varchar(38)` | YES |
| ExternalEmailAddress | `nvarchar(256)` | NO |
| FirstName | `nvarchar(256)` | YES |
| SimpleDisplayName | `nvarchar(256)` | YES |
| LastName | `nvarchar(256)` | YES |
| EmailAddresses | `nvarchar(MAX)` | YES |
| Initials | `nvarchar(256)` | YES |
| UseMapiRichTextFormat | `nvarchar(256)` | YES |
| Company | `nvarchar(256)` | YES |
| Alias | `nvarchar(256)` | NO |
| AssistantName | `nvarchar(256)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| City | `nvarchar(256)` | YES |
| XDateInserted | `datetime` | YES |
| CountryOrRegion | `nvarchar(256)` | YES |
| XDateUpdated | `datetime` | YES |
| Department | `nvarchar(256)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| Fax | `nvarchar(256)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| HomePhone | `nvarchar(256)` | YES |
| XTouched | `nchar(1)` | YES |
| MobilePhone | `nvarchar(256)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| Notes | `nvarchar(1024)` | YES |
| Office | `nvarchar(256)` | YES |
| OtherFax | `nvarchar(MAX)` | YES |
| XDateSubItem | `datetime` | YES |
| OtherHomePhone | `nvarchar(MAX)` | YES |
| OtherTelephone | `nvarchar(MAX)` | YES |
| Pager | `nvarchar(256)` | YES |
| Phone | `nvarchar(256)` | YES |
| PhoneticDisplayName | `nvarchar(256)` | YES |
| PostalCode | `nvarchar(256)` | YES |
| PostOfficeBox | `nvarchar(MAX)` | YES |
| SeniorityIndex | `bigint` | YES |
| StateOrProvince | `nvarchar(256)` | YES |
| StreetAddress | `nvarchar(256)` | YES |
| TelephoneAssistant | `nvarchar(256)` | YES |
| Title | `nvarchar(256)` | YES |
| Webpage | `nvarchar(256)` | YES |
| UsePreferMessageFormat | `bit` | YES |
| MessageFormat | `nvarchar(256)` | YES |
| MessageBodyFormat | `nvarchar(256)` | YES |
| MacAttachmentFormat | `nvarchar(256)` | YES |
| DisplayName | `nvarchar(400)` | YES |
| HiddenFromAddressListsEnabled | `bit` | YES |
| ModerationIsEnabled | `bit` | YES |
| RequireSenderAuth | `bit` | YES |
| SendModerationNotifications | `nvarchar(256)` | YES |
| ObjectGUID | `varchar(36)` | YES |
| UID_AADOrganization | `varchar(38)` | NO |
| MatchPatternForMembership | `bigint` | YES |
| IsGroupAccount | `bit` | YES |
| ExternalDirectoryObjectId | `nvarchar(256)` | YES |
| RiskIndexCalculated | `float` | YES |
| NeverConnectToPerson | `int` | YES |
| IsNeverConnectManual | `bit` | YES |

### O3EMailContactInDL  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EMailContact | `varchar(38)` | NO |
| UID_O3EDL | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XIsInEffect | `bit` | YES |
| RiskIndexCalculated | `float` | YES |

### O3EMailPFAcceptRcpt  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EMailPFAcceptRcpt | `varchar(38)` | NO |
| UID_O3EMailPublicFolder | `varchar(38)` | NO |
| ObjectKeyAcceptRcpt | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### O3EMailPFGrantSendOnBehalf  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| ObjectKeyGrantSendOnBehalfTo | `varchar(138)` | NO |
| UID_O3EMailPFGrantSendOnBehalf | `varchar(38)` | NO |
| UID_O3EMailPublicFolder | `varchar(38)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### O3EMailPFInDL  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EMailPublicFolder | `varchar(38)` | NO |
| UID_O3EDL | `varchar(38)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### O3EMailPFModBy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EMailPFModBy | `varchar(38)` | NO |
| UID_O3EMailPublicFolder | `varchar(38)` | NO |
| ObjectKeyModBy | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### O3EMailPFRejectRcpt  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EMailPFRejectRcpt | `varchar(38)` | NO |
| UID_O3EMailPublicFolder | `varchar(38)` | NO |
| ObjectKeyRejectRcpt | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### O3EMailPublicFolder  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EMailPublicFolder | `varchar(38)` | NO |
| Identifier | `nvarchar(256)` | YES |
| UID_O3EPublicFolderIdentity | `varchar(38)` | YES |
| Name | `nvarchar(256)` | YES |
| ObjectGUID | `varchar(36)` | YES |
| DeliverToO3EMailboxAndForward | `bit` | YES |
| ExternalEmailAddress | `nvarchar(256)` | YES |
| DisplayName | `nvarchar(400)` | YES |
| EmailAddresses | `nvarchar(MAX)` | YES |
| WindowsEmailAddress | `nvarchar(256)` | YES |
| SimpleDisplayName | `nvarchar(256)` | YES |
| Alias | `nvarchar(256)` | YES |
| HiddenFromAddressListsEnabled | `bit` | YES |
| ObjectKeyForwardingAddress | `varchar(138)` | YES |
| ModerationIsEnabled | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| SendModerationNotifications | `nvarchar(256)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| UID_AADOrganization | `varchar(38)` | NO |

### O3EMailUser  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EMailUser | `varchar(38)` | NO |
| ExternalEmailAddressType | `nvarchar(256)` | YES |
| ObjectKeyManager | `varchar(138)` | YES |
| Identifier | `nvarchar(256)` | YES |
| MicrosoftOnlineServicesID | `nvarchar(256)` | YES |
| Name | `nvarchar(256)` | YES |
| ExternalEmailAddress | `nvarchar(256)` | NO |
| SimpleDisplayName | `nvarchar(256)` | YES |
| Password | `varchar(990)` | YES |
| EmailAddresses | `nvarchar(MAX)` | YES |
| UsePreferMessageFormat | `bit` | YES |
| UseMapiRichTextFormat | `nvarchar(256)` | YES |
| Alias | `nvarchar(256)` | NO |
| MessageFormat | `nvarchar(256)` | YES |
| MessageBodyFormat | `nvarchar(256)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| XDateInserted | `datetime` | YES |
| MacAttachmentFormat | `nvarchar(256)` | YES |
| DisplayName | `nvarchar(400)` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| HiddenFromAddressListsEnabled | `bit` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| ModerationIsEnabled | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| RequireSenderAuth | `bit` | YES |
| XDateSubItem | `datetime` | YES |
| SendModerationNotifications | `nvarchar(256)` | YES |
| ObjectGUID | `varchar(36)` | YES |
| UID_AADOrganization | `varchar(38)` | NO |
| MatchPatternForMembership | `bigint` | YES |
| IsGroupAccount | `bit` | YES |
| FirstName | `nvarchar(256)` | YES |
| LastName | `nvarchar(256)` | YES |
| Initials | `nvarchar(256)` | YES |
| Company | `nvarchar(256)` | YES |
| AssistantName | `nvarchar(256)` | YES |
| City | `nvarchar(256)` | YES |
| CountryOrRegion | `nvarchar(256)` | YES |
| Department | `nvarchar(256)` | YES |
| Fax | `nvarchar(256)` | YES |
| HomePhone | `nvarchar(256)` | YES |
| MobilePhone | `nvarchar(256)` | YES |
| Notes | `nvarchar(1024)` | YES |
| Office | `nvarchar(256)` | YES |
| OtherFax | `nvarchar(MAX)` | YES |
| OtherHomePhone | `nvarchar(MAX)` | YES |
| OtherTelephone | `nvarchar(MAX)` | YES |
| Pager | `nvarchar(256)` | YES |
| Phone | `nvarchar(256)` | YES |
| PhoneticDisplayName | `nvarchar(256)` | YES |
| PostalCode | `nvarchar(256)` | YES |
| PostOfficeBox | `nvarchar(MAX)` | YES |
| SeniorityIndex | `bigint` | YES |
| StateOrProvince | `nvarchar(256)` | YES |
| StreetAddress | `nvarchar(256)` | YES |
| Title | `nvarchar(256)` | YES |
| Webpage | `nvarchar(256)` | YES |
| UID_AADUser | `varchar(38)` | YES |
| UID_TSBBehavior | `varchar(38)` | YES |
| UID_TSBAccountDef | `varchar(38)` | YES |
| UID_Person | `varchar(38)` | YES |
| ExternalDirectoryObjectId | `nvarchar(256)` | YES |
| RiskIndexCalculated | `float` | YES |
| NeverConnectToPerson | `int` | YES |
| IsNeverConnectManual | `bit` | YES |
| RecipientType | `nvarchar(256)` | YES |
| RecipientTypeDetails | `nvarchar(256)` | YES |

### O3EMailUserInDL  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EMailUser | `varchar(38)` | NO |
| UID_O3EDL | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XIsInEffect | `bit` | YES |
| RiskIndexCalculated | `float` | YES |

### O3EMbxAcceptRcpt  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EMbxAcceptRcpt | `varchar(38)` | NO |
| UID_O3EMailbox | `varchar(38)` | NO |
| ObjectKeyAcceptRcpt | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### O3EMbxBookInPolicy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EMbxBookInPolicy | `varchar(38)` | NO |
| UID_O3EMailbox | `varchar(38)` | NO |
| ObjectKeyBookInPolicy | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### O3EMbxGrantSendOnBehalfTo  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| ObjectKeyGrantSendOnBehalfTo | `varchar(138)` | NO |
| UID_O3EMbxGrantSendOnBehalfTo | `varchar(38)` | NO |
| UID_O3EMailbox | `varchar(38)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### O3EMbxModBy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| ObjectKeyModBy | `varchar(138)` | NO |
| UID_O3EMbxModBy | `varchar(38)` | NO |
| UID_O3EMailbox | `varchar(38)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### O3EMbxRejectRcpt  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EMbxRejectRcpt | `varchar(38)` | NO |
| UID_O3EMailbox | `varchar(38)` | NO |
| ObjectKeyRejectRcpt | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### O3EMbxRequestInPolicy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EMbxRequestInPolicy | `varchar(38)` | NO |
| UID_O3EMailbox | `varchar(38)` | NO |
| ObjectKeyRequestInPolicy | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### O3EMbxRequestOutOfPolicy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| ObjectKeyRequestOutOfPolicy | `varchar(138)` | NO |
| UID_O3EMbxRequestOutOfPolicy | `varchar(38)` | NO |
| UID_O3EMailbox | `varchar(38)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### O3EMobileDeviceMBPolicy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| Name | `nvarchar(256)` | YES |
| UID_O3EMobileDeviceMBPolicy | `varchar(38)` | NO |
| Identifier | `nvarchar(256)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| AdminDisplayName | `nvarchar(256)` | YES |
| ObjectGUID | `varchar(36)` | YES |
| MaxAttachmentSize | `bigint` | YES |
| MaxEmailBodyTruncationSize | `int` | YES |
| MaxEmailHTMLBodyTruncationSize | `int` | YES |
| MaxInactivityTimeLock | `bigint` | YES |
| MaxPasswordFailedAttempts | `bigint` | YES |
| MinPasswordLength | `bigint` | YES |
| PasswordExpiration | `bigint` | YES |
| PasswordHistory | `bigint` | YES |
| MaxCalendarAgeFilter | `nvarchar(256)` | YES |
| MaxEmailAgeFilter | `nvarchar(256)` | YES |
| AllowBluetooth | `nvarchar(256)` | YES |
| AllowSMIMEEncrAlgNegotiation | `nvarchar(256)` | YES |
| MobileOTAUpdateMode | `nvarchar(256)` | YES |
| ReqEncrSMIMEAlgorithm | `nvarchar(256)` | YES |
| RequireSignedSMIMEAlgorithm | `nvarchar(256)` | YES |
| AllowApplePushNotifications | `bit` | YES |
| AllowBrowser | `bit` | YES |
| AllowCamera | `bit` | YES |
| AllowConsumerEmail | `bit` | YES |
| AllowDesktopSync | `bit` | YES |
| AllowExternalDeviceManagement | `bit` | YES |
| AllowGooglePushNotifications | `bit` | YES |
| AllowHTMLEmail | `bit` | YES |
| AllowInternetSharing | `bit` | YES |
| AllowIrDA | `bit` | YES |
| AllowMSPushNotifications | `bit` | YES |
| AllowMobileOTAUpdate | `bit` | YES |
| AllowNonProvisionableDevices | `bit` | YES |
| AllowPOPIMAPEmail | `bit` | YES |
| AllowRemoteDesktop | `bit` | YES |
| AllowSimplePassword | `bit` | YES |
| AllowSMIMESoftCerts | `bit` | YES |
| AllowStorageCard | `bit` | YES |
| AllowTextMessaging | `bit` | YES |
| AllowUnsignedApplications | `bit` | YES |
| AllowUnsignedInstallPack | `bit` | YES |
| AllowWiFi | `bit` | YES |
| AlphaNumericPasswordRequired | `bit` | YES |
| AttachmentsIsEnabled | `bit` | YES |
| DeviceEncryptionIsEnabled | `bit` | YES |
| IRMIsEnabled | `bit` | YES |
| IsDefault | `bit` | YES |
| PasswordIsEnabled | `bit` | YES |
| PasswordRecoveryIsEnabled | `bit` | YES |
| RequireDeviceEncryption | `bit` | YES |
| RequireEncryptedSMIMEMessages | `bit` | YES |
| RequireManualSyncWhenRoaming | `bit` | YES |
| RequireSignedSMIMEMessages | `bit` | YES |
| RequireStorageCardEncryption | `bit` | YES |
| UNCAccessIsEnabled | `bit` | YES |
| WSSAccessIsEnabled | `bit` | YES |
| UnapprovedInROMApplicationList | `nvarchar(MAX)` | YES |
| DevicePolicyRefreshInterval | `nvarchar(256)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| UID_AADOrganization | `varchar(38)` | NO |

### O3EOwaMailboxPolicy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| Name | `nvarchar(256)` | YES |
| UID_O3EOwaMailboxPolicy | `varchar(38)` | NO |
| Identifier | `nvarchar(256)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| ActiveSyncIntegrationIsEnabled | `bit` | YES |
| AllAddressListsIsEnabled | `bit` | YES |
| AllowCpyContactsToDevAddrBook | `bit` | YES |
| BoxAttachmentsIsEnabled | `bit` | YES |
| CalendarIsEnabled | `bit` | YES |
| ChangePasswordIsEnabled | `bit` | YES |
| ClassicAttachmentsIsEnabled | `bit` | YES |
| ContactsIsEnabled | `bit` | YES |
| DelegateAccessIsEnabled | `bit` | YES |
| DirectFileAccOnPrivComputers | `bit` | YES |
| DirectFileAccOnPubComputers | `bit` | YES |
| DisplayPhotosIsEnabled | `bit` | YES |
| DropboxAttachmentsIsEnabled | `bit` | YES |
| ExplicitLogonIsEnabled | `bit` | YES |
| FacebookIsEnabled | `bit` | YES |
| ForceSaveAttmntFiltering | `bit` | YES |
| ForceWacViewFirstPrivComputer | `bit` | YES |
| ForceWacViewFirstPubComputer | `bit` | YES |
| ForceWRDocVwFirstOnPrivComp | `bit` | YES |
| ForceWRDocVwFirstOnPubComp | `bit` | YES |
| GlobalAddressListIsEnabled | `bit` | YES |
| GoogleDriveAttachmentsEnabled | `bit` | YES |
| GroupCreationIsEnabled | `bit` | YES |
| InstantMessagingIsEnabled | `bit` | YES |
| IRMIsEnabled | `bit` | YES |
| IsDefault | `bit` | YES |
| IsValid | `bit` | YES |
| JournalIsEnabled | `bit` | YES |
| JunkEmailIsEnabled | `bit` | YES |
| LinkedInIsEnabled | `bit` | YES |
| NotesIsEnabled | `bit` | YES |
| OneDriveAttachmentsIsEnabled | `bit` | YES |
| OrganizationIsEnabled | `bit` | YES |
| OWALightIsEnabled | `bit` | YES |
| PhoneticSupportIsEnabled | `bit` | YES |
| PlacesIsEnabled | `bit` | YES |
| PredictedActionsIsEnabled | `bit` | YES |
| PremiumClientIsEnabled | `bit` | YES |
| PublicFoldersIsEnabled | `bit` | YES |
| RecoverDeletedItemsIsEnabled | `bit` | YES |
| ReferenceAttachmentsIsEnabled | `bit` | YES |
| RemindersAndNotifications | `bit` | YES |
| ReportJunkEmailIsEnabled | `bit` | YES |
| RulesIsEnabled | `bit` | YES |
| SatisfactionIsEnabled | `bit` | YES |
| SearchFoldersIsEnabled | `bit` | YES |
| SaveAttachmentsToCloudEnabled | `bit` | YES |
| SetPhotoIsEnabled | `bit` | YES |
| SignaturesIsEnabled | `bit` | YES |
| SilverlightIsEnabled | `bit` | YES |
| SkpCrUFGrpCustSPClassification | `bit` | YES |
| SMimeIsEnabled | `bit` | YES |
| SpellCheckerIsEnabled | `bit` | YES |
| TasksIsEnabled | `bit` | YES |
| TextMessagingIsEnabled | `bit` | YES |
| ThemeSelectionIsEnabled | `bit` | YES |
| UMIntegrationIsEnabled | `bit` | YES |
| UNCAccessOnPrivateComputers | `bit` | YES |
| UNCAccessOnPublicComputers | `bit` | YES |
| UseGB18030 | `bit` | YES |
| UseISO885915 | `bit` | YES |
| UserDiagnosticIsEnabled | `bit` | YES |
| UserVoiceIsEnabled | `bit` | YES |
| WacEditingIsEnabled | `bit` | YES |
| WacExternalServicesIsEnabled | `bit` | YES |
| WacOMEXIsEnabled | `bit` | YES |
| WacViewingOnPrivateComputers | `bit` | YES |
| WacViewingOnPublicComputers | `bit` | YES |
| WeatherIsEnabled | `bit` | YES |
| WebRdyDocViewAllSupportedTypes | `bit` | YES |
| WebRdyDocViewOnPrivComputers | `bit` | YES |
| WebRdyDocViewOnPubComputers | `bit` | YES |
| WSSAccessOnPrivateComputers | `bit` | YES |
| WSSAccessOnPublicComputers | `bit` | YES |
| ActionUnknownFileAndMIMETypes | `nvarchar(256)` | YES |
| AdminDisplayName | `nvarchar(256)` | YES |
| AllowOfflineOn | `nvarchar(256)` | YES |
| DefaultTheme | `nvarchar(256)` | YES |
| InstantMessagingType | `nvarchar(256)` | YES |
| OutboundCharset | `nvarchar(256)` | YES |
| SetPhotoURL | `nvarchar(256)` | YES |
| WebPartsFrameOptionsType | `nvarchar(256)` | YES |
| AllowedFileTypes | `nvarchar(MAX)` | YES |
| AllowedMimeTypes | `nvarchar(MAX)` | YES |
| BlockedFileTypes | `nvarchar(MAX)` | YES |
| BlockedMimeTypes | `nvarchar(MAX)` | YES |
| ForceSaveFileTypes | `nvarchar(MAX)` | YES |
| ForceSaveMimeTypes | `nvarchar(MAX)` | YES |
| ObjectClass | `nvarchar(MAX)` | YES |
| WebRdyDocViewSupFileTypes | `nvarchar(MAX)` | YES |
| WebRdyDocViewSupMIMETypes | `nvarchar(MAX)` | YES |
| WebReadyFileTypes | `nvarchar(MAX)` | YES |
| WebReadyMimeTypes | `nvarchar(MAX)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| UID_AADOrganization | `varchar(38)` | NO |

### O3EPublicFolder  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EPublicFolder | `varchar(38)` | NO |
| Identifier | `nvarchar(256)` | YES |
| UID_O3EPublicFolderParent | `varchar(38)` | YES |
| Name | `nvarchar(256)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| PerUserReadStateIsEnabled | `bit` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| UID_AADOrganization | `varchar(38)` | NO |

### O3ERetentionPolicy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3ERetentionPolicy | `varchar(38)` | NO |
| Identifier | `nvarchar(256)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| ObjectGUID | `varchar(36)` | YES |
| AdminDisplayName | `nvarchar(256)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| RetentionPolicyTagLinks | `nvarchar(MAX)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| Name | `nvarchar(256)` | YES |
| XMarkedForDeletion | `int` | YES |
| UID_AADOrganization | `varchar(38)` | NO |
| IsDefault | `bit` | YES |

### O3ERoleAssignmentPolicy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3ERoleAssignmentPolicy | `varchar(38)` | NO |
| Name | `nvarchar(256)` | YES |
| Identifier | `nvarchar(256)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| AdminDisplayName | `nvarchar(256)` | YES |
| ObjectGUID | `varchar(36)` | YES |
| IsDefault | `bit` | YES |
| Description | `nvarchar(512)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| UID_AADOrganization | `varchar(38)` | NO |

### O3ESharingPolicy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3ESharingPolicy | `varchar(38)` | NO |
| Identifier | `nvarchar(256)` | YES |
| Name | `nvarchar(256)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| ObjectGUID | `varchar(36)` | YES |
| IsEnabled | `bit` | YES |
| AdminDisplayName | `nvarchar(256)` | YES |
| Domains | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| IsDefault | `bit` | YES |
| UID_AADOrganization | `varchar(38)` | NO |

### O3EUnifiedGroup  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EUnifiedGroup | `varchar(38)` | NO |
| XDateSubItem | `datetime` | YES |
| DisplayName | `nvarchar(400)` | NO |
| Identifier | `nvarchar(256)` | YES |
| AccessType | `nvarchar(256)` | YES |
| AutoSubscribeNewMembers | `bit` | YES |
| AlwaysSubMemberToCalEvt | `bit` | YES |
| FileNotificationsSettings | `nvarchar(256)` | YES |
| HiddenGroupMembershipEnabled | `bit` | YES |
| InboxUrl | `nvarchar(256)` | YES |
| IsExternalResourcesPublished | `bit` | YES |
| IsMailboxConfigured | `bit` | YES |
| MailboxProvisioningConstr | `nvarchar(256)` | YES |
| Notes | `nvarchar(1024)` | YES |
| PeopleUrl | `nvarchar(256)` | YES |
| PhotoUrl | `nvarchar(256)` | YES |
| SharePointSiteUrl | `nvarchar(MAX)` | YES |
| SharePointDocumentsUrl | `nvarchar(MAX)` | YES |
| SharePointNotebookUrl | `nvarchar(MAX)` | YES |
| SubscriptionIsEnabled | `bit` | YES |
| WelcomeMessageIsEnabled | `bit` | YES |
| ConnectorsIsEnabled | `bit` | YES |
| IsMembershipDynamic | `bit` | YES |
| YammerEmailAddress | `nvarchar(256)` | YES |
| GroupExternalMemberCount | `bigint` | YES |
| AllowAddGuests | `bit` | YES |
| EmailAddresses | `nvarchar(MAX)` | YES |
| Name | `nvarchar(256)` | YES |
| RequireSenderAuth | `bit` | YES |
| GroupType | `nvarchar(256)` | YES |
| IsDirSynced | `bit` | YES |
| MigToUnifiedGroupInProgress | `bit` | YES |
| Alias | `nvarchar(256)` | YES |
| CustomAttribute1 | `nvarchar(256)` | YES |
| CustomAttribute10 | `nvarchar(256)` | YES |
| CustomAttribute11 | `nvarchar(256)` | YES |
| CustomAttribute12 | `nvarchar(256)` | YES |
| CustomAttribute13 | `nvarchar(256)` | YES |
| CustomAttribute14 | `nvarchar(256)` | YES |
| CustomAttribute15 | `nvarchar(256)` | YES |
| CustomAttribute2 | `nvarchar(256)` | YES |
| CustomAttribute3 | `nvarchar(256)` | YES |
| CustomAttribute4 | `nvarchar(256)` | YES |
| CustomAttribute5 | `nvarchar(256)` | YES |
| CustomAttribute6 | `nvarchar(256)` | YES |
| CustomAttribute7 | `nvarchar(256)` | YES |
| CustomAttribute8 | `nvarchar(256)` | YES |
| CustomAttribute9 | `nvarchar(256)` | YES |
| ExtensionCustomAttribute1 | `nvarchar(MAX)` | YES |
| ExtensionCustomAttribute2 | `nvarchar(MAX)` | YES |
| ExtensionCustomAttribute3 | `nvarchar(MAX)` | YES |
| ExtensionCustomAttribute4 | `nvarchar(MAX)` | YES |
| ExtensionCustomAttribute5 | `nvarchar(MAX)` | YES |
| ExternalDirectoryObjectId | `nvarchar(256)` | YES |
| HiddenFromAddressListsEnabled | `bit` | YES |
| MaxSendSize | `bigint` | YES |
| RecipientType | `nvarchar(256)` | YES |
| RecipientTypeDetails | `nvarchar(256)` | YES |
| MailTip | `nvarchar(256)` | YES |
| MailTipTranslations | `nvarchar(MAX)` | YES |
| IsValid | `bit` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| ExchangeVersion | `nvarchar(256)` | YES |
| UID_AADOrganization | `varchar(38)` | NO |
| UID_AADGroup | `varchar(38)` | YES |
| UID_AccProduct | `varchar(38)` | YES |
| IsForITShop | `bit` | YES |
| IsITShopOnly | `bit` | YES |
| MatchPatternForMembership | `bigint` | YES |
| RiskIndex | `float` | YES |
| UID_DialogCulture | `varchar(38)` | YES |
| UNSDisplay | `nvarchar(400)` | YES |
| HiddenFromExchClientsEnabled | `bit` | YES |
| UID_AADGroupClassificationLbl | `varchar(38)` | YES |

### O3EUnifiedGroupAcceptRcpt  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EUnifiedGroupAcceptRcpt | `varchar(38)` | NO |
| UID_O3EUnifiedGroup | `varchar(38)` | NO |
| ObjectKeyAcceptRcpt | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### O3EUnifiedGroupRejectRcpt  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EUnifiedGroupRejectRcpt | `varchar(38)` | NO |
| UID_O3EUnifiedGroup | `varchar(38)` | NO |
| ObjectKeyRejectRcpt | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### O3EUsrAcceptRcpt  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EUsrAcceptRcpt | `varchar(38)` | NO |
| UID_O3EMailUser | `varchar(38)` | NO |
| ObjectKeyAcceptRcpt | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### O3EUsrGrantSendOnBehalfTo  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EUsrGrantSendOnBehalfTo | `varchar(38)` | NO |
| UID_O3EMailUser | `varchar(38)` | NO |
| ObjectKeyGrantSendOnBehalfTo | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### O3EUsrModBy  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EUsrModBy | `varchar(38)` | NO |
| UID_O3EMailUser | `varchar(38)` | NO |
| ObjectKeyModBy | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### O3EUsrRejectRcpt  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_O3EUsrRejectRcpt | `varchar(38)` | NO |
| UID_O3EMailUser | `varchar(38)` | NO |
| ObjectKeyRejectRcpt | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### ObjectHasExtendedAttribute  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ObjectHasExtendedAttribute | `varchar(38)` | NO |
| UID_ExtendedAttribute | `varchar(38)` | NO |
| ObjectKeyOfObject | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### OrgRoot  (8 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_OrgRoot | `varchar(38)` | NO |
| UID_OrgAttestator | `varchar(38)` | YES |
| Description | `nvarchar(255)` | YES |
| IsTopDown | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| Ident_OrgRoot | `nvarchar(32)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| IsDelegable | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| UID_OrgType | `varchar(38)` | YES |
| IsPersonAssignOnce | `bit` | YES |

### OrgRootAssign  (216 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_OrgRoot | `varchar(38)` | NO |
| UID_BaseTreeAssign | `varchar(38)` | NO |
| IsAssignmentAllowed | `bit` | YES |
| IsDirectAssignmentAllowed | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### OrgType  (1 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_OrgType | `varchar(38)` | NO |
| Ident_OrgType | `nvarchar(64)` | NO |
| Description | `nvarchar(255)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| IsPersonAssignOnce | `bit` | YES |

### OS  (8 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_OS | `varchar(38)` | NO |
| Ident_OS | `nvarchar(32)` | NO |
| Name | `nvarchar(64)` | YES |
| Version | `nvarchar(64)` | YES |
| IsServerOS | `bit` | YES |
| IsClientOS | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### Person  (78 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Person | `varchar(38)` | NO |
| TechnicalEntryDate | `datetime` | YES |
| UID_DialogUser | `varchar(38)` | YES |
| UID_DialogState | `varchar(38)` | YES |
| UID_DialogCountry | `varchar(38)` | YES |
| UID_FirmPartner | `varchar(38)` | YES |
| UID_WorkDesk | `varchar(38)` | YES |
| UID_Locality | `varchar(38)` | YES |
| UID_ProfitCenter | `varchar(38)` | YES |
| UID_Department | `varchar(38)` | YES |
| FirstName | `nvarchar(64)` | YES |
| LastName | `nvarchar(64)` | YES |
| Title | `nvarchar(64)` | YES |
| NameAddOn | `nvarchar(16)` | YES |
| EntryDate | `datetime` | YES |
| ExitDate | `datetime` | YES |
| InternalName | `nvarchar(128)` | YES |
| Remarks | `nvarchar(MAX)` | YES |
| Description | `nvarchar(MAX)` | YES |
| Phone | `nvarchar(MAX)` | YES |
| PhoneMobile | `nvarchar(MAX)` | YES |
| Fax | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| Salutation | `nvarchar(64)` | YES |
| PersonnelNumber | `nvarchar(32)` | YES |
| UserIDTSO | `nchar(4)` | YES |
| Floor | `nvarchar(MAX)` | YES |
| Room | `nvarchar(MAX)` | YES |
| DisplayTelephoneBook | `bit` | YES |
| IsDuplicateName | `bit` | YES |
| SecurityIdent | `nvarchar(32)` | YES |
| Street | `nvarchar(MAX)` | YES |
| City | `nvarchar(MAX)` | YES |
| ZIPCode | `nvarchar(40)` | YES |
| PostalOfficeBox | `nvarchar(MAX)` | YES |
| GenerationalQualifier | `nvarchar(8)` | YES |
| Initials | `nvarchar(10)` | YES |
| IsDummyPerson | `bit` | YES |
| UID_RealPerson | `varchar(38)` | YES |
| CentralAccount | `nvarchar(110)` | YES |
| CustomProperty01 | `nvarchar(64)` | YES |
| CustomProperty02 | `nvarchar(64)` | YES |
| CustomProperty03 | `nvarchar(64)` | YES |
| CustomProperty04 | `nvarchar(64)` | YES |
| CustomProperty05 | `nvarchar(64)` | YES |
| CustomProperty06 | `nvarchar(64)` | YES |
| CustomProperty07 | `nvarchar(64)` | YES |
| CustomProperty08 | `nvarchar(64)` | YES |
| CustomProperty09 | `nvarchar(64)` | YES |
| CustomProperty10 | `nvarchar(64)` | YES |
| DefaultEmailAddress | `nvarchar(256)` | YES |
| IsVIP | `bit` | YES |
| IsNoteBookUser | `bit` | YES |
| IsCar | `bit` | YES |
| Building | `nvarchar(64)` | YES |
| IsInActive | `bit` | YES |
| SubCompany | `nvarchar(32)` | YES |
| CentralPassword | `varchar(990)` | YES |
| IsTemporaryDeactivated | `bit` | YES |
| DeactivationEnd | `datetime` | YES |
| CompanyMember | `nvarchar(64)` | YES |
| BirthDate | `datetime` | YES |
| IsTerminalServerAllowed | `bit` | YES |
| IsRemoteAccessAllowed | `bit` | YES |
| UID_X500Person | `varchar(38)` | YES |
| IsX500Dummy | `bit` | YES |
| XTouched | `nchar(1)` | YES |
| DialogUserPassword | `varchar(218)` | YES |
| DialogUserSalt | `nvarchar(16)` | YES |
| IsExternal | `bit` | YES |
| UID_PersonHead | `varchar(38)` | YES |
| DateLastWorked | `datetime` | YES |
| FormerName | `nvarchar(64)` | YES |
| PreferredName | `nvarchar(64)` | YES |
| JPegPhoto | `varbinary` | YES |
| PersonalTitle | `nvarchar(128)` | YES |
| XObjectKey | `varchar(138)` | NO |
| UID_PersonMasterIdentity | `varchar(38)` | YES |
| Gender | `int` | YES |
| IsSecurityIncident | `bit` | YES |
| IsNoInherite | `bit` | YES |
| DeactivationStart | `datetime` | YES |
| RiskIndexCalculated | `float` | YES |
| MiddleName | `nvarchar(64)` | YES |
| ApprovalState | `int` | YES |
| ImportSource | `nvarchar(32)` | YES |
| DistinguishedName | `nvarchar(1000)` | YES |
| CanonicalName | `nvarchar(1000)` | YES |
| Sponsor | `nvarchar(MAX)` | YES |
| UID_DialogCulture | `varchar(38)` | YES |
| UID_DialogCultureFormat | `varchar(38)` | YES |
| XMarkedForDeletion | `int` | YES |
| AuthentifierLogins | `nvarchar(MAX)` | YES |
| PhoneExtension | `varchar(20)` | YES |
| FaxExtension | `varchar(20)` | YES |
| IdentityType | `varchar(32)` | YES |
| MfaUserId | `nvarchar(16)` | YES |
| Passcode | `varchar(990)` | YES |
| PasscodeExpires | `datetime` | YES |
| PasswordLastSet | `datetime` | YES |
| BadPasswordAttempts | `int` | YES |
| BadPwdAnswerAttempts | `int` | YES |
| IsLockedOut | `bit` | YES |
| IsLockedPwdAnswer | `bit` | YES |
| EmployeeType | `varchar(32)` | YES |
| ContactEmail | `nvarchar(256)` | YES |
| DecentralizedIdentifier | `varchar(218)` | YES |
| IsPwdResetByHelpdeskAllowed | `bit` | YES |
| LeaveOfAbsenceReason | `nvarchar(64)` | YES |
| UID_Org | `varchar(38)` | YES |
| CCC_CustomMulti | `nvarchar(512)` | YES |
| CCC_IsManagerNotifiedForExpire | `bit` | YES |

### PersonHasESet  (69 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Person | `varchar(38)` | NO |
| UID_ESet | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### PersonHasObject  (643 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_PersonHasObject | `varchar(38)` | NO |
| ObjectKey | `varchar(138)` | NO |
| UID_Person | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| InheritInfo | `int` | YES |

### PersonHasQERAssign  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QERAssign | `varchar(38)` | NO |
| UID_Person | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### PersonHasQERResource  (14 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Person | `varchar(38)` | NO |
| UID_QERResource | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### PersonHasQERReuse  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Person | `varchar(38)` | NO |
| UID_QERReuse | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### PersonHasQERReuseUS  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Person | `varchar(38)` | NO |
| UID_QERReuseUS | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### PersonHasRPSReport  (125 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Person | `varchar(38)` | NO |
| UID_RPSReport | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### PersonHasTSBAccountDef  (20 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Person | `varchar(38)` | NO |
| UID_TSBAccountDef | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### PersonInBaseTree  (342 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Person | `varchar(38)` | NO |
| UID_Org | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| IsExceptionGranted | `bit` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| RiskIndexReduced | `float` | YES |
| UID_QERJustification | `varchar(38)` | YES |
| UID_PersonDecisionMade | `varchar(38)` | YES |
| DecisionReason | `nvarchar(1024)` | YES |
| IsDecisionMade | `bit` | YES |
| DecisionDate | `datetime` | YES |
| ExceptionValidUntil | `datetime` | YES |

### PersonInNCHasMControl  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_PersonInNCHasMControl | `varchar(38)` | NO |
| UID_MitigatingControl | `varchar(38)` | NO |
| ObjectKeyPersonInNonCompliance | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| UID_PersonWantsOrg | `varchar(38)` | YES |
| IsInActive | `bit` | YES |

### PersonWantsOrg  (274 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_PersonWantsOrg | `varchar(38)` | NO |
| UID_QERJustification | `varchar(38)` | YES |
| UID_QERJustificationOrder | `varchar(38)` | YES |
| UID_ShoppingCartOrder | `varchar(38)` | YES |
| UID_Department | `varchar(38)` | YES |
| UID_PersonInserted | `varchar(38)` | YES |
| UID_OrgParentOfParent | `varchar(38)` | YES |
| UID_ProfitCenter | `varchar(38)` | YES |
| UID_PersonOrdered | `varchar(38)` | YES |
| UID_PersonHead | `varchar(38)` | YES |
| OrderReason | `nvarchar(MAX)` | YES |
| OrderDate | `datetime` | YES |
| DisplayPersonOrdered | `nvarchar(128)` | YES |
| DisplayPersonHead | `nvarchar(128)` | YES |
| DisplayOrg | `nvarchar(256)` | YES |
| DisplayOrgParent | `nvarchar(256)` | YES |
| DisplayOrgParentOfParent | `nvarchar(256)` | YES |
| ReasonHead | `nvarchar(MAX)` | YES |
| DateHead | `datetime` | YES |
| DateActivated | `datetime` | YES |
| DateDeactivated | `datetime` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| DecisionLevel | `int` | NO |
| GenProcID | `varchar(38)` | YES |
| XTouched | `nchar(1)` | YES |
| UID_OrgParent | `varchar(38)` | YES |
| UID_Org | `varchar(38)` | YES |
| CustomProperty01 | `nvarchar(64)` | YES |
| CustomProperty02 | `nvarchar(64)` | YES |
| CustomProperty03 | `nvarchar(64)` | YES |
| CustomProperty04 | `nvarchar(64)` | YES |
| CustomProperty05 | `nvarchar(64)` | YES |
| CustomProperty06 | `nvarchar(64)` | YES |
| CustomProperty07 | `nvarchar(64)` | YES |
| CustomProperty08 | `nvarchar(64)` | YES |
| CustomProperty09 | `nvarchar(64)` | YES |
| CustomProperty10 | `nvarchar(64)` | YES |
| ValidUntil | `datetime` | YES |
| DisplayPersonInserted | `nvarchar(128)` | YES |
| IsReserved | `bit` | YES |
| AdditionalData | `nvarchar(MAX)` | YES |
| ValidFrom | `datetime` | YES |
| XObjectKey | `varchar(138)` | NO |
| ObjectKeyOrdered | `varchar(138)` | YES |
| UID_PersonWantsOrgParent | `varchar(38)` | YES |
| IsOptionalChild | `bit` | YES |
| OrderState | `nvarchar(16)` | NO |
| ObjectKeyAssignment | `varchar(138)` | YES |
| ValidUntilProlongation | `datetime` | YES |
| UID_WorkDeskOrdered | `varchar(38)` | YES |
| IsOrderForWorkDesk | `bit` | YES |
| Quantity | `float` | YES |
| UID_ITShopOrgFinal | `varchar(38)` | YES |
| OrderDetail1 | `nvarchar(MAX)` | YES |
| OrderDetail2 | `nvarchar(64)` | YES |
| DisplayObjectKeyAssignment | `nvarchar(256)` | YES |
| XMarkedForDeletion | `int` | YES |
| UID_QERResourceType | `varchar(38)` | YES |
| UID_PWOState | `varchar(38)` | YES |
| PWOPriority | `int` | YES |
| ValidUntilUnsubscribe | `datetime` | YES |
| ObjectKeyOrgUsedInAssign | `varchar(138)` | YES |
| ObjectKeyElementUsedInAssign | `varchar(138)` | YES |
| UID_QERWorkingMethod | `varchar(38)` | YES |
| CheckResult | `int` | YES |
| CheckResultDetail | `nvarchar(MAX)` | YES |
| PeerGroupFactor | `float` | YES |
| IsCrossFunctional | `bit` | YES |
| UiOrderState | `nvarchar(16)` | YES |
| ObjectKeyFinal | `varchar(138)` | YES |
| Recommendation | `int` | YES |
| RecommendationDetail | `nvarchar(MAX)` | YES |
| CCC_CustomDate01 | `datetime` | YES |
| CCC_CustomDate02 | `datetime` | YES |
| CCC_UID_FirmPartner | `varchar(38)` | YES |
| CCC_UID_Person01 | `varchar(38)` | YES |
| CCC_UID_Person02 | `varchar(38)` | YES |

### PolicyObjectHasMControl  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_MitigatingControl | `varchar(38)` | NO |
| UID_QERPolicyHasObject | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### PWODecisionHistory  (867 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_PWODecisionHistory | `varchar(38)` | NO |
| UID_QERJustification | `varchar(38)` | YES |
| UID_PersonWantsOrg | `varchar(38)` | YES |
| DisplayPersonHead | `nvarchar(128)` | YES |
| ReasonHead | `nvarchar(MAX)` | YES |
| DateHead | `datetime` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| DecisionLevel | `int` | YES |
| XTouched | `nchar(1)` | YES |
| CustomProperty01 | `nvarchar(64)` | YES |
| CustomProperty02 | `nvarchar(64)` | YES |
| CustomProperty03 | `nvarchar(64)` | YES |
| CustomProperty04 | `nvarchar(64)` | YES |
| CustomProperty05 | `nvarchar(64)` | YES |
| CustomProperty06 | `nvarchar(64)` | YES |
| CustomProperty07 | `nvarchar(64)` | YES |
| CustomProperty08 | `nvarchar(64)` | YES |
| CustomProperty09 | `nvarchar(64)` | YES |
| CustomProperty10 | `nvarchar(64)` | YES |
| ValidUntil | `datetime` | YES |
| ValidFrom | `datetime` | YES |
| DecisionType | `nvarchar(16)` | YES |
| IsDecisionBySystem | `bit` | YES |
| UID_PersonHead | `varchar(38)` | YES |
| XObjectKey | `varchar(138)` | NO |
| Ident_PWODecisionStep | `nvarchar(64)` | YES |
| OrderState | `nvarchar(16)` | YES |
| UID_ITShopOrgFinal | `varchar(38)` | YES |
| UID_PersonRelated | `varchar(38)` | YES |
| IsToHideInHistory | `bit` | YES |
| UID_ComplianceRule | `varchar(38)` | YES |
| XMarkedForDeletion | `int` | YES |
| UID_PWODecisionRule | `varchar(38)` | YES |
| UID_PWOState | `varchar(38)` | YES |
| RulerLevel | `int` | YES |
| ValidUntilProlongation | `datetime` | YES |
| UID_ShoppingCartOrder | `varchar(38)` | YES |
| ValidUntilUnsubscribe | `datetime` | YES |
| PWOPriority | `int` | YES |
| IsFromDelegation | `bit` | YES |

### PWODecisionMethod  (69 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_PWODecisionMethod | `varchar(38)` | NO |
| UID_SubMethodOrderProduct | `varchar(38)` | YES |
| Ident_PWODecisionMethod | `nvarchar(64)` | YES |
| Description | `nvarchar(MAX)` | YES |
| Priority | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| UID_SubMethodOrderUnsubscribe | `varchar(38)` | YES |
| UID_SubMethodOrderProlongate | `varchar(38)` | YES |
| UID_DialogRichMailExpiration | `varchar(38)` | YES |
| UID_DialogRichMailAbort | `varchar(38)` | YES |
| UID_DialogRichMailGrant | `varchar(38)` | YES |
| UID_DialogRichMailNoGrant | `varchar(38)` | YES |
| XMarkedForDeletion | `int` | YES |
| UsageArea | `char(1)` | YES |
| UID_OrgType | `varchar(38)` | YES |
| UID_DialogRichMailUnsubscribe | `varchar(38)` | YES |
| UID_DialogRichMailProlongate | `varchar(38)` | YES |
| IsHideFromSelection | `bit` | YES |

### PWODecisionRule  (108 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_PWODecisionRule | `varchar(38)` | NO |
| UID_Task | `varchar(38)` | YES |
| MaxCountApprover | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| Description | `nvarchar(1024)` | YES |
| SortOrder | `int` | YES |
| UsageArea | `char(1)` | NO |
| DecisionRule | `nvarchar(2)` | YES |
| XMarkedForDeletion | `int` | YES |
| Remarks | `nvarchar(MAX)` | YES |

### PWODecisionRuleRulerDetect  (253 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_PWODecisionRuleRulerDetect | `varchar(38)` | NO |
| UID_PWODecisionRule | `varchar(38)` | NO |
| SQLQuery | `nvarchar(MAX)` | YES |
| SQLQueryObjectsToRecalc | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XTouched | `nchar(1)` | YES |
| XMarkedForDeletion | `int` | YES |
| Ident_RulerDetect | `nvarchar(64)` | YES |

### PWODecisionStep  (189 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_PWODecisionStep | `varchar(38)` | NO |
| UID_AERoleFallBack | `varchar(38)` | YES |
| UID_DialogRichMailInsert | `varchar(38)` | YES |
| UID_PWODecisionSubMethod | `varchar(38)` | YES |
| LevelNumber | `int` | YES |
| Ident_PWODecisionStep | `nvarchar(64)` | YES |
| Description | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| SubLevelNumber | `int` | YES |
| DirectSteps | `nvarchar(256)` | YES |
| PositiveSteps | `int` | YES |
| NegativeSteps | `int` | YES |
| LevelDisplay | `nvarchar(64)` | YES |
| WhereClause | `nvarchar(MAX)` | YES |
| AutomaticReasonTrue | `nvarchar(128)` | YES |
| AutomaticReasonFalse | `nvarchar(128)` | YES |
| XObjectKey | `varchar(138)` | NO |
| CountApprover | `int` | YES |
| EscalationSteps | `int` | YES |
| MinutesReminder | `int` | YES |
| MinutesAutomaticDecision | `int` | YES |
| AutomaticDecision | `nvarchar(16)` | YES |
| UID_DialogRichMailReminder | `varchar(38)` | YES |
| UID_DialogRichMailGrant | `varchar(38)` | YES |
| UID_DialogRichMailNoGrant | `varchar(38)` | YES |
| UID_DialogRichMailEscalate | `varchar(38)` | YES |
| UID_DialogRichMailFromDelegat | `varchar(38)` | YES |
| UID_DialogRichMailToDelegat | `varchar(38)` | YES |
| IsAdditionalAllowed | `bit` | YES |
| IsInsteadOfAllowed | `bit` | YES |
| IsToHideInHistory | `bit` | YES |
| IsNoAutoDecision | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| UsageArea | `char(1)` | YES |
| UID_PWODecisionRule | `varchar(38)` | NO |
| ObjectKeyOfAssignedOrg | `varchar(138)` | YES |
| UID_PWOStateFinalSuccess | `varchar(38)` | YES |
| UID_PWOStateFinalError | `varchar(38)` | YES |
| IgnoreNoDecideForPerson | `bit` | YES |
| EscalateIfNoApprover | `bit` | YES |
| ApproveReasonType | `int` | YES |
| DenyReasonType | `int` | YES |

### PWODecisionSubMethod  (70 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_PWODecisionSubMethod | `varchar(38)` | NO |
| RevisionNumber | `int` | YES |
| Ident_PWODecisionSubMethod | `nvarchar(64)` | YES |
| Description | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| LayoutInformation | `nvarchar(MAX)` | YES |
| DaysToAbort | `int` | YES |
| XMarkedForDeletion | `int` | YES |
| UsageArea | `char(1)` | YES |

### PWOHelperBoardMethod  (13 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_OrgBO | `varchar(38)` | NO |
| UID_PWODecisionMethod | `varchar(38)` | NO |

### PWOHelperDecisionMaker  (10 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_PersonHead | `varchar(38)` | NO |

### PWOHelperPWO  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_PWOHelperPWO | `varchar(38)` | NO |
| UID_PersonHead | `varchar(38)` | YES |
| UID_PersonWantsOrg | `varchar(38)` | NO |
| LevelNumber | `int` | NO |
| SubLevelNumber | `int` | NO |
| Decision | `nchar(1)` | YES |
| ReasonHead | `nvarchar(MAX)` | YES |
| UID_ComplianceRule | `varchar(38)` | YES |
| NextReminder | `datetime` | YES |
| NextAutomaticDecision | `datetime` | YES |
| UID_PersonNonCompliant | `varchar(38)` | YES |
| XObjectKey | `varchar(138)` | NO |
| UID_PersonAdditional | `varchar(38)` | YES |
| UID_PersonInsteadOf | `varchar(38)` | YES |
| IsFromDelegation | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| UID_PWODecisionRule | `varchar(38)` | YES |
| UID_PWORulerOrigin | `varchar(38)` | YES |
| RulerLevel | `int` | YES |
| UID_QERWorkingStep | `varchar(38)` | YES |

### PWOState  (1 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_PWOState | `varchar(38)` | NO |
| Ident_PWOState | `nvarchar(64)` | NO |
| Description | `nvarchar(MAX)` | YES |
| IsSuccess | `bit` | YES |
| IsFinal | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| OrderNumber | `int` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMAdaptiveCard  (2 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMAdaptiveCard | `varchar(38)` | NO |
| Ident_QBMAdaptiveCard | `nvarchar(64)` | NO |
| Description | `nvarchar(256)` | YES |
| IsInActive | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMAdaptiveCardTemplate  (4 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMAdaptiveCardTemplate | `varchar(38)` | NO |
| UID_QBMAdaptiveCard | `varchar(38)` | NO |
| UID_DialogCulture | `varchar(38)` | NO |
| Template | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMBufferConfig  (63 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMBufferConfig | `varchar(38)` | NO |
| TableName | `varchar(30)` | YES |
| ColumnName | `varchar(30)` | YES |
| ObjectKeyOfRow | `varchar(138)` | NO |
| XTouched | `nchar(1)` | YES |
| ContentShort | `nvarchar(400)` | YES |
| HasContentFull | `bit` | YES |
| ContentFull | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XDateUpdated | `datetime` | YES |

### QBMBufferTransfer  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| ModuleName | `varchar(3)` | NO |
| TableName | `varchar(30)` | NO |
| ColumnName | `varchar(30)` | NO |
| ObjectKeyOfRow | `varchar(138)` | NO |
| ContentShort | `nvarchar(400)` | YES |
| HasContentFull | `bit` | YES |
| ContentFull | `nvarchar(MAX)` | YES |
| OperationType | `varchar(1)` | YES |
| SortOrder | `int` | NO |

### QBMCEFDefinitions  (13 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMCEFDefinitions | `varchar(38)` | NO |
| UID_DialogTable | `varchar(38)` | NO |
| UID_DialogColumn | `varchar(38)` | YES |
| EventClassID | `nvarchar(64)` | NO |
| ActivityName | `nvarchar(128)` | NO |
| LogSeverity | `int` | NO |
| MessageString | `nvarchar(MAX)` | YES |
| Param01 | `nvarchar(1024)` | YES |
| Param02 | `nvarchar(1024)` | YES |
| Param03 | `nvarchar(1024)` | YES |
| Param04 | `nvarchar(1024)` | YES |
| Param05 | `nvarchar(1024)` | YES |
| OperationType | `nchar(1)` | NO |
| IsInActive | `bit` | YES |
| LastRun | `datetime` | YES |
| WhereClause | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMClrType  (398 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMClrType | `varchar(38)` | NO |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| Assembly | `nvarchar(256)` | NO |
| FullTypeName | `nvarchar(512)` | NO |
| ExposedInterface | `nvarchar(512)` | YES |
| Alias | `nvarchar(128)` | YES |

### QBMColumnBitMaskConfig  (3,152 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMColumnBitMaskConfig | `varchar(38)` | NO |
| UID_DialogColumn | `varchar(38)` | NO |
| BitPosition | `int` | YES |
| KeyDisplay | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| IsInActive | `bit` | YES |

### QBMColumnLimitedValue  (1,117 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMColumnLimitedValue | `varchar(38)` | NO |
| UID_DialogColumn | `varchar(38)` | NO |
| KeyValue | `nvarchar(256)` | YES |
| KeyDisplay | `nvarchar(MAX)` | YES |
| OrderNumber | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| IsInActive | `bit` | YES |

### QBMColumnTranslation  (414 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogColumnTarget | `varchar(38)` | NO |
| UID_QBMColumnTranslation | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| ObjectKeyDialogColumnSource | `varchar(138)` | NO |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |

### QBMConfigLibrary  (36 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMConfigLibrary | `varchar(38)` | NO |
| UID_QBMConfigLibraryCategory | `varchar(38)` | YES |
| UID_DialogColumn | `varchar(38)` | YES |
| Ident_QBMConfigLibrary | `nvarchar(128)` | YES |
| Description | `nvarchar(1024)` | YES |
| ObjectKeyInstance | `varchar(138)` | YES |
| DataType | `int` | YES |
| ConfigurationCode | `nvarchar(MAX)` | YES |
| SortOrder | `int` | YES |
| XDateInserted | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |

### QBMConfigLibraryCategory  (2 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMConfigLibraryCategory | `varchar(38)` | NO |
| Ident_QBMConfigLibraryCategory | `nvarchar(128)` | YES |
| Description | `nvarchar(1024)` | YES |
| SortOrder | `int` | YES |
| XDateInserted | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |

### QBMConfigParmHasTask  (154 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Task | `varchar(38)` | NO |
| UID_ConfigParm | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMConnectionInfo  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMConnectionInfo | `varchar(38)` | NO |
| DisplayName | `nvarchar(256)` | YES |
| ConnectionProvider | `nvarchar(256)` | YES |
| ConnectionString | `nvarchar(MAX)` | YES |
| AuthString | `nvarchar(MAX)` | YES |
| IsFallBackAppServer | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMConsistencyCheck  (310 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMConsistencyCheck | `varchar(38)` | NO |
| Severity | `varchar(1)` | YES |
| SortOrder | `int` | YES |
| Category | `varchar(16)` | YES |
| SQLCheck | `nvarchar(MAX)` | YES |
| Description | `nvarchar(MAX)` | YES |
| SQLRepair | `nvarchar(MAX)` | YES |
| DescriptionRepair | `nvarchar(MAX)` | YES |
| UID_QBMClrTypeCheckRepair | `varchar(38)` | YES |
| IsTemplate | `bit` | YES |
| SQLElementDetect | `nvarchar(MAX)` | YES |
| DescriptionElementDetect | `nvarchar(MAX)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| Ident_QBMConsistencyCheck | `nvarchar(64)` | YES |
| UsageLevel | `int` | YES |
| FullPath | `nvarchar(256)` | YES |
| AccessLevelMin | `int` | YES |

### QBMCulture  (405 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogCulture | `varchar(38)` | NO |
| Ident_DialogCulture | `varchar(16)` | NO |
| DisplayName | `nvarchar(64)` | YES |
| LCID | `int` | YES |
| NativeName | `nvarchar(64)` | YES |
| Iso3Name | `nvarchar(3)` | YES |
| XDateInserted | `datetime` | YES |
| Windows3Name | `nvarchar(3)` | YES |
| XDateUpdated | `datetime` | YES |
| Iso2Name | `nvarchar(2)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| UID_DialogCultureParent | `varchar(38)` | YES |
| UID_DialogCultureDefault | `varchar(38)` | YES |
| XMarkedForDeletion | `int` | YES |
| IsForFrontend | `bit` | YES |

### QBMCustomSQL  (48 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMCustomSQL | `varchar(38)` | NO |
| ScriptType | `nvarchar(1)` | YES |
| ScriptName | `nvarchar(255)` | YES |
| ScriptCode | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| SortOrder | `int` | YES |
| Remarks | `nvarchar(1024)` | YES |
| XObjectKey | `varchar(138)` | NO |

### QBMDBPrincipal  (2 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMDBPrincipal | `varchar(38)` | NO |
| LoginName | `nvarchar(128)` | YES |
| UserName | `nvarchar(128)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| AccessLevel | `int` | YES |

### QBMDBPrincipalHasRoleDef  (3 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMDBPrincipal | `varchar(38)` | NO |
| UID_QBMDBRoleDef | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |

### QBMDBQueueAgent  (7 rows)

| Column | Type | Nullable |
|--------|------|----------|
| Ident_QBMDBQueueAgent | `nvarchar(128)` | YES |
| ServerProcess | `int` | YES |

### QBMDBQueueCurrent  (18 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogDBQueue | `varchar(38)` | NO |
| UID_Task | `varchar(38)` | YES |
| UID_Parameter | `varchar(38)` | YES |
| UID_SubParameter | `varchar(38)` | YES |
| SlotNumber | `int` | YES |
| GenProcID | `varchar(38)` | YES |
| Generation | `int` | YES |
| StartedAt | `datetime` | YES |

### QBMDBQueuePond  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Task | `varchar(38)` | YES |
| Object | `varchar(38)` | YES |
| SubObject | `varchar(38)` | YES |
| GenProcID | `varchar(38)` | NO |
| PondGroup | `varchar(38)` | YES |
| InsertDate | `datetime` | YES |

### QBMDBQueueTask  (423 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Task | `varchar(38)` | NO |
| ProcedureName | `varchar(61)` | YES |
| IsBulkEnabled | `bit` | YES |
| XTouched | `nchar(1)` | YES |
| CountParameter | `int` | YES |
| XObjectKey | `varchar(138)` | NO |
| MaxInstance | `int` | YES |
| UID_TaskAutomatedFollower | `varchar(38)` | YES |
| UID_TaskAutomatedPredecessor | `varchar(38)` | YES |
| IsNoGenProcIDCheck | `bit` | YES |
| UID_TaskParent | `varchar(38)` | YES |
| QueryForRecalculate | `nvarchar(MAX)` | YES |
| IsWithoutTransaction | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| ChangeLimit | `int` | YES |
| ExecutionDelaySeconds | `int` | YES |
| RestoreDelay | `int` | YES |
| CustomWeight | `float` | YES |

### QBMDBQueueTaskDepend  (649 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_TaskPredecessor | `varchar(38)` | NO |
| UID_TaskFollower | `varchar(38)` | NO |
| IsPhysicalDependency | `bit` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMDBQueueTaskHasSchedule  (31 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Task | `varchar(38)` | NO |
| UID_DialogSchedule | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMDBQueueTaskMetric  (423 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Task | `varchar(38)` | NO |
| UID_TaskParent | `varchar(38)` | YES |
| UID_TaskAutomatedPredecessor | `varchar(38)` | YES |
| UID_TaskAutomatedFollower | `varchar(38)` | YES |
| PathLength | `int` | YES |
| SlotInformation | `varchar(1024)` | YES |
| CurrentBulk | `int` | YES |
| CountParameter | `int` | YES |
| IsNoGenProcIDCheck | `bit` | YES |
| IsBulkEnabled | `bit` | YES |
| RestoreDelay | `int` | YES |
| ProcedureName | `varchar(61)` | YES |
| MaxInstanceEffective | `int` | YES |
| CountProcessing | `int` | YES |
| CountInDBQueue | `int` | YES |
| CountResetted | `int` | YES |
| CountChildTasks | `int` | YES |
| LastExecutedAt | `datetime` | YES |

### QBMDBRightsAddOn  (3,261 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMDBRightsAddOn | `varchar(38)` | NO |
| UID_QBMDBRoleDef | `varchar(38)` | NO |
| PermissionName | `nvarchar(64)` | YES |
| PermissionType | `varchar(4)` | YES |
| ObjectClass | `nvarchar(16)` | YES |
| ObjectName | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |

### QBMDBRoleDef  (3 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMDBRoleDef | `varchar(38)` | NO |
| Rolename | `nvarchar(400)` | YES |
| Scope | `nvarchar(16)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |

### QBMDeployTarget  (25 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMDeployTarget | `varchar(38)` | NO |
| Ident_QBMDeployTarget | `nvarchar(64)` | NO |
| FullPath | `nvarchar(256)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| UID_QBMDeployTargetParent | `varchar(38)` | YES |
| DisplayValue | `nvarchar(256)` | YES |

### QBMDeployTargetHasServerTag  (9 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMDeployTarget | `varchar(38)` | NO |
| UID_QBMServerTag | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |

### QBMDiskStoreLogical  (23 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMDiskStoreLogical | `varchar(38)` | NO |
| Ident_QBMDiskStoreLogical | `nvarchar(256)` | YES |
| Description | `nvarchar(1024)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| UID_QBMDiskStorePhysical | `varchar(38)` | YES |

### QBMDiskStorePhysical  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMDiskStorePhysical | `varchar(38)` | NO |
| Ident_QBMDiskStorePhysical | `nvarchar(256)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMElementAffectedByJob  (1 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Job | `varchar(38)` | NO |
| ObjectKeyAffected | `varchar(138)` | NO |

### QBMEvent  (638 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMEvent | `varchar(38)` | NO |
| DisplayName | `nvarchar(256)` | YES |
| EventName | `nvarchar(64)` | NO |
| UID_DialogTable | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMEventHasFeature  (53 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogFeature | `varchar(38)` | NO |
| UID_QBMEvent | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMExternalPackage  (295 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMExternalPackage | `varchar(38)` | NO |
| Name | `nvarchar(128)` | NO |
| Version | `nvarchar(64)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |

### QBMFeature  (104 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogFeature | `varchar(38)` | NO |
| Ident_DialogFeature | `nvarchar(64)` | NO |
| Description | `nvarchar(255)` | YES |
| Ident_DialogFeatureGroup | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMFileHasDeployTarget  (36 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMFileHasDeployTarget | `varchar(38)` | NO |
| UID_QBMFileRevision | `varchar(38)` | NO |
| ObjectKeyDeployTarget | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |

### QBMFileRevision  (1,989 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMFileRevision | `varchar(38)` | NO |
| FileName | `nvarchar(400)` | YES |
| FileContent | `varbinary` | YES |
| HashValue | `varbinary` | YES |
| FileSize | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| FileVersion | `nvarchar(64)` | YES |
| IsToBackup | `bit` | YES |
| XObjectKey | `varchar(138)` | NO |
| SourceDirectory | `nvarchar(256)` | YES |
| NeverUpdate | `bit` | YES |
| SourceType | `int` | YES |

### QBMForeignKeyWrongReport  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMForeignKeyWrongReport | `varchar(38)` | NO |
| ChildTable | `nvarchar(32)` | YES |
| ChildColumn | `nvarchar(32)` | YES |
| ParentTable | `nvarchar(32)` | YES |
| ParentColumn | `nvarchar(32)` | YES |
| IsChildPKMember | `bit` | YES |
| ParentRestriction | `nchar(2)` | YES |
| IsChildNullable | `varchar(16)` | YES |
| RepairMethod | `nvarchar(7)` | YES |
| RelationID | `nvarchar(64)` | YES |
| OwnerOfReference | `varchar(3)` | YES |
| InvalidValue | `varchar(140)` | YES |
| XObjectKey | `varchar(138)` | NO |

### QBMGroupHasLimitedSQL  (621 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMLimitedSQL | `varchar(38)` | NO |
| UID_DialogGroup | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMGroupHasTree  (14,093 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogGroup | `varchar(38)` | NO |
| UID_QBMTree | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMGuidReplace  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Database | `varchar(38)` | YES |
| GuidOld | `nvarchar(38)` | YES |
| GuidNew | `varchar(38)` | YES |
| IsProcessed | `bit` | YES |

### QBMHtmlApp  (4 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMHtmlApp | `varchar(38)` | NO |
| UID_QBMDBPrincipal | `varchar(38)` | YES |
| DisplayName | `nvarchar(256)` | NO |
| Description | `nvarchar(MAX)` | YES |
| Path | `nvarchar(256)` | YES |
| IsInActive | `bit` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| IsPreCompiled | `bit` | YES |
| Ident_QBMHtmlApp | `nvarchar(256)` | YES |
| SortOrder | `int` | YES |

### QBMIdentityClient  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMIdentityClient | `varchar(38)` | NO |
| DisplayName | `nvarchar(256)` | NO |
| Description | `nvarchar(1024)` | YES |
| IsDefault | `bit` | YES |
| CertificateEndpoint | `nvarchar(400)` | YES |
| CertificateSubject | `nvarchar(400)` | YES |
| CertificateText | `nvarchar(MAX)` | YES |
| CertificateThumbPrint | `varchar(62)` | YES |
| ClientID | `nvarchar(MAX)` | YES |
| Resource | `nvarchar(400)` | YES |
| SharedSecret | `nvarchar(MAX)` | YES |
| RedirectUri | `nvarchar(MAX)` | YES |
| UID_QBMIdentityProvider | `varchar(38)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| TokenEndpointAuthentication | `varchar(32)` | YES |
| TokenEndpointCertThumbPrint | `varchar(MAX)` | YES |
| AcrValues | `nvarchar(400)` | YES |
| PostLogoutRedirectURI | `nvarchar(MAX)` | YES |
| IsSendPostLogoutRedirectURI | `int` | YES |

### QBMIdentityProvDisabledCol  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMIdentityProvDisabledCol | `varchar(38)` | NO |
| ObjectKeyDialogColumn | `varchar(138)` | NO |
| UID_QBMIdentityProvider | `varchar(38)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### QBMIdentityProvEnabledCol  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMIdentityProvEnabledCol | `varchar(38)` | NO |
| UID_QBMIdentityProvider | `varchar(38)` | NO |
| ObjectKeyDialogColumn | `varchar(138)` | NO |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |

### QBMIdentityProvider  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMIdentityProvider | `varchar(38)` | NO |
| DisplayName | `nvarchar(256)` | YES |
| Description | `nvarchar(1024)` | YES |
| AllowSelfSignedCertsForTLS | `bit` | YES |
| IssuerName | `nvarchar(400)` | YES |
| JsonWebKeyEndpoint | `nvarchar(400)` | YES |
| LoginEndpoint | `nvarchar(400)` | YES |
| LogoutEndpoint | `nvarchar(400)` | YES |
| Scope | `nvarchar(400)` | YES |
| SearchClaim | `nvarchar(400)` | YES |
| TokenEndpoint | `nvarchar(400)` | YES |
| UserInfoEndpoint | `nvarchar(400)` | YES |
| UserNameClaim | `nvarchar(400)` | YES |
| UID_SearchColumn | `varchar(38)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| SharedSecret | `nvarchar(MAX)` | YES |
| CertificateEndpoint | `nvarchar(400)` | YES |
| CertificateSubject | `nvarchar(400)` | YES |
| CertificateText | `nvarchar(MAX)` | YES |
| CertificateThumbPrint | `varchar(62)` | YES |
| NoIdTokenCheck | `bit` | YES |
| CheckClaim | `nvarchar(400)` | YES |
| CheckValue | `nvarchar(256)` | YES |
| AcrValues | `nvarchar(400)` | YES |

### QBMJobqueueOverview  (2 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMJobqueueOverview | `varchar(38)` | NO |
| QueueName | `nvarchar(128)` | NO |
| CountTrue | `int` | YES |
| CountLoaded | `int` | YES |
| CountOverlimt | `int` | YES |
| CountMissing | `int` | YES |
| CountDelete | `int` | YES |
| CountHistory | `int` | YES |
| CountProcessing | `int` | YES |
| CountFalse | `int` | YES |
| CountFrozen | `int` | YES |
| CountFinished | `int` | YES |
| XObjectKey | `varchar(138)` | NO |
| IsInvalid | `bit` | YES |
| IsInitQueueRunning | `bit` | YES |

### QBMLaunchAction  (48 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMLaunchAction | `varchar(38)` | NO |
| Ident_QBMLaunchAction | `nvarchar(128)` | YES |
| Description | `nvarchar(1024)` | YES |
| ExeName | `nvarchar(512)` | YES |
| ExeParameters | `nvarchar(MAX)` | YES |
| IsUACApplication | `bit` | YES |
| TaskName | `nvarchar(512)` | YES |
| TaskParameters | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| UID_QBMClrType | `varchar(38)` | YES |

### QBMLaunchActionHasFeature  (36 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMLaunchAction | `varchar(38)` | NO |
| UID_DialogFeature | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMLimitedSQL  (158 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMLimitedSQL | `varchar(38)` | NO |
| Description | `nvarchar(256)` | YES |
| SQLContent | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| Ident_QBMLimitedSQL | `nvarchar(64)` | YES |
| TypeOfLimitedSQL | `int` | YES |

### QBMLock  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMLock | `varchar(38)` | NO |
| UID_DialogColumn | `varchar(38)` | NO |
| ObjectKeyOfRow | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |

### QBMMethodHasFeature  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogFeature | `varchar(38)` | NO |
| UID_DialogMethod | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMMissingDisplayRight  (32,687 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMMissingDisplayRight | `varchar(38)` | NO |
| UID_DialogGroup | `varchar(38)` | NO |
| UID_DialogColumn | `varchar(38)` | NO |
| IsTableRightExisting | `bit` | YES |
| SelectWhereClause | `nvarchar(MAX)` | YES |
| XObjectKey | `varchar(138)` | NO |
| UID_DialogTableChild | `varchar(38)` | NO |

### QBMModuleDef  (21 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ModuleDef | `varchar(38)` | NO |
| DisplayValue | `nvarchar(256)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| ModuleName | `varchar(3)` | YES |
| ModuleVersion | `nvarchar(64)` | YES |
| MigrationVersion | `nvarchar(64)` | YES |
| XMarkedForDeletion | `int` | YES |
| SortOrder | `int` | YES |
| ModuleInfoXML | `nvarchar(MAX)` | YES |
| CheckSumForDelta | `int` | YES |

### QBMModuleDepend  (21 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ModulePredecessor | `varchar(38)` | NO |
| UID_ModuleFollower | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMModuleDependCollection  (114 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ModulePredecessor | `varchar(38)` | NO |
| UID_ModuleFollower | `varchar(38)` | NO |

### QBMNonLinearDepend  (12,840 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMNonLinearDepend | `varchar(38)` | NO |
| ObjectKeyOwner | `varchar(138)` | NO |
| NeededModules | `varchar(256)` | YES |
| IsManual | `bit` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |

### QBMObjectHasPwdPolicy  (4 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMObjectHasPwdPolicy | `varchar(38)` | NO |
| ObjectKeyElement | `varchar(138)` | NO |
| UID_QBMPwdPolicy | `varchar(38)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| UID_DialogColumn | `varchar(38)` | YES |
| XMarkedForDeletion | `int` | YES |

### QBMPendingChange  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMPendingChange | `varchar(38)` | NO |
| ObjectKeyElement | `varchar(138)` | YES |
| IsProcessed | `int` | YES |
| Operation | `varchar(1)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMPendingChangeDetail  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMPendingChangeDetail | `varchar(38)` | NO |
| UID_QBMPendingChange | `varchar(38)` | NO |
| IsProcessed | `int` | YES |
| Operation | `varchar(1)` | NO |
| DiffStore | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| CreationDate | `datetime` | YES |

### QBMProduct  (9 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogProduct | `varchar(38)` | NO |
| Ident_Product | `nvarchar(30)` | NO |
| VersionMin | `nvarchar(21)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| CustomRemarks | `nvarchar(255)` | YES |
| XTouched | `nchar(1)` | YES |
| CustomConfiguration | `nvarchar(MAX)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| IsTreeBased | `bit` | YES |
| UID_QBMTree | `varchar(38)` | YES |

### QBMProductHasTree  (3,990 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogProduct | `varchar(38)` | NO |
| UID_QBMTree | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMPwdBlacklist  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMPwdBlacklist | `varchar(38)` | NO |
| WordExcluded | `nvarchar(64)` | YES |
| Description | `nchar(1024)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMPwdHistory  (55 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMPwdHistory | `varchar(38)` | NO |
| ObjectKeyAccount | `varchar(138)` | NO |
| HashValue | `varchar(218)` | NO |
| DateInserted | `datetime` | NO |
| XObjectKey | `varchar(138)` | NO |
| UID_DialogColumn | `varchar(38)` | YES |

### QBMPwdPolicy  (5 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMPwdPolicy | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| CheckScriptName | `nvarchar(128)` | YES |
| DisplayName | `nvarchar(64)` | YES |
| Description | `nvarchar(1024)` | YES |
| ErrorMessage | `nvarchar(MAX)` | YES |
| IsDefault | `bit` | YES |
| MinLen | `int` | YES |
| MaxLen | `int` | YES |
| MinLetters | `int` | YES |
| MinLettersLowerCase | `int` | YES |
| MinLettersUpperCase | `int` | YES |
| MinNumbers | `int` | YES |
| MinSpecialChar | `int` | YES |
| IsElementPropertiesDenied | `bit` | YES |
| SpecialCharsAllowed | `nvarchar(MAX)` | YES |
| SpecialCharsDenied | `nvarchar(MAX)` | YES |
| MaxAge | `int` | YES |
| MaxRepeatLen | `int` | YES |
| MaxRepeatCount | `int` | YES |
| HistoryLen | `int` | YES |
| MinPasswordQuality | `int` | YES |
| MaxBadAttempts | `int` | YES |
| DefaultInitialPassword | `varchar(990)` | YES |
| CreateScriptName | `nvarchar(128)` | YES |
| XMarkedForDeletion | `int` | YES |
| IsLowerLetterNotAllowed | `bit` | YES |
| IsUpperLetterNotAllowed | `bit` | YES |
| IsNumberNotAllowed | `bit` | YES |
| IsSpecialNotAllowed | `bit` | YES |
| MandatoryCharacterClasses | `int` | YES |
| AdditionalPwdRequirements | `nvarchar(MAX)` | YES |
| UID_AERoleOwner | `varchar(38)` | YES |

### QBMRelation  (2,026 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMRelation | `varchar(38)` | NO |
| RelationID | `nvarchar(64)` | NO |
| ParentRestriction | `nchar(2)` | NO |
| ParentExecuteBy | `nchar(1)` | YES |
| ParentAllowUpdate | `bit` | YES |
| ChildRestriction | `nchar(2)` | NO |
| ChildExecuteBy | `nchar(1)` | YES |
| ChildAllowUpdate | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| IsMNRelation | `bit` | YES |
| XTouched | `nchar(1)` | YES |
| isSPML | `bit` | YES |
| IsConnectedInTransport | `int` | YES |
| Caption | `nvarchar(256)` | YES |
| generateParent | `nvarchar(3)` | YES |
| generateChild | `nvarchar(3)` | YES |
| UID_ChildColumn | `varchar(38)` | NO |
| UID_ParentColumn | `varchar(38)` | NO |
| UID_QBMRelationBase | `varchar(38)` | YES |
| UID_QBMRelationMN | `varchar(38)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| IsForUpdateXDateSubItem | `bit` | YES |
| IsForAddElementAffected | `bit` | YES |

### QBMReportQueryCriteria  (3 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMReportQueryCriteria | `varchar(38)` | NO |
| UID_DialogReportQuery | `varchar(38)` | NO |
| CriteriaColumn | `nvarchar(32)` | YES |
| CriteriaValue | `nvarchar(256)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMScriptHasFeature  (1 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogFeature | `varchar(38)` | NO |
| UID_DialogScript | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMServer  (1 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMServer | `varchar(38)` | NO |
| Ident_Server | `nvarchar(64)` | NO |
| UID_ParentQBMServer | `varchar(38)` | YES |
| IsQBMServiceInstalled | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| SRVAccount | `varchar(990)` | YES |
| SRVAccountPwd | `varchar(990)` | YES |
| SRVAccountDomain | `varchar(990)` | YES |
| IsCluster | `bit` | YES |
| UID_ClusterServer | `varchar(38)` | YES |
| QueueName | `nvarchar(128)` | YES |
| RunningOS | `nvarchar(16)` | YES |
| JobserverConfiguration | `nvarchar(MAX)` | YES |
| XTouched | `nchar(1)` | YES |
| IsInSoftwareUpdate | `bit` | YES |
| IsNoAutoupdate | `bit` | YES |
| XObjectKey | `varchar(138)` | NO |
| PhysicalServerName | `nvarchar(64)` | YES |
| Encoding | `nvarchar(64)` | YES |
| IsJobServiceDisabled | `bit` | YES |
| LastTimeoutCheck | `datetime` | YES |
| SessionID | `varchar(38)` | YES |
| XMarkedForDeletion | `int` | YES |
| ObjectKeyTargetSystem | `varchar(138)` | YES |
| UID_DialogCulture | `varchar(38)` | YES |
| IPV4 | `varchar(15)` | YES |
| IPV6 | `varchar(39)` | YES |
| FQDN | `nvarchar(256)` | YES |
| DestCopyMethods | `nvarchar(MAX)` | YES |
| SourceCopyMethods | `nvarchar(MAX)` | YES |
| UID_QBMConnectionInfo | `varchar(38)` | YES |
| IsNoDatabaseConnect | `bit` | YES |
| PortNumber | `int` | YES |
| LastJobFetchTime | `datetime` | YES |
| FQDNExternal | `nvarchar(256)` | YES |
| PortNumberExternal | `int` | YES |
| NotUsedForJobCreation | `bit` | YES |
| IsJobServiceSuspended | `bit` | YES |
| SuspendReason | `nvarchar(MAX)` | YES |
| CountUsedHomes | `int` | YES |
| IsAutoShareHome | `bit` | YES |
| MaxSpaceHomes | `int` | YES |
| MaxNumberHomes | `int` | YES |
| UID_QBMServerNearestDC | `varchar(38)` | YES |

### QBMServerHasDeployTarget  (15 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMDeployTarget | `varchar(38)` | NO |
| UID_QBMServer | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |

### QBMServerHasServerTag  (26 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMServerTag | `varchar(38)` | NO |
| UID_QBMServer | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XTouched | `nchar(1)` | YES |
| XMarkedForDeletion | `int` | YES |

### QBMServerTag  (26 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMServerTag | `varchar(38)` | NO |
| Ident_QBMServerTag | `nvarchar(64)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XTouched | `nchar(1)` | YES |
| XMarkedForDeletion | `int` | YES |
| Description | `nvarchar(1000)` | YES |

### QBMSessionStore  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMSessionStore | `varchar(38)` | NO |
| SessionToken | `varchar(MAX)` | YES |
| SessionVariables | `nvarchar(MAX)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| SessionGuid | `varchar(40)` | YES |

### QBMSplittedLookup  (151 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMSplittedLookup | `varchar(38)` | NO |
| UID_DialogColumn | `varchar(38)` | NO |
| ObjectKeyOwner | `varchar(138)` | NO |
| SplittedElement | `nvarchar(400)` | NO |
| SplittedElementType | `varchar(16)` | NO |
| UID_Person | `varchar(38)` | YES |

### QBMTableRevision  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| TableName | `varchar(30)` | NO |
| RevisionDate | `datetime` | YES |
| ServerProcess | `int` | YES |

### QBMTaggedChange  (314 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMTaggedChange | `varchar(38)` | NO |
| UID_DialogTag | `varchar(38)` | NO |
| ObjectKey | `varchar(138)` | NO |
| SortOrder | `bigint` | YES |
| ChangeContent | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMTranslationAddOnSource  (4,667 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMTranslationAddOnSource | `varchar(38)` | NO |
| EntryKey | `nvarchar(1024)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| SourceType | `nvarchar(16)` | YES |
| SourceDetail | `nvarchar(1024)` | YES |

### QBMTransportHistory  (110 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMTransportHistory | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| HistoryType | `varchar(16)` | YES |
| Description | `nvarchar(MAX)` | YES |
| MigrationVersion | `varchar(64)` | YES |
| Module | `varchar(3)` | YES |
| ItemsSelectedByUser | `bit` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XDateUpdated | `datetime` | YES |
| TransportFileName | `nvarchar(512)` | YES |
| TransportFileDate | `datetime` | YES |
| SourceDatabase | `nvarchar(512)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |

### QBMTree  (3,990 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMTree | `varchar(38)` | NO |
| UID_QBMTreeParent | `varchar(38)` | YES |
| UID_QBMTreeReference | `varchar(38)` | YES |
| UID_DialogImage | `varchar(38)` | YES |
| UID_QBMLaunchAction | `varchar(38)` | YES |
| UID_DialogTable | `varchar(38)` | YES |
| UID_DialogDashBoardDef | `varchar(38)` | YES |
| Ident_QBMTree | `nvarchar(255)` | NO |
| ActivationFKList | `nvarchar(256)` | YES |
| Caption | `nvarchar(255)` | YES |
| ConfigurationFlags | `int` | YES |
| Description | `nvarchar(512)` | YES |
| ElementAlignment | `nvarchar(32)` | YES |
| ElementColor | `nvarchar(16)` | YES |
| GaugeType | `nvarchar(16)` | YES |
| HelpKey | `nvarchar(100)` | YES |
| IsDeactivated | `bit` | YES |
| IsDeactivatedByPreProcessor | `bit` | YES |
| IsDistinct | `bit` | YES |
| IsOverrideColumnDefault | `bit` | YES |
| IsPrivateNode | `bit` | YES |
| IsRecursion | `bit` | YES |
| ItemLimit | `int` | YES |
| InitScript | `nvarchar(MAX)` | YES |
| NodeType | `nchar(1)` | NO |
| OrderBy | `nvarchar(255)` | YES |
| PreProcessorCondition | `nvarchar(255)` | YES |
| SortOrder | `nvarchar(8)` | YES |
| StateScript | `nvarchar(MAX)` | YES |
| VarDefinition | `nvarchar(MAX)` | YES |
| WhereClause | `nvarchar(MAX)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XMarkedForDeletion | `int` | YES |

### QBMTreeHasColumn  (1,776 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMTreeHasColumn | `varchar(38)` | NO |
| UID_QBMTree | `varchar(38)` | YES |
| UID_DialogColumn | `varchar(38)` | YES |
| SortOrder | `float` | YES |
| ResultColumnType | `varchar(16)` | NO |
| ResultColumnValue | `nvarchar(256)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMTreeHasSheet  (243 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMTree | `varchar(38)` | NO |
| UID_DialogSheet | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMTreeHasTreeResult  (1,870 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMTree | `varchar(38)` | NO |
| UID_QBMTreeResult | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMTreeHasUIDashBoard  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMTree | `varchar(38)` | NO |
| UID_QBMUIDashBoard | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMTreeResult  (1,007 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMTreeResult | `varchar(38)` | NO |
| UID_DialogImage | `varchar(38)` | YES |
| UID_DialogObject | `varchar(38)` | YES |
| Ident_QBMTreeResult | `nvarchar(255)` | NO |
| ActivationFKList | `nvarchar(256)` | YES |
| CanInsert | `bit` | YES |
| CanDelete | `bit` | YES |
| Caption | `nvarchar(128)` | YES |
| ConfigurationFlags | `int` | YES |
| Description | `nvarchar(512)` | YES |
| InsertValuesScript | `nvarchar(MAX)` | YES |
| IsDeactivated | `bit` | YES |
| IsDeactivatedByPreProcessor | `bit` | YES |
| IsOverrideColumnDefault | `bit` | YES |
| ItemDisplayPattern | `nvarchar(255)` | YES |
| ItemLimit | `int` | YES |
| OrderBy | `nvarchar(255)` | YES |
| PreProcessorCondition | `nvarchar(255)` | YES |
| SortOrder | `nvarchar(8)` | YES |
| WhereClause | `nvarchar(MAX)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XMarkedForDeletion | `int` | YES |

### QBMTreeResultHasColumn  (391 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMTreeResultHasColumn | `varchar(38)` | NO |
| UID_QBMTreeResult | `varchar(38)` | YES |
| UID_DialogColumn | `varchar(38)` | YES |
| SortOrder | `float` | YES |
| ResultColumnType | `varchar(16)` | NO |
| ResultColumnValue | `nvarchar(256)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMTreeResultHasSheet  (5 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMTreeResult | `varchar(38)` | NO |
| UID_DialogSheet | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QBMTrustedSQL  (76 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMTrustedSQL | `varchar(38)` | NO |
| TrustedSQLHash | `varchar(44)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| IsManual | `bit` | YES |
| Description | `nvarchar(MAX)` | YES |
| MorphemStream | `nvarchar(MAX)` | YES |

### QBMUIDashBoard  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMUIDashBoard | `varchar(38)` | NO |
| UID_DialogDashBoardDef | `varchar(38)` | NO |
| Display | `nvarchar(128)` | YES |
| GaugeType | `nvarchar(16)` | YES |
| SortOrder | `nchar(7)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XMarkedForDeletion | `int` | YES |

### QBMUniqueGroup  (232 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMUniqueGroup | `varchar(38)` | NO |
| Ident_QBMUniqueGroup | `nvarchar(64)` | YES |
| UID_DialogTable | `varchar(38)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| IgnoreEmptyValues | `bit` | YES |
| ViolationMessage | `nvarchar(1024)` | YES |

### QBMUniqueGroupHasColumn  (361 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMUniqueGroupHasColumn | `varchar(38)` | NO |
| UID_QBMUniqueGroup | `varchar(38)` | NO |
| ObjectKeyDialogColumn | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |

### QBMUserConfig  (3 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMUserConfig | `varchar(38)` | NO |
| UID_QBMXUser | `varchar(38)` | NO |
| ApplicationName | `nvarchar(64)` | YES |
| ConfigContext | `nvarchar(64)` | YES |
| ConfigName | `nvarchar(64)` | YES |
| ConfigValue | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |

### QBMViewAddOn  (608 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMViewAddOn | `varchar(38)` | NO |
| UID_DialogTable | `varchar(38)` | NO |
| QueryString | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| IsGenerated | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| Ident_QBMViewAddOn | `nvarchar(64)` | NO |

### QBMWebApplication  (2 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMWebApplication | `varchar(38)` | NO |
| IsDebug | `bit` | YES |
| IsPrivate | `bit` | YES |
| UID_DialogProduct | `varchar(38)` | YES |
| AutoUpdateLevel | `int` | YES |
| AuthProperties | `nvarchar(1024)` | YES |
| AuthPropertiesSecondary | `nvarchar(1024)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XMarkedForDeletion | `int` | YES |
| XObjectKey | `varchar(138)` | NO |
| BaseURL | `nvarchar(1024)` | YES |
| ConfigurationData | `nvarchar(MAX)` | YES |
| UID_QBMIdentityClient | `varchar(38)` | YES |
| OAuthClientID | `nvarchar(MAX)` | YES |
| TrustedSourceKey | `varchar(218)` | YES |

### QBMXUser  (27 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMXUser | `varchar(38)` | NO |
| Ident_QBMXUser | `nvarchar(128)` | YES |
| XObjectKey | `varchar(138)` | NO |

### QBMXUserFilter  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QBMXUserFilter | `varchar(38)` | NO |
| Ident_QBMXUserFilter | `nvarchar(64)` | YES |
| UID_QBMXUser | `varchar(38)` | YES |
| UID_DialogTable | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| UID_DialogObject | `varchar(38)` | YES |
| Description | `nvarchar(MAX)` | YES |
| UID_FormatterCLRType | `varchar(38)` | YES |
| SortOrder | `nvarchar(MAX)` | YES |
| DisplayPattern | `nvarchar(MAX)` | YES |
| FilterDefinition | `nvarchar(MAX)` | YES |

### QERAssign  (16 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QERAssign | `varchar(38)` | NO |
| UID_AccProduct | `varchar(38)` | YES |
| Ident_QERAssign | `nvarchar(256)` | YES |
| Description | `nvarchar(MAX)` | YES |
| CustomProperty01 | `nvarchar(64)` | YES |
| CustomProperty02 | `nvarchar(64)` | YES |
| CustomProperty03 | `nvarchar(64)` | YES |
| CustomProperty04 | `nvarchar(64)` | YES |
| CustomProperty05 | `nvarchar(64)` | YES |
| CustomProperty06 | `nvarchar(64)` | YES |
| CustomProperty07 | `nvarchar(64)` | YES |
| CustomProperty08 | `nvarchar(64)` | YES |
| CustomProperty09 | `nvarchar(64)` | YES |
| CustomProperty10 | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| IsForITShop | `bit` | YES |
| IsITShopOnly | `bit` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndex | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| IsKeepAssignment | `bit` | YES |
| IsAutoAssignToPerson | `bit` | YES |
| IsNoInheriteToSecurityIncident | `bit` | YES |
| UID_DialogTableAssignTarget | `varchar(38)` | YES |
| ObjectKeyAssignTarget | `varchar(138)` | YES |
| UID_QERAssignPredecessor | `varchar(38)` | YES |
| UID_QERResourceType | `varchar(38)` | YES |
| IsMAllAssign | `bit` | YES |

### QERBufferRecalcDecisionMaker  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_PWODecisionRule | `varchar(38)` | NO |
| GenProcID | `varchar(38)` | YES |
| ObjectKey | `varchar(138)` | NO |
| UsageArea | `varchar(1)` | NO |
| ProcessState | `int` | YES |

### QERDynamicGroupBlackList  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DynamicGroup | `varchar(38)` | NO |
| UID_Person | `varchar(38)` | NO |
| Description | `nvarchar(MAX)` | YES |
| IsNotMatched | `bit` | YES |
| IsAssignedByOthers | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QEREntitlementSource  (460 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QEREntitlementSource | `varchar(38)` | NO |
| UID_DialogTable | `varchar(38)` | YES |
| SQLQuery | `nvarchar(MAX)` | YES |
| Ident_QEREntitlementSource | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |

### QERJustification  (21 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QERJustification | `varchar(38)` | NO |
| Ident_QERJustification | `nvarchar(128)` | YES |
| Description | `nvarchar(1024)` | YES |
| RequiresText | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| IsDecisionBySystem | `bit` | YES |
| JustificationType | `int` | YES |

### QEROrgRootHasOrgType  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_OrgType | `varchar(38)` | NO |
| UID_OrgRoot | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QERPasswordQueryAndAnswer  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QERPasswordQueryAndAnswer | `varchar(38)` | NO |
| UID_Person | `varchar(38)` | NO |
| SortOrder | `int` | YES |
| PasswordQuery | `nvarchar(256)` | YES |
| PasswordAnswer | `varchar(218)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| BadAnswerAttempts | `int` | YES |
| IsLocked | `bit` | YES |

### QERPickCategory  (2 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QERPickCategory | `varchar(38)` | NO |
| IsManual | `bit` | YES |
| DisplayName | `nvarchar(256)` | YES |
| RemoveAfterAttestationRun | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| UID_DialogTable | `varchar(38)` | YES |
| IsRandomSample | `bit` | YES |
| RandomSampleWhereClause | `nvarchar(MAX)` | YES |
| RandomSamplePickRate | `float` | YES |
| CreateRandomSampleForEachRun | `bit` | YES |

### QERPickedItem  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QERPickedItem | `varchar(38)` | NO |
| ObjectKeyItem | `varchar(138)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| UID_QERPickCategory | `varchar(38)` | NO |

### QERPolicy  (16 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QERPolicy | `varchar(38)` | NO |
| Ident_QERPolicy | `nvarchar(128)` | YES |
| Description | `nvarchar(512)` | YES |
| ImplementationNotes | `nvarchar(MAX)` | YES |
| UID_AERoleResponsible | `varchar(38)` | YES |
| UID_AERoleAttestator | `varchar(38)` | YES |
| UID_DialogScheduleFill | `varchar(38)` | YES |
| UID_QERPolicyGroup | `varchar(38)` | YES |
| IsNoWhereClause | `bit` | YES |
| WhereClause | `nvarchar(MAX)` | YES |
| WhereClauseAddOn | `nvarchar(MAX)` | YES |
| IsInActive | `bit` | YES |
| UID_QERPolicyWork | `varchar(38)` | YES |
| IsWorkingCopy | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| VersionMajor | `int` | YES |
| VersionMinor | `int` | YES |
| VersionPatch | `int` | YES |
| PolicyNumber | `nvarchar(32)` | YES |
| StateInfo | `nvarchar(16)` | YES |
| ExceptionNotes | `nvarchar(MAX)` | YES |
| RiskIndex | `float` | YES |
| TransparencyIndex | `float` | YES |
| RuleViolationThreshold | `int` | YES |
| SignificancyClass | `int` | YES |
| RuleSeverity | `float` | YES |
| IsExceptionAllowed | `bit` | YES |
| UID_AERoleRuler | `varchar(38)` | YES |
| RiskIndexReduced | `float` | YES |
| UID_DialogTable | `varchar(38)` | YES |
| XMarkedForDeletion | `int` | YES |
| UID_DialogRichMailNewViolation | `varchar(38)` | YES |
| UID_DialogReport | `varchar(38)` | YES |
| UID_DialogDashBoardDef | `varchar(38)` | YES |
| ObjectKeyAttPolicy | `varchar(138)` | YES |
| IsToAttestImmediately | `bit` | YES |

### QERPolicyGroup  (2 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QERPolicyGroup | `varchar(38)` | NO |
| Ident_QERPolicyGroup | `nvarchar(64)` | YES |
| UID_QERPolicyGroupParent | `varchar(38)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QERPolicyHasMControl  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_MitigatingControl | `varchar(38)` | NO |
| UID_QERPolicy | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QERPolicyHasObject  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QERPolicyHasObject | `varchar(38)` | NO |
| UID_QERJustification | `varchar(38)` | YES |
| UID_QERPolicy | `varchar(38)` | NO |
| ObjectKey | `varchar(138)` | NO |
| IsDecisionMade | `bit` | YES |
| IsExceptionGranted | `bit` | YES |
| DecisionDate | `datetime` | YES |
| DecisionReason | `nvarchar(1024)` | YES |
| UID_PersonDecisionMade | `varchar(38)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QERPolicyInArea  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QERPolicy | `varchar(38)` | NO |
| UID_ComplianceArea | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QERResource  (5 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QERResource | `varchar(38)` | NO |
| UID_AccProduct | `varchar(38)` | YES |
| Ident_QERResource | `nvarchar(64)` | YES |
| Description | `nvarchar(MAX)` | YES |
| CustomProperty01 | `nvarchar(64)` | YES |
| CustomProperty02 | `nvarchar(64)` | YES |
| CustomProperty03 | `nvarchar(64)` | YES |
| CustomProperty04 | `nvarchar(64)` | YES |
| CustomProperty05 | `nvarchar(64)` | YES |
| CustomProperty06 | `nvarchar(64)` | YES |
| CustomProperty07 | `nvarchar(64)` | YES |
| CustomProperty08 | `nvarchar(64)` | YES |
| CustomProperty09 | `nvarchar(64)` | YES |
| CustomProperty10 | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| IsForITShop | `bit` | YES |
| IsITShopOnly | `bit` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndex | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| IsAutoAssignToPerson | `bit` | YES |
| IsNoInheriteToSecurityIncident | `bit` | YES |
| UID_QERResourcePredecessor | `varchar(38)` | YES |
| UID_QERResourceType | `varchar(38)` | YES |

### QERResourceType  (2 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QERResourceType | `varchar(38)` | NO |
| Ident_QERResourceType | `nvarchar(64)` | NO |
| Description | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QERReuse  (9 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QERReuse | `varchar(38)` | NO |
| UID_AccProduct | `varchar(38)` | YES |
| Ident_QERReuse | `nvarchar(64)` | YES |
| Description | `nvarchar(MAX)` | YES |
| CustomProperty01 | `nvarchar(64)` | YES |
| CustomProperty02 | `nvarchar(64)` | YES |
| CustomProperty03 | `nvarchar(64)` | YES |
| CustomProperty04 | `nvarchar(64)` | YES |
| CustomProperty05 | `nvarchar(64)` | YES |
| CustomProperty06 | `nvarchar(64)` | YES |
| CustomProperty07 | `nvarchar(64)` | YES |
| CustomProperty08 | `nvarchar(64)` | YES |
| CustomProperty09 | `nvarchar(64)` | YES |
| CustomProperty10 | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| IsForITShop | `bit` | YES |
| IsITShopOnly | `bit` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndex | `float` | YES |
| IsAutoAssignToPerson | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| IsNoInheriteToSecurityIncident | `bit` | YES |
| UID_QERReusePredecessor | `varchar(38)` | YES |
| UID_QERResourceType | `varchar(38)` | YES |

### QERReuseUS  (3 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QERReuseUS | `varchar(38)` | NO |
| UID_AccProduct | `varchar(38)` | YES |
| Ident_QERReuseUS | `nvarchar(64)` | YES |
| Description | `nvarchar(MAX)` | YES |
| CustomProperty01 | `nvarchar(64)` | YES |
| CustomProperty02 | `nvarchar(64)` | YES |
| CustomProperty03 | `nvarchar(64)` | YES |
| CustomProperty04 | `nvarchar(64)` | YES |
| CustomProperty05 | `nvarchar(64)` | YES |
| CustomProperty06 | `nvarchar(64)` | YES |
| CustomProperty07 | `nvarchar(64)` | YES |
| CustomProperty08 | `nvarchar(64)` | YES |
| CustomProperty09 | `nvarchar(64)` | YES |
| CustomProperty10 | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| IsForITShop | `bit` | YES |
| IsITShopOnly | `bit` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndex | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| IsAutoAssignToPerson | `bit` | YES |
| IsNoInheriteToSecurityIncident | `bit` | YES |
| UID_QERReuseUSPredecessor | `varchar(38)` | YES |
| UID_QERResourceType | `varchar(38)` | YES |

### QERRiskIndex  (314 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QERRiskIndex | `varchar(38)` | NO |
| Weight | `float` | YES |
| QueryString | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| TypeOfCalculation | `nvarchar(3)` | YES |
| IsInActive | `bit` | YES |
| DisplayValue | `nvarchar(256)` | YES |
| Description | `nvarchar(MAX)` | YES |
| UID_DialogColumn | `varchar(38)` | YES |
| XMarkedForDeletion | `int` | YES |

### QERRiskIndexColumnDepend  (67 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_DialogColumnTarget | `varchar(38)` | NO |
| UID_DialogColumnSource | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### QERTermsOfUse  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QERTermsOfUse | `varchar(38)` | NO |
| Ident_QERTermsOfUse | `nvarchar(128)` | YES |
| Description | `nvarchar(1024)` | YES |
| DisplayContent | `nvarchar(MAX)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XTouched | `nchar(1)` | YES |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| IsAcceptRequiresMfa | `bit` | YES |

### QERTermsOfUseHasFile  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QERTermsOfUse | `varchar(38)` | NO |
| UID_DialogCulture | `varchar(38)` | NO |
| FileContent | `varbinary` | NO |
| FileName | `nvarchar(1024)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XTouched | `nchar(1)` | YES |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |

### QERUniversalSubstitute  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QERUniversalSubstitute | `varchar(38)` | NO |
| UID_PersonWantsOrg | `varchar(38)` | NO |
| UID_PersonSender | `varchar(38)` | NO |
| UID_PersonReceiver | `varchar(38)` | NO |
| IsCurrentlyActive | `bit` | YES |
| UseForITShop | `bit` | YES |
| UseForITShopCompliance | `bit` | YES |
| UseForAttestation | `bit` | YES |
| KeepMeInformed | `bit` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| OrderState | `nvarchar(16)` | YES |
| UseForHeadPerson | `bit` | YES |
| UseForHeadOrg | `bit` | YES |

### QERUniversalSubstituteInRoot  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QERUniversalSubstitute | `varchar(38)` | NO |
| UID_OrgRoot | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |

### QERWebAuthnKey  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QERWebAuthnKey | `varchar(38)` | NO |
| DisplayName | `nvarchar(64)` | YES |
| CredentialId | `varbinary` | YES |
| PublicKey | `varbinary` | YES |
| SignatureCount | `int` | YES |
| DateRegistered | `datetime` | YES |
| DateLastUsed | `datetime` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| UID_Person | `varchar(38)` | NO |
| UID_QBMIdentityProvider | `varchar(38)` | NO |

### QERWorkingMethod  (15 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QERWorkingMethod | `varchar(38)` | NO |
| Ident_PWODecisionSubMethod | `nvarchar(64)` | YES |
| XObjectKey | `varchar(138)` | NO |
| DaysToAbort | `int` | YES |
| RevisionNumber | `int` | YES |
| UID_PWODecisionSubMethod | `varchar(38)` | YES |
| LayoutInformation | `nvarchar(MAX)` | YES |

### QERWorkingStep  (31 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_QERWorkingStep | `varchar(38)` | NO |
| LevelNumber | `int` | YES |
| Ident_PWODecisionStep | `nvarchar(64)` | YES |
| SubLevelNumber | `int` | YES |
| DirectSteps | `nvarchar(256)` | YES |
| PositiveSteps | `int` | YES |
| NegativeSteps | `int` | YES |
| LevelDisplay | `nvarchar(64)` | YES |
| WhereClause | `nvarchar(MAX)` | YES |
| AutomaticReasonTrue | `nvarchar(128)` | YES |
| AutomaticReasonFalse | `nvarchar(128)` | YES |
| XObjectKey | `varchar(138)` | NO |
| CountApprover | `int` | YES |
| EscalationSteps | `int` | YES |
| MinutesReminder | `int` | YES |
| MinutesAutomaticDecision | `int` | YES |
| AutomaticDecision | `nvarchar(16)` | YES |
| IsAdditionalAllowed | `bit` | YES |
| IsInsteadOfAllowed | `bit` | YES |
| IsToHideInHistory | `bit` | YES |
| IgnoreNoDecideForPerson | `bit` | YES |
| IsNoAutoDecision | `bit` | YES |
| ObjectKeyOfAssignedOrg | `varchar(138)` | YES |
| UID_QERWorkingMethod | `varchar(38)` | NO |
| UID_PWODecisionRule | `varchar(38)` | NO |
| UID_AERoleFallBack | `varchar(38)` | YES |
| UID_DialogRichMailInsert | `varchar(38)` | YES |
| UID_DialogRichMailReminder | `varchar(38)` | YES |
| UID_DialogRichMailGrant | `varchar(38)` | YES |
| UID_DialogRichMailNoGrant | `varchar(38)` | YES |
| UID_DialogRichMailEscalate | `varchar(38)` | YES |
| UID_DialogRichMailFromDelegat | `varchar(38)` | YES |
| UID_DialogRichMailToDelegat | `varchar(38)` | YES |
| UID_PWOStateFinalSuccess | `varchar(38)` | YES |
| UID_PWOStateFinalError | `varchar(38)` | YES |
| UID_PWODecisionStep | `varchar(38)` | YES |
| EscalateIfNoApprover | `bit` | YES |
| ApproveReasonType | `int` | YES |
| DenyReasonType | `int` | YES |

### RelatedApplication  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_RelatedApplication | `varchar(38)` | NO |
| Ident_RelatedApplication | `nvarchar(64)` | YES |
| DisplayName | `nvarchar(64)` | YES |
| Description | `nvarchar(MAX)` | YES |
| JPegPhoto | `varbinary` | YES |
| URL | `nvarchar(1024)` | YES |
| DisplayType | `nvarchar(2)` | YES |
| IsInActive | `bit` | YES |
| UID_RelatedApplicationParent | `varchar(38)` | YES |
| WhereClause | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### RPSReport  (42 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_RPSReport | `varchar(38)` | NO |
| Ident_RPSReport | `nvarchar(128)` | NO |
| UID_DialogReport | `varchar(38)` | NO |
| Description | `nvarchar(MAX)` | YES |
| UID_AccProduct | `varchar(38)` | YES |
| IsForITShop | `bit` | YES |
| IsITShopOnly | `bit` | YES |
| IsInActive | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndex | `float` | YES |
| PreProcessorCondition | `nvarchar(1024)` | YES |
| IsDeactivatedByPreProcessor | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| ExportFormat | `varchar(256)` | YES |
| IsListReport | `bit` | YES |
| ReportDefinition | `nvarchar(MAX)` | YES |
| UID_PersonOwner | `varchar(38)` | YES |

### RPSSubscription  (8 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_RPSSubscription | `varchar(38)` | NO |
| Ident_RPSSubscription | `nvarchar(128)` | NO |
| UID_Person | `varchar(38)` | NO |
| UID_RPSReport | `varchar(38)` | NO |
| UID_DialogSchedule | `varchar(38)` | YES |
| IsRejected | `bit` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| ExportFormat | `varchar(16)` | YES |

### RPSSubscriptionCC  (1 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_RPSSubscription | `varchar(38)` | NO |
| UID_Person | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### ServerHasShares  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ServerHasShares | `varchar(38)` | NO |
| UID_Server | `varchar(38)` | YES |
| Ident_Share | `nvarchar(128)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| LocalPath | `nvarchar(MAX)` | YES |
| TemplateScript | `nvarchar(MAX)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| UID_OrgOwner | `varchar(38)` | YES |

### ShoppingCartItem  (1 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ShoppingCartItem | `varchar(38)` | NO |
| UID_ITShopOrg | `varchar(38)` | YES |
| UID_PersonInserted | `varchar(38)` | NO |
| UID_AccProduct | `varchar(38)` | NO |
| UID_PersonOrdered | `varchar(38)` | NO |
| Quantity | `float` | YES |
| IsActivated | `bit` | YES |
| SortOrder | `int` | YES |
| OrderReason | `nvarchar(MAX)` | YES |
| OrderDate | `datetime` | YES |
| DisplayOrg | `nvarchar(256)` | YES |
| ValidFrom | `datetime` | YES |
| ValidUntil | `datetime` | YES |
| AdditionalData | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| UID_ShoppingCartItemParent | `varchar(38)` | YES |
| IsOptionalChild | `bit` | YES |
| UID_ShoppingCartOrder | `varchar(38)` | YES |
| CustomProperty01 | `nvarchar(64)` | YES |
| CustomProperty02 | `nvarchar(64)` | YES |
| CustomProperty03 | `nvarchar(64)` | YES |
| CustomProperty04 | `nvarchar(64)` | YES |
| CustomProperty05 | `nvarchar(64)` | YES |
| CustomProperty06 | `nvarchar(64)` | YES |
| CustomProperty07 | `nvarchar(64)` | YES |
| CustomProperty08 | `nvarchar(64)` | YES |
| CustomProperty09 | `nvarchar(64)` | YES |
| CustomProperty10 | `nvarchar(64)` | YES |
| UID_PersonWantsOrg | `varchar(38)` | YES |
| MethodName | `nvarchar(64)` | YES |
| MethodParameters | `nvarchar(MAX)` | YES |
| ObjectKeyOrdered | `varchar(138)` | YES |
| PositionNumber | `int` | YES |
| ObjectKeyAssignment | `varchar(138)` | YES |
| UID_Department | `varchar(38)` | YES |
| UID_ProfitCenter | `varchar(38)` | YES |
| OrderDetail1 | `nvarchar(MAX)` | YES |
| OrderDetail2 | `nvarchar(64)` | YES |
| UID_WorkDeskOrdered | `varchar(38)` | YES |
| IsOrderForWorkDesk | `bit` | YES |
| DisplayObjectKeyAssignment | `nvarchar(256)` | YES |
| XMarkedForDeletion | `int` | YES |
| PWOPriority | `int` | YES |
| CheckResult | `int` | YES |
| CheckResultDetail | `nvarchar(MAX)` | YES |
| ObjectKeyOrgUsedInAssign | `varchar(138)` | YES |
| ObjectKeyElementUsedInAssign | `varchar(138)` | YES |
| UID_QERJustificationOrder | `varchar(38)` | YES |
| CCC_CustomDate01 | `datetime` | YES |
| CCC_CustomDate02 | `datetime` | YES |
| CCC_UID_FirmPartner | `varchar(38)` | YES |
| CCC_UID_Person01 | `varchar(38)` | YES |
| CCC_UID_Person02 | `varchar(38)` | YES |

### ShoppingCartOrder  (240 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ShoppingCartOrder | `varchar(38)` | NO |
| Ident_ShoppingCartOrder | `nvarchar(128)` | YES |
| Description | `nvarchar(256)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| UID_Person | `varchar(38)` | YES |
| DocumentNumber | `nvarchar(64)` | YES |
| XMarkedForDeletion | `int` | YES |
| ValidUntilUnsubscribe | `datetime` | YES |
| CheckStatus | `int` | YES |

### ShoppingCartPattern  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ShoppingCartPattern | `varchar(38)` | NO |
| UID_Person | `varchar(38)` | NO |
| Ident_ShoppingCartPattern | `nvarchar(64)` | YES |
| Description | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| IsPublicPattern | `bit` | YES |
| DocumentNumber | `nvarchar(64)` | YES |
| ShortName | `nvarchar(64)` | YES |
| LongName | `nvarchar(256)` | YES |
| IsQualified | `bit` | YES |
| XMarkedForDeletion | `int` | YES |

### ShoppingCartPatternItem  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_ShoppingCartPatternItem | `varchar(38)` | NO |
| UID_AccProduct | `varchar(38)` | NO |
| UID_ShoppingCartPattern | `varchar(38)` | NO |
| Quantity | `float` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| OrderDetail1 | `nvarchar(MAX)` | YES |
| OrderDetail2 | `nvarchar(16)` | YES |
| XMarkedForDeletion | `int` | YES |
| ObjectKeyOrgUsedInAssign | `varchar(138)` | YES |

### TSBAccountDef  (4 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_TSBAccountDef | `varchar(38)` | NO |
| UID_DialogTableAccountType | `varchar(38)` | YES |
| UID_AccProduct | `varchar(38)` | YES |
| Ident_TSBAccountDef | `nvarchar(64)` | YES |
| Description | `nvarchar(MAX)` | YES |
| CustomProperty01 | `nvarchar(64)` | YES |
| CustomProperty02 | `nvarchar(64)` | YES |
| CustomProperty03 | `nvarchar(64)` | YES |
| CustomProperty04 | `nvarchar(64)` | YES |
| CustomProperty05 | `nvarchar(64)` | YES |
| CustomProperty06 | `nvarchar(64)` | YES |
| CustomProperty07 | `nvarchar(64)` | YES |
| CustomProperty08 | `nvarchar(64)` | YES |
| CustomProperty09 | `nvarchar(64)` | YES |
| CustomProperty10 | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| IsForITShop | `bit` | YES |
| IsITShopOnly | `bit` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndex | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| IsAutoAssignToPerson | `bit` | YES |
| PTDInheritAccountDef | `bit` | YES |
| PFDInheritAccountDef | `bit` | YES |
| PMDInheritAccountDef | `bit` | YES |
| PSIInheritAccountDef | `bit` | YES |
| ObjectKeyTargetSystem | `varchar(138)` | NO |
| UID_TSBBehaviorDefault | `varchar(38)` | YES |
| UID_TSBAccountDefPredecessor | `varchar(38)` | YES |
| UID_QERResourceType | `varchar(38)` | YES |

### TSBAccountDefHasBehavior  (7 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_TSBAccountDef | `varchar(38)` | NO |
| UID_TSBBehavior | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### TSBBehavior  (2 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_TSBBehavior | `varchar(38)` | NO |
| Ident_TSBBehavior | `nvarchar(64)` | YES |
| Description | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| PTDInheritGroup | `bit` | YES |
| PTDLockAccount | `bit` | YES |
| PFDInheritGroup | `bit` | YES |
| PFDLockAccount | `bit` | YES |
| PMDInheritGroup | `bit` | YES |
| PMDLockAccount | `bit` | YES |
| PSIInheritGroup | `bit` | YES |
| PSILockAccount | `bit` | YES |
| ADAInheritGroup | `bit` | YES |
| ITDataUsage | `int` | YES |

### TSBITData  (2 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_TSBITData | `varchar(38)` | NO |
| UID_Org | `varchar(38)` | YES |
| ObjectKeyAppliesTo | `varchar(138)` | NO |
| UID_DialogColumnTarget | `varchar(38)` | YES |
| ObjectKeyValue | `varchar(138)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| FixValue | `nvarchar(1024)` | YES |
| DisplayValue | `nvarchar(256)` | YES |

### TSBITDataMapping  (5 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_TSBAccountDef | `varchar(38)` | NO |
| UID_DialogColumn | `varchar(38)` | NO |
| ITDataFrom | `varchar(30)` | YES |
| UseAlwaysDefaultValue | `bit` | YES |
| NotifyDefaultUsed | `bit` | YES |
| ObjectKeyDefaultValue | `varchar(138)` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| FixValue | `nvarchar(1024)` | YES |

### TSBPersonUsesAccount  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_TSBPersonUsesAccount | `varchar(38)` | NO |
| ObjectKeyAccount | `varchar(138)` | NO |
| UID_Person | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### TSBSpecificGroupBehavior  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_TSBSpecificGroupBehavior | `varchar(38)` | NO |
| ObjectKeyGroup | `varchar(138)` | NO |
| DisplayName | `nvarchar(512)` | YES |
| ModuleOwnerOfGroup | `varchar(3)` | YES |
| PFDInheritOverwrite | `int` | YES |
| PSIInheritOverwrite | `int` | YES |
| PMDInheritOverwrite | `int` | YES |
| PTDInheritOverwrite | `int` | YES |
| ADAInheritOverwrite | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### UCIContainer  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UCIContainer | `varchar(38)` | NO |
| UID_ParentUCIContainer | `varchar(38)` | YES |
| cn | `nvarchar(64)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| ObjectGUID | `varchar(256)` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| Description | `nvarchar(MAX)` | YES |
| XMarkedForDeletion | `int` | YES |
| UID_UCIRoot | `varchar(38)` | NO |
| ObjectKeyManager | `varchar(138)` | YES |
| UID_AERoleOwner | `varchar(38)` | YES |
| LastChangeDate | `datetime` | YES |

### UCIGroup  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UCIGroup | `varchar(38)` | NO |
| UID_UCIRoot | `varchar(38)` | NO |
| UID_UCIContainer | `varchar(38)` | YES |
| DisplayName | `nvarchar(400)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| CustomString01 | `nvarchar(64)` | YES |
| CustomString02 | `nvarchar(64)` | YES |
| CustomString03 | `nvarchar(64)` | YES |
| CustomString04 | `nvarchar(64)` | YES |
| CustomString05 | `nvarchar(64)` | YES |
| CustomLob01 | `nvarchar(MAX)` | YES |
| CustomLob02 | `nvarchar(MAX)` | YES |
| CustomLob03 | `nvarchar(MAX)` | YES |
| CustomLob04 | `nvarchar(MAX)` | YES |
| CustomLob05 | `nvarchar(MAX)` | YES |
| CustomDate01 | `datetime` | YES |
| CustomDate02 | `datetime` | YES |
| CustomDate03 | `datetime` | YES |
| CustomBit01 | `bit` | YES |
| CustomBit02 | `bit` | YES |
| CustomBit03 | `bit` | YES |
| CustomBit04 | `bit` | YES |
| CustomBit05 | `bit` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| cn | `nvarchar(256)` | YES |
| Description | `nvarchar(MAX)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| ObjectGUID | `varchar(256)` | YES |
| ObjectKeyManager | `varchar(138)` | YES |
| GroupType | `nvarchar(64)` | YES |
| LastChangeDate | `datetime` | YES |
| EmailAddress | `nvarchar(512)` | YES |
| GroupName | `nvarchar(128)` | YES |
| ResourceType | `nvarchar(256)` | YES |
| XDateSubItem | `datetime` | YES |

### UCIGroup1  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UCIGroup1 | `varchar(38)` | NO |
| UID_UCIRoot | `varchar(38)` | NO |
| UID_UCIContainer | `varchar(38)` | YES |
| DisplayName | `nvarchar(400)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| CustomString01 | `nvarchar(64)` | YES |
| CustomString02 | `nvarchar(64)` | YES |
| CustomString03 | `nvarchar(64)` | YES |
| CustomString04 | `nvarchar(64)` | YES |
| CustomString05 | `nvarchar(64)` | YES |
| CustomLob01 | `nvarchar(MAX)` | YES |
| CustomLob02 | `nvarchar(MAX)` | YES |
| CustomLob03 | `nvarchar(MAX)` | YES |
| CustomLob04 | `nvarchar(MAX)` | YES |
| CustomLob05 | `nvarchar(MAX)` | YES |
| CustomDate01 | `datetime` | YES |
| CustomDate02 | `datetime` | YES |
| CustomDate03 | `datetime` | YES |
| CustomBit01 | `bit` | YES |
| CustomBit02 | `bit` | YES |
| CustomBit03 | `bit` | YES |
| CustomBit04 | `bit` | YES |
| CustomBit05 | `bit` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| cn | `nvarchar(256)` | YES |
| Description | `nvarchar(MAX)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| ObjectGUID | `varchar(256)` | YES |
| ObjectKeyManager | `varchar(138)` | YES |
| GroupType | `nvarchar(64)` | YES |
| LastChangeDate | `datetime` | YES |
| EmailAddress | `nvarchar(512)` | YES |
| GroupName | `nvarchar(128)` | YES |
| ResourceType | `nvarchar(256)` | YES |
| XDateSubItem | `datetime` | YES |

### UCIGroup1InGroup1  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UCIGroup1Container | `varchar(38)` | NO |
| UID_UCIGroup1Member | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### UCIGroup2  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UCIGroup2 | `varchar(38)` | NO |
| UID_UCIRoot | `varchar(38)` | NO |
| UID_UCIContainer | `varchar(38)` | YES |
| DisplayName | `nvarchar(400)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| CustomString01 | `nvarchar(64)` | YES |
| CustomString02 | `nvarchar(64)` | YES |
| CustomString03 | `nvarchar(64)` | YES |
| CustomString04 | `nvarchar(64)` | YES |
| CustomString05 | `nvarchar(64)` | YES |
| CustomLob01 | `nvarchar(MAX)` | YES |
| CustomLob02 | `nvarchar(MAX)` | YES |
| CustomLob03 | `nvarchar(MAX)` | YES |
| CustomLob04 | `nvarchar(MAX)` | YES |
| CustomLob05 | `nvarchar(MAX)` | YES |
| CustomDate01 | `datetime` | YES |
| CustomDate02 | `datetime` | YES |
| CustomDate03 | `datetime` | YES |
| CustomBit01 | `bit` | YES |
| CustomBit02 | `bit` | YES |
| CustomBit03 | `bit` | YES |
| CustomBit04 | `bit` | YES |
| CustomBit05 | `bit` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| cn | `nvarchar(256)` | YES |
| Description | `nvarchar(MAX)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| ObjectGUID | `varchar(256)` | YES |
| ObjectKeyManager | `varchar(138)` | YES |
| GroupType | `nvarchar(64)` | YES |
| LastChangeDate | `datetime` | YES |
| EmailAddress | `nvarchar(512)` | YES |
| GroupName | `nvarchar(128)` | YES |
| ResourceType | `nvarchar(256)` | YES |
| XDateSubItem | `datetime` | YES |

### UCIGroup2InGroup2  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UCIGroup2Container | `varchar(38)` | NO |
| UID_UCIGroup2Member | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### UCIGroup3  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UCIGroup3 | `varchar(38)` | NO |
| UID_UCIRoot | `varchar(38)` | NO |
| UID_UCIContainer | `varchar(38)` | YES |
| DisplayName | `nvarchar(400)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| CustomString01 | `nvarchar(64)` | YES |
| CustomString02 | `nvarchar(64)` | YES |
| CustomString03 | `nvarchar(64)` | YES |
| CustomString04 | `nvarchar(64)` | YES |
| CustomString05 | `nvarchar(64)` | YES |
| CustomLob01 | `nvarchar(MAX)` | YES |
| CustomLob02 | `nvarchar(MAX)` | YES |
| CustomLob03 | `nvarchar(MAX)` | YES |
| CustomLob04 | `nvarchar(MAX)` | YES |
| CustomLob05 | `nvarchar(MAX)` | YES |
| CustomDate01 | `datetime` | YES |
| CustomDate02 | `datetime` | YES |
| CustomDate03 | `datetime` | YES |
| CustomBit01 | `bit` | YES |
| CustomBit02 | `bit` | YES |
| CustomBit03 | `bit` | YES |
| CustomBit04 | `bit` | YES |
| CustomBit05 | `bit` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| cn | `nvarchar(256)` | YES |
| Description | `nvarchar(MAX)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| ObjectGUID | `varchar(256)` | YES |
| ObjectKeyManager | `varchar(138)` | YES |
| GroupType | `nvarchar(64)` | YES |
| LastChangeDate | `datetime` | YES |
| EmailAddress | `nvarchar(512)` | YES |
| GroupName | `nvarchar(128)` | YES |
| ResourceType | `nvarchar(256)` | YES |
| XDateSubItem | `datetime` | YES |

### UCIGroup3InGroup3  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UCIGroup3Container | `varchar(38)` | NO |
| UID_UCIGroup3Member | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### UCIGroupHasItem  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UCIItem | `varchar(38)` | NO |
| UID_UCIGroup | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |

### UCIGroupInGroup  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UCIGroupContainer | `varchar(38)` | NO |
| UID_UCIGroupMember | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### UCIItem  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UCIItem | `varchar(38)` | NO |
| UID_UCIRoot | `varchar(38)` | NO |
| Ident_UCIItem | `nvarchar(128)` | YES |
| Description | `nvarchar(MAX)` | YES |
| ItemType | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| CustomString01 | `nvarchar(64)` | YES |
| CustomString02 | `nvarchar(64)` | YES |
| CustomString03 | `nvarchar(64)` | YES |
| CustomString04 | `nvarchar(64)` | YES |
| CustomString05 | `nvarchar(64)` | YES |
| CustomLob01 | `nvarchar(MAX)` | YES |
| CustomLob02 | `nvarchar(MAX)` | YES |
| CustomLob03 | `nvarchar(MAX)` | YES |
| CustomLob04 | `nvarchar(MAX)` | YES |
| CustomLob05 | `nvarchar(MAX)` | YES |
| CustomDate01 | `datetime` | YES |
| CustomDate02 | `datetime` | YES |
| CustomDate03 | `datetime` | YES |
| CustomBit01 | `bit` | YES |
| CustomBit02 | `bit` | YES |
| CustomBit03 | `bit` | YES |
| CustomBit04 | `bit` | YES |
| CustomBit05 | `bit` | YES |
| LastChangeDate | `datetime` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| ObjectGUID | `nvarchar(256)` | YES |

### UCIRoot  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UCIRoot | `varchar(38)` | NO |
| Ident_UCIRoot | `nvarchar(256)` | YES |
| DisplayName | `nvarchar(400)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| Description | `nvarchar(MAX)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| AlternatePropertyCaptions | `nvarchar(MAX)` | YES |
| IsManualProvisioning | `bit` | YES |
| UID_AERoleOwner | `varchar(38)` | YES |
| IsNoUserDelete | `bit` | YES |
| GroupUsageMask | `int` | YES |
| UserContainsGroupList | `int` | YES |

### UCIUser  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UCIUser | `varchar(38)` | NO |
| UID_UCIRoot | `varchar(38)` | NO |
| DisplayName | `nvarchar(400)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| AccountDisabled | `bit` | YES |
| AccountExpires | `datetime` | YES |
| AccountName | `nvarchar(256)` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| cn | `nvarchar(256)` | YES |
| Description | `nvarchar(MAX)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| FirstName | `nvarchar(64)` | YES |
| LastLogon | `datetime` | YES |
| LastName | `nvarchar(64)` | YES |
| ObjectGUID | `varchar(256)` | YES |
| Password | `varchar(990)` | YES |
| PWDLastSet | `datetime` | YES |
| UID_UCIContainer | `varchar(38)` | YES |
| CustomString01 | `nvarchar(64)` | YES |
| CustomString02 | `nvarchar(64)` | YES |
| CustomString03 | `nvarchar(64)` | YES |
| CustomString04 | `nvarchar(64)` | YES |
| CustomString05 | `nvarchar(64)` | YES |
| CustomLob01 | `nvarchar(MAX)` | YES |
| CustomLob02 | `nvarchar(MAX)` | YES |
| CustomLob03 | `nvarchar(MAX)` | YES |
| CustomLob04 | `nvarchar(MAX)` | YES |
| CustomLob05 | `nvarchar(MAX)` | YES |
| CustomDate01 | `datetime` | YES |
| CustomDate02 | `datetime` | YES |
| CustomDate03 | `datetime` | YES |
| CustomBit01 | `bit` | YES |
| CustomBit02 | `bit` | YES |
| CustomBit03 | `bit` | YES |
| CustomBit04 | `bit` | YES |
| CustomBit05 | `bit` | YES |
| EmailAddress | `nvarchar(256)` | YES |
| Alias | `nvarchar(64)` | YES |
| EmailEncoding | `nvarchar(64)` | YES |
| UID_UCIGroupPrimary | `varchar(38)` | YES |
| UID_UCIGroupPrimary2 | `varchar(38)` | YES |
| UID_DialogCulture | `varchar(38)` | YES |
| Nickname | `nvarchar(64)` | YES |
| ObjectKeyManager | `varchar(138)` | YES |
| Department | `nvarchar(128)` | YES |
| City | `nvarchar(64)` | YES |
| ZIPCode | `nvarchar(16)` | YES |
| Street | `nvarchar(MAX)` | YES |
| PostOfficeBox | `nvarchar(64)` | YES |
| Room | `nvarchar(64)` | YES |
| Phone | `nvarchar(64)` | YES |
| Mobile | `nvarchar(64)` | YES |
| EmployeeNumber | `nvarchar(64)` | YES |
| EmployeeType | `nvarchar(256)` | YES |
| Initials | `nvarchar(10)` | YES |
| Homepage | `nvarchar(1024)` | YES |
| UID_DialogTimeZone | `varchar(38)` | YES |
| Salutation | `nvarchar(64)` | YES |
| Title | `nvarchar(256)` | YES |
| FullName | `nvarchar(256)` | YES |
| NameAddOn | `nvarchar(16)` | YES |
| UID_DialogCountry | `varchar(38)` | YES |
| UID_DialogState | `varchar(38)` | YES |
| LastChangeDate | `datetime` | YES |
| Division | `nvarchar(256)` | YES |
| Organization | `nvarchar(256)` | YES |
| FormattedAddress | `nvarchar(1024)` | YES |
| ResourceType | `nvarchar(256)` | YES |
| XDateSubItem | `datetime` | YES |

### UCIUserHasGroup  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UCIGroup | `varchar(38)` | NO |
| UID_UCIUser | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### UCIUserHasGroup1  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UCIUser | `varchar(38)` | NO |
| UID_UCIGroup1 | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### UCIUserHasGroup2  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UCIUser | `varchar(38)` | NO |
| UID_UCIGroup2 | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### UCIUserHasGroup3  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UCIUser | `varchar(38)` | NO |
| UID_UCIGroup3 | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### UCIUserHasItem  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UCIUser | `varchar(38)` | NO |
| UID_UCIItem | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |

### UCIUserInGroup  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UCIGroup | `varchar(38)` | NO |
| UID_UCIUser | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### UCIUserInGroup1  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UCIUser | `varchar(38)` | NO |
| UID_UCIGroup1 | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### UCIUserInGroup2  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UCIUser | `varchar(38)` | NO |
| UID_UCIGroup2 | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### UCIUserInGroup3  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UCIUser | `varchar(38)` | NO |
| UID_UCIGroup3 | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### UNSAccountB  (16 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSAccountB | `varchar(38)` | NO |
| UID_UNSRootB | `varchar(38)` | NO |
| UID_UNSContainerB | `varchar(38)` | YES |
| UID_Person | `varchar(38)` | YES |
| cn | `nvarchar(400)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| ObjectGUID | `varchar(256)` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| IsGroupAccount | `bit` | YES |
| FirstName | `nvarchar(64)` | YES |
| LastName | `nvarchar(64)` | YES |
| AccountExpires | `datetime` | YES |
| AccountDisabled | `bit` | YES |
| MatchPatternForMembership | `bigint` | YES |
| AccountName | `nvarchar(256)` | YES |
| RiskIndexCalculated | `float` | YES |
| MemberOf | `nvarchar(MAX)` | YES |
| LastLogon | `datetime` | YES |
| PWDLastSet | `datetime` | YES |
| Description | `nvarchar(MAX)` | YES |
| Password | `varchar(990)` | YES |
| XMarkedForDeletion | `int` | YES |
| UID_TSBAccountDef | `varchar(38)` | YES |
| UID_TSBBehavior | `varchar(38)` | YES |
| IsPrivilegedAccount | `bit` | YES |
| DisplayName | `nvarchar(256)` | YES |
| IdentityType | `varchar(32)` | YES |
| NeverConnectToPerson | `int` | YES |
| XDateSubItem | `datetime` | YES |
| IsGroupAccount_UNSGroupB | `bit` | YES |
| IsGroupAccount_UNSGroupB1 | `bit` | YES |
| IsGroupAccount_UNSGroupB2 | `bit` | YES |
| IsGroupAccount_UNSGroupB3 | `bit` | YES |
| IsNeverConnectManual | `bit` | YES |

### UNSAccountBHasUNSGroupB  (7 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSGroupB | `varchar(38)` | NO |
| UID_UNSAccountB | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### UNSAccountBHasUNSGroupB1  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSAccountB | `varchar(38)` | NO |
| UID_UNSGroupB1 | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### UNSAccountBHasUNSGroupB2  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSAccountB | `varchar(38)` | NO |
| UID_UNSGroupB2 | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### UNSAccountBHasUNSGroupB3  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSAccountB | `varchar(38)` | NO |
| UID_UNSGroupB3 | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### UNSAccountBHasUNSItemB  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSAccountB | `varchar(38)` | NO |
| UID_UNSItemB | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### UNSAccountBInUNSGroupB  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSAccountB | `varchar(38)` | NO |
| UID_UNSGroupB | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### UNSAccountBInUNSGroupB1  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSAccountB | `varchar(38)` | NO |
| UID_UNSGroupB1 | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### UNSAccountBInUNSGroupB2  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSAccountB | `varchar(38)` | NO |
| UID_UNSGroupB2 | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### UNSAccountBInUNSGroupB3  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSAccountB | `varchar(38)` | NO |
| UID_UNSGroupB3 | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| RiskIndexCalculated | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### UNSContainerB  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSContainerB | `varchar(38)` | NO |
| UID_ParentUNSContainerB | `varchar(38)` | YES |
| cn | `nvarchar(64)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| ObjectGUID | `varchar(256)` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| DomainDisplayName | `nvarchar(128)` | YES |
| Description | `nvarchar(MAX)` | YES |
| XMarkedForDeletion | `int` | YES |
| UID_UNSRootB | `varchar(38)` | NO |

### UNSGroupB  (9 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSGroupB | `varchar(38)` | NO |
| UID_UNSContainerB | `varchar(38)` | YES |
| UID_AccProduct | `varchar(38)` | YES |
| cn | `nvarchar(400)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| ObjectGUID | `varchar(256)` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| IsForITShop | `bit` | YES |
| IsITShopOnly | `bit` | YES |
| MatchPatternForMembership | `bigint` | YES |
| Description | `nvarchar(MAX)` | YES |
| DisplayName | `nvarchar(255)` | YES |
| GroupType | `nvarchar(64)` | YES |
| RiskIndex | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| UID_UNSRootB | `varchar(38)` | NO |
| XDateSubItem | `datetime` | YES |
| HasReadOnlyMemberships | `bit` | YES |

### UNSGroupB1  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSGroupB1 | `varchar(38)` | NO |
| UID_UNSContainerB | `varchar(38)` | YES |
| UID_UNSRootB | `varchar(38)` | NO |
| UID_AccProduct | `varchar(38)` | YES |
| cn | `nvarchar(400)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| ObjectGUID | `varchar(256)` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| IsForITShop | `bit` | YES |
| IsITShopOnly | `bit` | YES |
| MatchPatternForMembership | `bigint` | YES |
| Description | `nvarchar(MAX)` | YES |
| DisplayName | `nvarchar(255)` | YES |
| GroupType | `nvarchar(64)` | YES |
| RiskIndex | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XDateSubItem | `datetime` | YES |
| HasReadOnlyMemberships | `bit` | YES |

### UNSGroupB1Collection  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSGroupB1Parent | `varchar(38)` | NO |
| UID_UNSGroupB1Child | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| LevelNumber | `int` | YES |
| IsCircular | `bit` | YES |
| XMarkedForDeletion | `int` | YES |

### UNSGroupB1Exclusion  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSGroupB1Lower | `varchar(38)` | NO |
| UID_UNSGroupB1Higher | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### UNSGroupB1InUNSGroupB1  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSGroupB1Parent | `varchar(38)` | NO |
| UID_UNSGroupB1Child | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### UNSGroupB2  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSGroupB2 | `varchar(38)` | NO |
| UID_UNSContainerB | `varchar(38)` | YES |
| UID_UNSRootB | `varchar(38)` | NO |
| UID_AccProduct | `varchar(38)` | YES |
| cn | `nvarchar(400)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| ObjectGUID | `varchar(256)` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| IsForITShop | `bit` | YES |
| IsITShopOnly | `bit` | YES |
| MatchPatternForMembership | `bigint` | YES |
| Description | `nvarchar(MAX)` | YES |
| DisplayName | `nvarchar(255)` | YES |
| GroupType | `nvarchar(64)` | YES |
| RiskIndex | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XDateSubItem | `datetime` | YES |
| HasReadOnlyMemberships | `bit` | YES |

### UNSGroupB2Collection  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSGroupB2Parent | `varchar(38)` | NO |
| UID_UNSGroupB2Child | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| LevelNumber | `int` | YES |
| IsCircular | `bit` | YES |
| XMarkedForDeletion | `int` | YES |

### UNSGroupB2Exclusion  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSGroupB2Lower | `varchar(38)` | NO |
| UID_UNSGroupB2Higher | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### UNSGroupB2InUNSGroupB2  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSGroupB2Parent | `varchar(38)` | NO |
| UID_UNSGroupB2Child | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### UNSGroupB3  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSGroupB3 | `varchar(38)` | NO |
| UID_UNSContainerB | `varchar(38)` | YES |
| UID_UNSRootB | `varchar(38)` | NO |
| UID_AccProduct | `varchar(38)` | YES |
| cn | `nvarchar(400)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| ObjectGUID | `varchar(256)` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| IsForITShop | `bit` | YES |
| IsITShopOnly | `bit` | YES |
| MatchPatternForMembership | `bigint` | YES |
| Description | `nvarchar(MAX)` | YES |
| DisplayName | `nvarchar(255)` | YES |
| GroupType | `nvarchar(64)` | YES |
| RiskIndex | `float` | YES |
| XMarkedForDeletion | `int` | YES |
| XDateSubItem | `datetime` | YES |
| HasReadOnlyMemberships | `bit` | YES |

### UNSGroupB3Collection  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSGroupB3Parent | `varchar(38)` | NO |
| UID_UNSGroupB3Child | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| LevelNumber | `int` | YES |
| IsCircular | `bit` | YES |
| XMarkedForDeletion | `int` | YES |

### UNSGroupB3Exclusion  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSGroupB3Lower | `varchar(38)` | NO |
| UID_UNSGroupB3Higher | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### UNSGroupB3InUNSGroupB3  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSGroupB3Parent | `varchar(38)` | NO |
| UID_UNSGroupB3Child | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### UNSGroupBCollection  (9 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSGroupBParent | `varchar(38)` | NO |
| UID_UNSGroupBChild | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| LevelNumber | `int` | YES |
| IsCircular | `bit` | YES |
| XMarkedForDeletion | `int` | YES |

### UNSGroupBExclusion  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSGroupBLower | `varchar(38)` | NO |
| UID_UNSGroupBHigher | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### UNSGroupBHasUnsItemB  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSItemB | `varchar(38)` | NO |
| UID_UNSGroupB | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### UNSGroupBInUNSGroupB  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSGroupBChild | `varchar(38)` | NO |
| UID_UNSGroupBParent | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### UNSItemB  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSItemB | `varchar(38)` | NO |
| Ident_UNSItemB | `nvarchar(128)` | YES |
| Description | `nvarchar(MAX)` | YES |
| ItemType | `nvarchar(64)` | YES |
| CustomProperty01 | `nvarchar(64)` | YES |
| CustomProperty02 | `nvarchar(64)` | YES |
| CustomProperty03 | `nvarchar(64)` | YES |
| CustomProperty04 | `nvarchar(64)` | YES |
| CustomProperty05 | `nvarchar(64)` | YES |
| CustomProperty06 | `nvarchar(64)` | YES |
| CustomProperty07 | `nvarchar(64)` | YES |
| CustomProperty08 | `nvarchar(64)` | YES |
| CustomProperty09 | `nvarchar(64)` | YES |
| CustomProperty10 | `nvarchar(64)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| UID_UNSRootB | `varchar(38)` | NO |
| XDateSubItem | `datetime` | YES |

### UNSRootB  (1 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_UNSRootB | `varchar(38)` | NO |
| Ident_UNSRoot | `nvarchar(64)` | NO |
| UID_TSBAccountDef | `varchar(38)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| Description | `nvarchar(MAX)` | YES |
| AlternatePropertyCaptions | `nvarchar(MAX)` | YES |
| UID_AERoleOwner | `varchar(38)` | YES |
| MatchPatternDisplay | `nvarchar(MAX)` | YES |
| DisplayName | `nvarchar(128)` | YES |
| NamespaceManagedBy | `nvarchar(16)` | YES |
| DistinguishedName | `nvarchar(400)` | YES |
| CanonicalName | `nvarchar(400)` | YES |
| isMemberOfEnabled | `bit` | YES |
| UID_SyncServer | `varchar(38)` | YES |
| AccountToPersonMatchingRule | `nvarchar(MAX)` | YES |
| XMarkedForDeletion | `int` | YES |
| UID_DPRNameSpace | `varchar(38)` | YES |
| IsNoWrite | `bit` | YES |
| UsesContainer | `bit` | YES |
| GroupUsageMask | `int` | YES |
| UserContainsGroupList | `int` | YES |
| DeleteDelayDays | `int` | YES |

### WorkDesk  (1 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_WorkDesk | `varchar(38)` | NO |
| UID_OS | `varchar(38)` | YES |
| UID_PersonExamResponsible | `varchar(38)` | YES |
| UID_ProfitCenter | `varchar(38)` | YES |
| UID_Department | `varchar(38)` | YES |
| UID_PersonWorkDeskResponsible | `varchar(38)` | YES |
| Description | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| Floor | `nvarchar(32)` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| UID_Locality | `varchar(38)` | YES |
| Room | `nvarchar(64)` | YES |
| RoomRemarks | `nvarchar(MAX)` | YES |
| Phone | `nvarchar(MAX)` | YES |
| Commentary | `nvarchar(256)` | YES |
| ExaminationDate | `datetime` | YES |
| ExaminationComment | `nvarchar(MAX)` | YES |
| DiskDriveNeeded | `bit` | YES |
| CDDriveNeeded | `bit` | YES |
| FaxDescription | `nvarchar(32)` | YES |
| Fax | `nvarchar(MAX)` | YES |
| InstallDate | `datetime` | YES |
| Ident_WorkDesk | `nvarchar(64)` | YES |
| InternalName | `nvarchar(64)` | YES |
| DisplayName | `nvarchar(64)` | YES |
| CustomProperty01 | `nvarchar(64)` | YES |
| CustomProperty02 | `nvarchar(64)` | YES |
| CustomProperty03 | `nvarchar(64)` | YES |
| CustomProperty04 | `nvarchar(64)` | YES |
| CustomProperty05 | `nvarchar(64)` | YES |
| CustomProperty06 | `nvarchar(64)` | YES |
| CustomProperty07 | `nvarchar(64)` | YES |
| CustomProperty08 | `nvarchar(64)` | YES |
| CustomProperty09 | `nvarchar(64)` | YES |
| CustomProperty10 | `nvarchar(64)` | YES |
| RentCharge | `int` | YES |
| EstablishDate | `datetime` | YES |
| EndOfUse | `datetime` | YES |
| Building | `nvarchar(32)` | YES |
| ServiceType | `nvarchar(32)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| IsNoInherite | `bit` | YES |
| XMarkedForDeletion | `int` | YES |
| UID_WorkDeskType | `varchar(38)` | YES |
| UID_WorkDeskState | `varchar(38)` | YES |
| UID_Org | `varchar(38)` | YES |

### WorkDeskHasESet  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_WorkDesk | `varchar(38)` | NO |
| UID_ESet | `varchar(38)` | NO |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XIsInEffect | `bit` | YES |

### WorkDeskInBaseTree  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_Org | `varchar(38)` | NO |
| UID_WorkDesk | `varchar(38)` | NO |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
| XOrigin | `int` | YES |

### WorkDeskState  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_WorkDeskState | `varchar(38)` | NO |
| Ident_WorkDeskState | `nvarchar(64)` | NO |
| ShortDescription | `nvarchar(64)` | YES |
| Description | `nvarchar(MAX)` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |

### WorkDeskType  (0 rows)

| Column | Type | Nullable |
|--------|------|----------|
| UID_WorkDeskType | `varchar(38)` | NO |
| Ident_WorkDeskType | `nvarchar(64)` | NO |
| Description | `nvarchar(MAX)` | YES |
| DiskDriveNeeded | `bit` | YES |
| CDDriveNeeded | `bit` | YES |
| DisplayName | `nvarchar(64)` | YES |
| RentCharge | `int` | YES |
| XDateInserted | `datetime` | YES |
| XDateUpdated | `datetime` | YES |
| XUserInserted | `nvarchar(64)` | YES |
| XUserUpdated | `nvarchar(64)` | YES |
| ShortDescription | `nvarchar(MAX)` | YES |
| XTouched | `nchar(1)` | YES |
| XObjectKey | `varchar(138)` | NO |
| XMarkedForDeletion | `int` | YES |
