################################################################################
################################################################################
## Script description                                                         ##
##                                                                            ##
## Name      : Get-Hotfix2.ps1                                                ##
## Version   : 0.1                                                            ##
## Date      :                                                                ##
## Language  : PowerShell cmd-lets                                            ##
## License   : MIT                                                            ##
## Owner     : M.G                                                            ##
## Authors   : M.G                                                            ##
################################################################################
################################################################################
Invoke-Command -ComputerName server1,server2,{
    $Patches = 'KB3011780'
          
    Get-HotFix -Id $Patches
} -Credential (Get-Credential) -ErrorAction SilentlyContinue -ErrorVariable Problem
 
foreach ($p in $Problem) {
    if ($p.origininfo.pscomputername) {
        Write-Warning -Message "Patch not found on $($p.origininfo.pscomputername)" 
    }
    elseif ($p.targetobject) {
        Write-Warning -Message "Unable to connect to $($p.targetobject)"
    }
}
