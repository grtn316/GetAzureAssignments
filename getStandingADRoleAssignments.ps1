# Install and import the Microsoft Graph PowerShell module
Install-Module Microsoft.Graph.Authentication -Scope CurrentUser
Import-Module Microsoft.Graph.Authentication

# Authenticate to Microsoft Graph using the Azure AD app
#Connect-Graph -Scopes "Directory.Read.All"

#Get Current Directory
$OutputPath = $(Get-Location).Path

# Create an array to store the results
$results = @()

# Fetch all directory roles
$roles = Invoke-GraphRequest -Uri "https://graph.microsoft.com/v1.0/directoryRoles"

foreach ($role in $roles.value)
{
    $roleId = $role.id

    # Fetch the role's assignments
    $roleAssignments = Invoke-GraphRequest -Uri "https://graph.microsoft.com/v1.0/directoryRoles/$($roleId)/members"

    # Loop through each assignment and get its scope and assigned user/group
    foreach ($roleAssignment in $roleAssignments.value) {
        $assignedObjectId = $roleAssignment.id
        $assignedObject = Invoke-GraphRequest -Uri "https://graph.microsoft.com/v1.0/users/$($assignedObjectId)"

        # Determine the scope of the assignment
        if ($roleAssignment.appRoleId -eq $null) {
            $scope = "Tenant"
            $scopeId = "/"
        } else {
            $scope = $roleAssignment.resourceScopes
            $scopeId = $roleAssignment.resourceId
        }

        # Add the result to the array
        $result = [PSCustomObject]@{
            Scope = $scope
            ScopeId = $scopeId
            User = $assignedObject.displayName
            UserId = $assignedObject.id
            Role = $role.displayName
        }
        $results += $result
    }
}

# Output the results to a CSV file
#$results | Export-Csv -Path "C:\path\to\output.csv" -NoTypeInformation

if ($OutputPath) {
  #Export to CSV file
  Write-Verbose "Exporting CSV file to $OutputPath" -Verbose
  $results | Export-Csv $OutputPath\StandingADRoleAssignments-$(Get-Date -Format "yyyy-MM-dd").csv

}else {
  $results
}