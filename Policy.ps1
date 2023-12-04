# Policy 1: Require MFA for Administrator Group

$conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
$conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
$conditions.Applications.IncludeApplications = "all"
$conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
$conditions.Users.IncludeGroups = "326631f9-b2fe-4a75-9db1-93aaf542f6a6" #Administrator Group
$emergency = Get-AzureADUser -ObjectId "EmergencyAccount@M365x38667126.onmicrosoft.com"
$conditions.Users.ExcludeUsers = @($emergency.ObjectId, "96a30619-cdaf-403a-9678-f313289f1379")
$controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
$controls._Operator = "OR"
$controls.BuiltInControls = "mfa"
New-AzureADMSConditionalAccessPolicy -DisplayName "CA001: Require MFA for Administrator Group (Powershell)" -State "disabled" -Conditions $conditions -GrantControls $controls

# Policy 2: Require MFA for unstrusted location

$conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
$conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
$conditions.Applications.IncludeApplications = @("office365", "00000003-0000-0ff1-ce00-000000000000", "00000002-0000-0ff1-ce00-000000000000")
$conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
$conditions.Users.IncludeUsers = "all"
$emergency = Get-AzureADUser -ObjectId "EmergencyAccount@M365x38667126.onmicrosoft.com"
$conditions.Users.ExcludeUsers = @($emergency.ObjectId, "96a30619-cdaf-403a-9678-f313289f1379")
$conditions.Locations = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessLocationCondition
$conditions.Locations.IncludeLocations = "all"
$conditions.Locations.ExcludeLocations = "AllTrusted"
$controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
$controls._Operator = "OR"
$controls.BuiltInControls = "mfa"
New-AzureADMSConditionalAccessPolicy -DisplayName "CA002: Require MFA for unstrusted location (Powershell)" -State "disabled" -Conditions $conditions -GrantControls $controls

# Policy 3: Block download from unstrusted location

$conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
$conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
$conditions.Applications.IncludeApplications = @("office365", "00000003-0000-0ff1-ce00-000000000000", "00000002-0000-0ff1-ce00-000000000000")
$conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
$conditions.Users.IncludeUsers = "all"
$emergency = Get-AzureADUser -ObjectId "EmergencyAccount@M365x38667126.onmicrosoft.com"
$conditions.Users.ExcludeUsers = @($emergency.ObjectId, "96a30619-cdaf-403a-9678-f313289f1379")
$conditions.Locations = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessLocationCondition
$conditions.Locations.IncludeLocations = "all"
$conditions.Locations.ExcludeLocations = "AllTrusted"
$session = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessSessionControls
$sessioncontrols = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessCloudAppSecurity
$sessioncontrols.CloudAppSecurityType = "BlockDownloads"
$sessioncontrols.IsEnabled = $true
$session.CloudAppSecurity = $sessioncontrols
New-AzureADMSConditionalAccessPolicy -DisplayName "CA003: Block download from unstrusted location (Powershell)" -State "disabled" -Conditions $conditions -SessionControls $session

# Policy 4: Require approved mobile app to access

$conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
$conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
$conditions.Applications.IncludeApplications = @("office365", "00000003-0000-0ff1-ce00-000000000000", "00000002-0000-0ff1-ce00-000000000000")
$conditions.Platforms = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessPlatformCondition
$conditions.Platforms.IncludePlatforms = @("android", "iOS")
$conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
$conditions.Users.IncludeUsers = "all"
$emergency = Get-AzureADUser -ObjectId "EmergencyAccount@M365x38667126.onmicrosoft.com"
$conditions.Users.ExcludeUsers = @($emergency.ObjectId, "96a30619-cdaf-403a-9678-f313289f1379")
$controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
$controls._Operator = "AND"
$controls.BuiltInControls = "compliantApplication"
New-AzureADMSConditionalAccessPolicy -DisplayName "CA004: Require approved mobile app to access (Powershell)" -State "disabled" -Conditions $conditions -GrantControls $controls

# Policy 5: Require MFA for specific groups in Office 365

$conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
$conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
$conditions.Applications.IncludeApplications = "all"
$conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
$conditions.Users.IncludeGroups = "0648b1ca-c704-48f9-a54e-3c87356b487a" #Administrator Group
$emergency = Get-AzureADUser -ObjectId "EmergencyAccount@M365x38667126.onmicrosoft.com"
$conditions.Users.ExcludeUsers = @($emergency.ObjectId, "96a30619-cdaf-403a-9678-f313289f1379")
$controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
$controls._Operator = "OR"
$controls.BuiltInControls = "mfa"
New-AzureADMSConditionalAccessPolicy -DisplayName "CA005: Require MFA for specific groups in Office 365 (Powershell)" -State "disabled" -Conditions $conditions -GrantControls $controls

# Policy 6: Require compliant devices to access resource (Need Microsoft Endpoint Manager)

$conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
$conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
$conditions.Applications.IncludeApplications = @("office365", "00000003-0000-0ff1-ce00-000000000000", "00000002-0000-0ff1-ce00-000000000000")
$conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
$conditions.Users.IncludeUsers = "all"
$emergency = Get-AzureADUser -ObjectId "EmergencyAccount@M365x38667126.onmicrosoft.com"
$conditions.Users.ExcludeUsers = @($emergency.ObjectId, "96a30619-cdaf-403a-9678-f313289f1379")
$controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
$controls._Operator = "OR"
$controls.BuiltInControls = "compliantDevice"
New-AzureADMSConditionalAccessPolicy -DisplayName "CA006: Require compliant devices to access resource (Powershell)" -State "disabled" -Conditions $conditions -GrantControls $controls

# Policy 7: Block download from Non-compliance devices (Need Microsoft Endpoint Manager)

$conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
$conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
$conditions.Applications.IncludeApplications = @("office365", "00000003-0000-0ff1-ce00-000000000000", "00000002-0000-0ff1-ce00-000000000000")
$conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
$conditions.Users.IncludeUsers = "all"
$emergency = Get-AzureADUser -ObjectId "EmergencyAccount@M365x38667126.onmicrosoft.com"
$conditions.Users.ExcludeUsers = @($emergency.ObjectId, "96a30619-cdaf-403a-9678-f313289f1379")
$session = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessSessionControls
$sessioncontrols = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessCloudAppSecurity
$sessioncontrols.CloudAppSecurityType = "BlockDownloads"
$sessioncontrols.IsEnabled = $true
$session.CloudAppSecurity = $sessioncontrols
$controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
$controls._Operator = "OR"
$controls.BuiltInControls = "compliantDevice"
New-AzureADMSConditionalAccessPolicy -DisplayName "CA007: Block download from Non-compliance devices (Powershell)" -State "disabled" -Conditions $conditions -SessionControls $session -GrantControls $controls

# Policy 12: Require multifactor authentication for guest access (Powershell)

$invitation = New-AzureADMSInvitation -InvitedUserEmailAddress demogestusers@gmail.com -SendInvitationMessage $True -InviteRedirectUrl "https://portal.azure.com/"
$conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
$conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
$conditions.Applications.IncludeApplications = "all"
$conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
$conditions.Users.IncludeUsers = "GuestsOrExternalUsers"
$emergency = Get-AzureADUser -ObjectId "EmergencyAccount@M365x38667126.onmicrosoft.com"
$conditions.Users.ExcludeUsers = @($emergency.ObjectId, "96a30619-cdaf-403a-9678-f313289f1379")
$controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
$controls._Operator = "AND"
$controls.BuiltInControls = "mfa"
New-AzureADMSConditionalAccessPolicy -DisplayName "CA012: Require multifactor authentication for guest users (Powershell)" -State "disabled" -Conditions $conditions -GrantControls $controls

# Policy 13: Sign-in risk-based multifactor authentication (Powershell)

$conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
$conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
$conditions.Applications.IncludeApplications = "all"
$conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
$conditions.Users.IncludeUsers = "all"
$emergency = Get-AzureADUser -ObjectId "EmergencyAccount@M365x38667126.onmicrosoft.com"
$conditions.Users.ExcludeUsers = @($emergency.ObjectId, "96a30619-cdaf-403a-9678-f313289f1379")
$conditions.SignInRiskLevels = New-Object -TypeName System.Collections.Generic.List[Microsoft.Open.MSGraph.Model.ConditionalAccessRiskLevel]
$conditions.SignInRiskLevels = @( "high", "medium" )
$controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
$controls._Operator = "AND"
$controls.BuiltInControls = "mfa"
$session = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessSessionControls
$sessioncontrols = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessSignInFrequency
$sessioncontrols.type = "hours"
$sessioncontrols.Value = 1
$sessioncontrols.IsEnabled = $true
$session.SignInFrequency = $sessioncontrols
New-AzureADMSConditionalAccessPolicy -DisplayName "CA013: Sign-in risk-based multifactor authentication (Powershell)" -State "disabled" -Conditions $conditions -GrantControls $controls -SessionControls $session

# Policy 14: Require multifactor authentication for admins accessing Microsoft admin portals

$conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
$conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
$conditions.Applications.IncludeApplications = "MicrosoftAdminPortals"
$conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
$conditions.Users.includeRoles = @(
"9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3", # Global Administrator
"729827e3-9c14-49f7-bb1b-9608f156bbb8", # Authentication Administrator
"17315797-102d-40b4-93e0-432062caca18", # Cloud Application Administrator
"b1be1c3e-b65d-4f19-8427-f6fa0d97feb9", # Security Administrator
"74ef975b-6605-40af-a5d2-b9539d836353", # External Identity Provider Administrator
"b0f54661-2d74-4c50-afa3-1ec803f12efe", # Application Administrator
"c4e39bd9-1100-46d3-8c65-fb160da0071f", # Cloud Device Administrator
"b1be1c3e-b65d-4f19-8427-f6fa0d97feb9", # Conditional Access Administrator
"3edaf663-341e-4475-9f94-5c398ef6c070", # Exchange Administrator  
"4d6ac14f-3453-41d0-bef9-a3e0c569773a", # Helpdesk Administrator
"7be44c8a-adaf-4e2a-84d6-ab2649e08a13", # Password Administrator  
"9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3", # Privileged Authentication Administrator
"e8611ab8-c189-46e8-94e1-60213ab1f814", # Privileged Role Administrator
"194ae4cb-b126-40b2-bd5b-6091b380977d", # Security Reader  
"f023fd81-a637-4b56-95fd-791ac0226033", # SharePoint Administrator
"f2ef992c-3afb-46b9-b7cf-a126ee74c451"  # User Administrator
)
$emergency = Get-AzureADUser -ObjectId "EmergencyAccount@M365x38667126.onmicrosoft.com"
$conditions.Users.ExcludeUsers = @($emergency.ObjectId, "96a30619-cdaf-403a-9678-f313289f1379")
$controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
$controls._Operator = "AND"
$controls.BuiltInControls = "mfa"
New-AzureADMSConditionalAccessPolicy -DisplayName "CA014: Require multifactor authentication for admins accessing Microsoft admin portals (Powershell)" -State "disabled" -Conditions $conditions -GrantControls $controls

# Policy 15: Non persistence sign-in 

$conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
$conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
$conditions.Applications.IncludeApplications = "office365"
$conditions.ClientAppTypes = New-Object -TypeName System.Collections.Generic.List[Microsoft.Open.MSGraph.Model.ConditionalAccessClientApp]
$conditions.ClientAppTypes = "all"
$conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
$conditions.Users.IncludeUsers = "all"
$emergency = Get-AzureADUser -ObjectId "EmergencyAccount@M365x38667126.onmicrosoft.com"
$conditions.Users.ExcludeUsers = @($emergency.ObjectId, "96a30619-cdaf-403a-9678-f313289f1379")
$controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
$controls._Operator = "AND"
$controls.BuiltInControls = "mfa"
$session = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessSessionControls
$sessioncontrols = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessSignInFrequency
$sessioncontrols.type = "hours"
$sessioncontrols.Value = 1
$sessioncontrols.IsEnabled = $true
$session.SignInFrequency = $sessioncontrols
New-AzureADMSConditionalAccessPolicy -DisplayName "CA015: Non persistence sign-in (Powershell)" -State "disabled" -Conditions $conditions -SessionControls $session -GrantControls $controls