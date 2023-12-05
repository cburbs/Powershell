I have just started playing with Poshlog for better logging - https://github.com/PoShLog/PoShLog.

Patch_Tuesday.ps1 script is run monthly on my Sched server in Task Scheduler. I have it run starting on day 6 through 17 as patch Tuesday for most months seems to fall in that range.
If it is the Wed after Patch Tuesday then the script calls on the O365_Download.ps1 script

########################################################
Patch_Tuesday.ps1 script variables you will need to set:
########################################################
- $logpath
- The line to call the 0365 script which is right after "Calling O365 Download"

########################################################
O365_Download.ps1 script variables you will need to set:
########################################################
#===================================================================================================
# OfficeMove
#===================================================================================================
$source = "$Yoursharename\Office365\Office"
$destold = "$Yoursharename\Office365\Old"
$dest = "$Yoursharename\Office365\Old"

#===================================================================================================
# OfficeDownload
#===================================================================================================
$DownloadsPath = "$Yoursharename\Office365"
$OfficeODT = '$Yoursharename\Office365\ODT\setup.exe'
$downloadsodt = '$Yoursharename\Office365\ODT'
$ODTOfficeProduct = 'O365ProPlusRetail'
$OfficeArch = '64'
$LanguageId ="en-us"
$Channel = "MonthlyEnterprise"

############################
# Email IT Term Complete   #
############################
$datasource = "$Yoursharename\Office365\Office\Data"
$from
$to
$Mailserver
