function Get-PatchTue {
	<#
	.SYNOPSIS
	Get the Patch Tuesday of a month
	.PARAMETER month
	The month to check
	.PARAMETER year
	The year to check
	.EXAMPLE
	Get-PatchTue -month 6 -year 2015
	.EXAMPLE
	Get-PatchTue June 2015
	#>
	param(
		[string]$month = (get-date).month,
		[string]$year = (get-date).year)
	$firstdayofmonth = [datetime] ([string]$month + "/1/" + [string]$year)
	(0..30 | ForEach-Object {
			$firstdayofmonth.adddays($_)
		} |
		Where-Object {
			$_.dayofweek -like "Tue*"
		})[1]
}


#Logfile Variables
$logDate = Get-Date -format "M-dd-yyyy" #Date/time stamp
$logpath = "C:\scripts\logs"
$Log = $logpath +  "\" + "Patch_Tuesday" + "_" + "(" + $logdate + ")" + ".txt"  #Creates the log file object

#####Starts logger info
New-Logger |
    Set-MinimumLevel -Value Debug | # You can change this value later to filter log messages
    # Here you can add as many sinks as you want - see https://github.com/PoShLog/PoShLog/wiki/Sinks for all available sinks
    Add-SinkConsole -RestrictedToMinimumLevel Information|   # Tell logger to write log messages to console
    Add-SinkFile -Path $log | # Tell logger to write log messages into file
    Start-Logger

$patchday = Get-PatchTue 

$patchday1 = $patchday.AddDays(1).Tostring('M-dd-yyyy')



Try { 
      
      write-infolog ""
      Write-infolog "***** Checking for Patch Tuesday ******" 
     if ($logDate -eq $patchday1) {
       Write-infolog "It's Wed after Patch Tuesday!"
       Write-infolog "Calling 0365 Download"
       
       & "C:\scripts\software\0365_Download.ps1" #Path to call on 0365 Download file
       }
       else{
      
      
    $Timespan = (New-TimeSpan -Start $logdate -End $patchday1).TotalDays
    Write-infolog "O365 Download will happen in $Timespan day(s)"
               }
    }
    Catch {
        Write-Errorlog "Error Finding File!" $_.Exception.message
        $_.Exception
        $errorbody = "$_.Exception"
        [string]$subject = "Check-Date Catch Error!"
        Send-Email $errorbody $subject
    }
 Close-Logger
