Function Get-VSTSBuilds {
    <#
.SYNOPSIS
    Retrieve a list of VSTS/TFS Builds by Project Name
.NOTES
    N/A
#>

    [cmdletBinding()]
    param (

         [pscustomobject]$VSTSSession=$Script:VSTSSession,

         [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
         [string]$Name=''

    )
    begin {
        Test-VSTSSession($VSTSSession)
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $VSTSSession.User,$VSTSSession.Token)))

        $uri = "https://" + "$($VSTSSession.VSTSAccount).VisualStudio.com/$($Name)/_apis/build/builds?api-version=5.0-preview.4"  
    }
    process {

        $wr= Invoke-RestMethod -Method GET -Uri $uri -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -ContentType "application/json"
        
        $wr | Select-Object -expandproperty value

    }
}
