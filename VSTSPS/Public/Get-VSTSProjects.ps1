Function Get-VSTSProjects {
    <#
.SYNOPSIS
    Retrieve a list of VSTS/TFS Projects
.NOTES
    N/A
#>

    [cmdletBinding()]
    param (

        [Parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
        [string[]]$User='',

 
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
        [string]$Token='',

        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [string]$Account

    )

    process {
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $User,$Token)))
        $headers = @{}
        $headers.Add("Authorization","Basic " + $EncodedText)

        $uri = "https://" + "$($Account).VisualStudio.com/DefaultCollection/_apis/projects?api-version=2.0"

        $wr= Invoke-WebRequest -Uri $uri -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)}  -Method Get -ContentType "application/json"
        $wr
    }
}

#https:// .VisualStudio.com/DefaultCollection/_apis/projects?api-version=2.0"