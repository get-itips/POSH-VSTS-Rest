<#
.SYNOPSIS  
    A module for using the VSTS Rest API published by Microsoft https://docs.microsoft.com/en-us/rest/api/vsts/?view=vsts-rest-4.1
.DESCRIPTION  
    This module uses the VSTS Rest API to manipulate and query projects
    
.NOTES  
    File Name    : VSTSPS.psm1
    Author       : Andres Gorzelany - andresg@capazero.net
    Requires     : PowerShell V3
    Dependencies : N/A
#>

$ScriptPath = Split-Path $MyInvocation.MyCommand.Path
#region Load Public Functions

    Get-ChildItem "$ScriptPath\Public" -Filter *.ps1 -Recurse| Select-Object -Expand FullName | ForEach-Object {
        $Function = Split-Path $_ -Leaf
        try {
            . $_
        } catch {
            Write-Warning ("{0}: {1}" -f $Function,$_.Exception.Message)
        }
   }

#endregion

#region Load Private Functions

    Get-ChildItem "$ScriptPath\Private" -Filter *.ps1 -Recurse | Select-Object -Expand FullName | ForEach-Object {
        $Function = Split-Path $_ -Leaf
        try {
            . $_
        } catch {
            Write-Warning ("{0}: {1}" -f $Function,$_.Exception.Message)
        }
    }

#endregion