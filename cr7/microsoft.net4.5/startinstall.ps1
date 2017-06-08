[CmdletBinding()]

param(

)



###################################################################################################



#

# PowerShell configurations

#



# NOTE: Because the $ErrorActionPreference is "Stop", this script will stop on first failure.

# This is necessary to ensure we capture errors inside the try-catch-finally block.

$ErrorActionPreference = "Stop"



# Ensure we set the working directory to that of the script.

pushd $PSScriptRoot



###################################################################################################



#

# Functions used in this script.

#



function Handle-LastError

{

$message = $error[0].Exception.Message

if ($message)

{

Write-Host -Object "ERROR: $message" -ForegroundColor Red

}



# IMPORTANT NOTE: Throwing a terminating error (using $ErrorActionPreference = "Stop") still

# returns exit code zero from the PowerShell script when using -File. The workaround is to

# NOT use -File when calling this script and leverage the try-catch-finally block and return

# a non-zero exit code from the catch block.

exit -1

}



###################################################################################################



#

# Handle all errors in this script.

#



trap

{

# NOTE: This trap will handle all errors. There should be no need to use a catch below in this

# script, unless you want to ignore a specific error.

Handle-LastError

}



###################################################################################################



#

# Main execution block.

#



try

{

$NewDIR = "C:\SoftwaresDump\microsoftdotnet"

$SoftwareWebLink = "http://download.microsoft.com/download/1/4/A/14A6C422-0D3C-4811-A31F-5EF91A83C368/NDP46-KB3045560-Web.exe"


$SoftwarePath = "C:\SoftwaresDump\microsoftdotnet\NDP46-KB3045560-Web.exe"



Write-Output 'Preparing temp directory ...'

New-Item "C:\SoftwaresDump\microsoftdotnet" -ItemType Directory -Force | Out-Null



Write-Output 'Downloading pre-requisite files ...'

(New-Object System.Net.WebClient).DownloadFile("$SoftwareWebLink", "$SoftwarePath")





Write-Output 'Installing ...'

Start-Process "C:\SoftwaresDump\microsoftdotnet\NDP46-KB3045560-Web.exe" -ArgumentList '/q' -Wait 







Write-Output 'Done!'

}

finally

{

popd

}