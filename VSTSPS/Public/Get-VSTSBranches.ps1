Function Get-VSTSBranches {
    <#
.SYNOPSIS
    Retrieve a list of Azure DevOps/TFS Branches by Repository Id and Project Name
.NOTES
    N/A
#>

    [cmdletBinding()]
    param (

         [pscustomobject]$VSTSSession=$Script:VSTSSession, 

         [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
         [string]$Name='',

         [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
         [string]$RepositoryId=''

    )
    begin {
        Test-VSTSSession($VSTSSession)
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $VSTSSession.User,$VSTSSession.Token)))

        $uri = "https://" + "$($VSTSSession.VSTSAccount).VisualStudio.com/$($Name)/_apis/git/repositories/$($RepositoryId)/refs?api-version=5.0-preview.1"  
    }
    process {

        $wr= Invoke-RestMethod -Method GET -Uri $uri -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -ContentType "application/json"
        
        $wr | Select-Object -expandproperty value

    }
}
