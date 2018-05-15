Function Get-VSTSProjectProperties {
    <#
.SYNOPSIS
    Retrieve the list of VSTS/TFS Project Properties based on Project Id
.NOTES
    Strange enough, using Invoke-WebRequest, retrieves more properties than using Invoke-RestMethod
#>

    [cmdletBinding()]
    param (
        

        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
        [string]$Id='',
        
        [pscustomobject]$VSTSSession=$Script:VSTSSession
    )
    begin {
        Test-VSTSSession($VSTSSession)
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $VSTSSession.User,$VSTSSession.Token)))
        $uri = "https://" + "$($VSTSSession.VSTSAccount).VisualStudio.com/_apis/projects/"+"$($Id)/properties?api-version=5.0-preview.1"  
    }
    process {

        $wr= Invoke-RestMethod -Method GET -Uri $uri -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -ContentType "application/json"

        $wr  | Select-Object -expandproperty value
    }
}
