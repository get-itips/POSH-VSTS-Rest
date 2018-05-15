Function Test-VSTSSession {
    <#
    .SYNOPSIS
        Check that the VSTSSession object has data
    #>
        [cmdletBinding()]
        param (
            [Parameter(Mandatory=$true)][AllowNull()]$VSTSSession
        )
        #Validate VSTSSession 
        If ($($VSTSSession.User) -eq '' -or ($VSTSSession.Token -eq '' -or ($VSTSSession.VSTSAccount -eq ''))) { 
            Write-Error 'You must either create an VSTS Session with script scope (by calling New-VSTSSession) or pass a VSTS session to this function.' 
        }
    }