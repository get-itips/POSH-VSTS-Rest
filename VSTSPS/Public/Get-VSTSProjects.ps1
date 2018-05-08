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

        [switch]$Raw = $false,

        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
        [string]$VSTSAccount

    )
    begin {
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $User,$Token)))
        $headers = @{}
        $headers.Add("Authorization","Basic " + $EncodedText)  
        $uri = "https://" + "$($VSTSAccount).VisualStudio.com/DefaultCollection/_apis/projects?api-version=2.0"  
    }
    process {

        $wr= Invoke-WebRequest -Uri $uri -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)}  -Method Get -ContentType "application/json"
        if($Raw){
            $wr.Content
        }
        else{ConvertFrom-Json $wr.Content | Select-Object -expand value | Select-Object id, name, url, state, revision, visibility}
    }
}

#https:// .VisualStudio.com/DefaultCollection/_apis/projects?api-version=2.0"