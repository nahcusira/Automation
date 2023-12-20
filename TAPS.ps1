# Step 1: Connect Azure CLI

# az login --tenant "Your tenant"

# Step 2: Connect AzureAD

# Connect-AzureAD -TenantId "Your tenant"

# Step 3: .\Automation.ps1

terraform init
terraform plan -out=tfplan
terraform apply tfplan
.\Policy.ps1
.\license.ps1
