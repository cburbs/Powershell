<p align="left">
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



###########################################
Log file Example after it ran on 11/15/2023
###########################################
2023-11-15 05:33:51.330 -08:00 [INF] 
2023-11-15 05:33:51.393 -08:00 [INF] ***** Checking for Patch Tuesday ******
2023-11-15 05:33:51.408 -08:00 [INF] It's Wed after Patch Tuesday!
2023-11-15 05:33:51.408 -08:00 [INF] Calling 0365 Download
2023-11-15 05:33:51.424 -08:00 [INF] ***** Deleting files from OLD folder *****
2023-11-15 05:34:11.721 -08:00 [INF] *****Moving Office files to OLD folder*****
2023-11-15 05:34:31.893 -08:00 [INF] *****Downloading ... This may take a while *****
2023-11-15 05:42:08.840 -08:00 [INF] ***** Download Completed! *****
2023-11-15 05:42:08.996 -08:00 [INF] 
2023-11-15 05:42:09.028 -08:00 [INF] ***** Email IT Download Complete ******

</p>
