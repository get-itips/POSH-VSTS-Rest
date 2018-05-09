Function New-VSTSSession{
    <#
    .SYNOPSIS
        Generate an VSTS session object to be used in querying VSTS
    .DESCRIPTION
        N/A
    #>
        [cmdletBinding()]
        
        param(
            [Parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
            [string[]]$User='',
    
     
            [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
            [string]$Token='',

            [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
            [string]$VSTSAccount=''
            
        )

            $newSession = [pscustomobject]@{
                User = $User
                Token = $Token
                VSTSAccount = $VSTSAccount
            } 
        $newSession
}