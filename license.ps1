# Path to the CSV file containing a list of UPNs 
$usersCSV = @("users.csv", "users_custom.csv", "users_null.csv")

# Name of the Azure AD license we want to assign
$planName = "FLOW_FREE"

# Get the license SKU ID  
$skuId = (Get-AzureADSubscribedSku | Where-Object {$_.SkuPartNumber -eq $planName}).SkuID

# Import the list of UPNs
Import-Csv $usersCSV | ForEach-Object {    
    # Set up the license object for this user
    $License = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense
    $License.SkuId = $skuId
    
    # Assign the license
    $LicensesToAssign = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses
    $LicensesToAssign.AddLicenses = $License

    Set-AzureADUserLicense -ObjectId $_.username -AssignedLicenses $LicensesToAssign
}