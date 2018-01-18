#requires -version 4
<#
.SYNOPSIS
  Remove Windows 10 Default Apps
.DESCRIPTION
  Script that deletes Windows 10 Default Apps, designed to be run as part of the imaging process.
.INPUTS
  None
.OUTPUTS
  None
.NOTES
  Version:        2.1
  Author:         Gil Tolley
  Creation Date:  1/18/2018
  Purpose/Change: Changed some package names and added the registry path to shut off consumer
                  cloud content.
.EXAMPLE
  Default Usage
  
  .\Remove-WindowsApps.ps1
#>

#---------------------------------------------------------[Script Parameters]------------------------------------------------------

Param (
    #Script parameters go here
)


#-----------------------------------------------------------[Execution]------------------------------------------------------------

#Script Execution goes here
Get-AppxProvisionedPackage -Online | Where-Object DisplayName -In Microsoft.3DBuilder | Remove-ProvisionedAppxPackage -Online
Get-AppxProvisionedPackage -Online | Where-Object DisplayName -In Microsoft.Microsoft3DViewer | Remove-ProvisionedAppxPackage -Online
Get-AppxProvisionedPackage -Online | Where-Object DisplayName -In Microsoft.BingWeather | Remove-ProvisionedAppxPackage -Online
Get-AppxProvisionedPackage -Online | Where-Object DisplayName -In Microsoft.Getstarted | Remove-ProvisionedAppxPackage -Online
Get-AppxProvisionedPackage -Online | Where-Object DisplayName -In Microsoft.Messaging | Remove-ProvisionedAppxPackage -Online
Get-AppxProvisionedPackage -Online | Where-Object DisplayName -In Microsoft.MicrosoftOfficeHub | Remove-ProvisionedAppxPackage -Online
Get-AppxProvisionedPackage -Online | Where-Object DisplayName -In Microsoft.MicrosoftSolitaireCollection | Remove-ProvisionedAppxPackage -Online
Get-AppxProvisionedPackage -Online | Where-Object DisplayName -In Microsoft.Office.OneNote | Remove-ProvisionedAppxPackage -Online
Get-AppxProvisionedPackage -Online | Where-Object DisplayName -In Microsoft.OneConnect | Remove-ProvisionedAppxPackage -Online
Get-AppxProvisionedPackage -Online | Where-Object DisplayName -In Microsoft.People | Remove-ProvisionedAppxPackage -Online
Get-AppxProvisionedPackage -Online | Where-Object DisplayName -In Microsoft.SkypeApp | Remove-ProvisionedAppxPackage -Online
Get-AppxProvisionedPackage -Online | Where-Object DisplayName -In Microsoft.WindowsCamera | Remove-ProvisionedAppxPackage -Online
Get-AppxProvisionedPackage -Online | Where-Object DisplayName -In microsoft.windowscommunicationsapps | Remove-ProvisionedAppxPackage -Online
Get-AppxProvisionedPackage -Online | Where-Object DisplayName -In Microsoft.WindowsFeedbackHub | Remove-ProvisionedAppxPackage -Online
Get-AppxProvisionedPackage -Online | Where-Object DisplayName -In Microsoft.XboxApp | Remove-ProvisionedAppxPackage -Online
Get-AppxProvisionedPackage -Online | Where-Object DisplayName -In Microsoft.XboxGameCallableUI | Remove-ProvisionedAppxPackage -Online
Get-AppxProvisionedPackage -Online | Where-Object DisplayName -In Microsoft.XboxIdentityProvider | Remove-ProvisionedAppxPackage -Online
Get-AppxProvisionedPackage -Online | Where-Object DisplayName -In Microsoft.ZuneMusic | Remove-ProvisionedAppxPackage -Online
Get-AppxProvisionedPackage -Online | Where-Object DisplayName -In Microsoft.ZuneVideo | Remove-ProvisionedAppxPackage -Online

Get-AppxPackage *3DBuilder* | Remove-AppxPackage
Get-AppxPackage *Microsoft3DViewer* | Remove-AppxPackage
Get-AppxPackage *BingWeather* | Remove-AppxPackage
Get-AppxPackage *Getstarted* | Remove-AppxPackage
Get-AppxPackage *Messaging* | Remove-AppxPackage
Get-AppxPackage *MicrosoftOfficeHub* | Remove-AppxPackage
Get-AppxPackage *MicrosoftSolitaireCollection* | Remove-AppxPackage
Get-AppxPackage *Office.OneNote* | Remove-AppxPackage
Get-AppxPackage *OneConnect* | Remove-AppxPackage
Get-AppxPackage *People* | Remove-AppxPackage
Get-AppxPackage *SkypeApp* | Remove-AppxPackage
Get-AppxPackage *WindowsCamera* | Remove-AppxPackage
Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage
Get-AppxPackage *WindowsFeedbackHub* | Remove-AppxPackage
Get-AppxPackage *XboxApp* | Remove-AppxPackage
Get-AppxPackage *XboxIdentityProvider* | Remove-AppxPackage
Get-AppxPackage *ZuneMusic* | Remove-AppxPackage
Get-AppxPackage *ZuneVideo* | Remove-AppxPackage

# This registry key stops the Windows Consumer Experience, like Suggested Apps, Lock Screen Ads, 
#    and Bogus notifications about your Microsoft Account.
$RegistryPath = 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent'
$Name = "DisableWindowsConsumerFeatures"
$Value = 1

if(!(Test-Path $RegistryPath))
{
  New-Item -Path $RegistryPath -Force | Out-Null
  New-ItemProperty -Path $RegistryPath -Name $Name -Value $Value -PropertyType DWORD -Force | Out-Null
} else {
  New-ItemProperty -Path $RegistryPath -Name $Name -Value $Value -PropertyType DWORD -Force | Out-Null
}