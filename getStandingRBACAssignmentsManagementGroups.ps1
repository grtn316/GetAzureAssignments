# Get Current Directory
$OutputPath = $(Get-Location).Path

# Get Current Context
$CurrentContext = Get-AzContext

# Get Azure Management Groups
$ManagementGroups = Get-AzManagementGroup

# Get Role roles in foreach loop
$report = @()

foreach ($ManagementGroup in $ManagementGroups) {

    #Choose management group
    Write-Verbose "Changing to Management Group $($ManagementGroup.DisplayName)" -Verbose

    $Context = Set-AzContext -TenantId $ManagementGroup.TenantId #-SubscriptionId $ManagementGroup.SubscriptionId -Force

    #Getting information about Role Assignments for chosen management group
    Write-Verbose "Getting information about Role Assignments..." -Verbose
    $roles = Get-AzRoleAssignment -Scope $ManagementGroup.Id | Select-Object RoleDefinitionName,DisplayName,SignInName,ObjectId,ObjectType,Scope,
    @{name="TenantId";expression = {$ManagementGroup.TenantId}},@{name="ManagementGroupName";expression = {$ManagementGroup.DisplayName}},@{name="ManagementGroupId";expression = {$ManagementGroup.Id}}

    foreach ($role in $roles){

        $DisplayName = $role.DisplayName
        $SignInName = $role.SignInName
        $ObjectType = $role.ObjectType
        $RoleDefinitionName = $role.RoleDefinitionName
        $AssignmentScope = $role.Scope
        $ManagementGroupName = $ManagementGroup.DisplayName
        $ManagementGroupId = $ManagementGroup.Id

        #Check for Custom Role
        $CheckForCustomRole = Get-AzRoleDefinition -Name $RoleDefinitionName
        $CustomRole = $CheckForCustomRole.IsCustom

        #New PSObject
        $obj = New-Object -TypeName PSObject
        $obj | Add-Member -MemberType NoteProperty -Name ManagementGroupName -value $ManagementGroupName
        $obj | Add-Member -MemberType NoteProperty -Name ManagementGroupId -value $ManagementGroupId
        $obj | Add-Member -MemberType NoteProperty -Name DisplayName -Value $DisplayName
        $obj | Add-Member -MemberType NoteProperty -Name SignInName -Value $SignInName
        $obj | Add-Member -MemberType NoteProperty -Name ObjectType -value $ObjectType
        $obj | Add-Member -MemberType NoteProperty -Name RoleDefinitionName -value $RoleDefinitionName
        $obj | Add-Member -MemberType NoteProperty -Name CustomRole -value $CustomRole
        $obj | Add-Member -MemberType NoteProperty -Name AssignmentScope -value $AssignmentScope

        $Report += $obj
    }
}

if ($OutputPath) {
    #Export to CSV file
    Write-Verbose "Exporting CSV file to $OutputPath" -Verbose
    $Report | Export-Csv $OutputPath\StandingRBACAssignmentsManagementGroups-$(Get-Date -Format "yyyy-MM-dd").csv
} else {
    $Report
}
