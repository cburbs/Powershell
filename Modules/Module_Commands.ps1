#####################################
# list modules you have installed
#####################################
Get-InstalledModule 
#Get-InstalledModule |  Export-Csv -Path c:\tools\output\Modules.csv -NoTypeInformation

#####################################
# Update Installed Modules
#####################################
# This PS Script will update all current installed modules.
Update-Module -Force


#####################################
# Uninstall listed module
#####################################

#This PS Script will UnInstall listed module
Get-InstalledModule -Name Modulename | Uninstall-Module
