#region params
param (
    [Parameter(Mandatory = $true)]
    [string]$SubscriptionId
)
#endregion

#region main
$currentDir = $(Get-Location).Path
$currentDT = Get-Date -Format "yyyy-MM-dd_HH-mm"
$oFile = "$($currentDir)\PIMAssignmentInfo_$($currentDT).csv"

$EligiblePIMData = @()

$scope = "/subscriptions/$SubscriptionId"
Write-Host "Getting PIM Eligible Assignments for $scope"
$EligileAssignments = Get-AzRoleEligibilityScheduleInstance -Scope $scope

foreach ($Role in $EligileAssignments) {
    $upnData = ""
    if ($Role.PrincipalType -eq "User") {
        $upnData = $Role.PrincipalEmail
    }
    $PIMProperties = [pscustomobject]@{
        scope  = $Role.Scope
        type   = $Role.PrincipalType
        role   = $Role.RoleDefinitionDisplayName
        object = $Role.PrincipalDisplayName
        upn    = $upnData
    }
    $EligiblePIMData += $PIMProperties
}

$EligiblePIMData | FT
$EligiblePIMData | Export-Csv $oFile -NoClobber -Encoding ASCII -NoTypeInformation
#endregion