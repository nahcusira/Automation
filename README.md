# Automation create user on azure with role, group, license, password random, username follow file csv, save username, password to file csv and deploy all of policy 

# Step 1: Configure the PowerShell script execution policy on a system

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted

# Step 2: Install Azure Active Directory PowerShell for Graph

Install-Module AzureAD

# Step 3: Install Azure PowerShell

Install-Module -Name Az -Repository PSGallery -Force

# Step 4: Connect Azure CLI

az login --tenant "Your tenant"

# Step 5: Connect AzureAD

Connect-AzureAD -TenantId "Your tenant"

# Step 6: Run Script

.\TAPS.ps1
