$currentDir = $(Get-Location).Path
$oFile = "$($currentDir)\StandingRBACAssignments.csv"

if(Test-Path $oFile){
	Remove-Item $oFile -Force
}
"roleName,roleDescription,IsCustom,actions,NotActions,dataActions,notDataActions,AssignableScopes,associatedEntity" | Out-File $oFile -Append -Encoding ASCII

$allObjects	= @()

Get-AzRoleDefinition | ForEach-Object{

	$object = New-Object PSObject
	$roleName = $_.Name
	Write-Host "Processing Role : $roleName"
	$object | add-member NoteProperty roleName $roleName
	$object | add-member NoteProperty roleDescription $_.Description
	$object | add-member NoteProperty IsCustom $_.IsCustom
	$object | add-member NoteProperty actions ($_.actions -Join " ; ")
	$object | add-member NoteProperty NotActions ($_.NotActions -Join " ; ")
	$object | add-member NoteProperty dataActions ($_.dataActions -Join " ; ")
	$object | add-member NoteProperty notDataActions ($_.notDataActions -Join " ; ")
	$object | add-member NoteProperty AssignableScopes ($_.AssignableScopes -Join " ; ")
	
	$associatedEntity = ''
	Get-AzRoleAssignment -RoleDefinitionName $roleName | ForEach-Object{
		$associatedEntity = $associatedEntity +$_.DisplayName + ";"
	}
	$associatedEntity = $associatedEntity.TrimEnd(";")
	$object | add-member NoteProperty associatedEntity $associatedEntity
	$allObjects += $object
}

$allObjects | Export-Csv $oFile -NoClobber -Encoding ASCII -Append -NoTypeInformation