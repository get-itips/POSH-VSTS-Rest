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
            [string]$VSTSAccount='',
            
            [switch]$Default,
            [Alias('PassThrough')]
            [switch]$PassThru
        )

            $newSession = [pscustomobject]@{
                User = $User
                Token = $Token
                VSTSAccount = $VSTSAccount
            } 

            If ($Default -or !($Script:VSTSSession)){
                $Script:VSTSSession = $newSession
            }

            If ($PassThru){
                $newSession
            }
        
}