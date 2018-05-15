Function Get-VSTSProjects {
    <#
.SYNOPSIS
    Retrieve a list of VSTS/TFS Projects
.NOTES
    N/A
#>

    [cmdletBinding()]
    param (

         [pscustomobject]$VSTSSession=$Script:VSTSSession

    )
    begin {
        Test-VSTSSession($VSTSSession)
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $VSTSSession.User,$VSTSSession.Token)))

        $uri = "https://" + "$($VSTSSession.VSTSAccount).VisualStudio.com/DefaultCollection/_apis/projects?api-version=2.0"  
    }
    process {

        $wr= Invoke-RestMethod -Method GET -Uri $uri -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -ContentType "application/json"
        
        $wr | Select-Object -expandproperty value

    }
}

#https:// .VisualStudio.com/DefaultCollection/_apis/projects?api-version=2.0"