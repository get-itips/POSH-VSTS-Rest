Function Get-VSTSProjectProperties {
    <#
.SYNOPSIS
    Retrieve the list of VSTS/TFS Project Properties based on Project Id
.NOTES
    N/A
#>

    [cmdletBinding()]
    param (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
        [pscustomobject]$VSTSSession,

        [switch]$Raw = $false,

        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [string]$Id=''
    )
    begin {
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $VSTSSession.User,$VSTSSession.Token)))
        $headers = @{}
        $headers.Add("Authorization","Basic " + $EncodedText)  
        $uri = "https://" + "$($VSTSSession.VSTSAccount).VisualStudio.com/_apis/projects/"+"$($Id)/properties?api-version=5.0-preview.1"  
    }
    process {

        $wr= Invoke-RestMethod -Method GET -Uri $uri -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -ContentType "application/json"

        $wr  | select -expandproperty value
    }
}
