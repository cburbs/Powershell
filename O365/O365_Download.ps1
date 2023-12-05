Try
{
#===================================================================================================
# OfficeMove
#===================================================================================================
$source = "$Yoursharename\Office365\Office"
$destold = "$Yoursharename\Office365\Old"
$dest = "$Yoursharename\Office365\Old"
write-infolog ""
write-infolog "***** Deleting files from OLD folder *****" 
remove-Item -path $destold -force -exclude old -recurse -confirm:$false
Start-Sleep -Seconds 20
write-infolog ""
write-infolog "***** Moving Office files to OLD folder *****" -Verbose
Get-ChildItem -Path $SOURCE | Move-Item -Destination $DEST
Get-ChildItem -Path $SOURCE -Recurse -Directory | Remove-Item -confirm $false 
Start-Sleep -Seconds 20

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

$ODTXml = @"
<Configuration>
<Add SourcePath="$DownloadsPath" OfficeClientEdition="$OfficeArch" Channel="$Channel">
    <Product ID="$ODTOfficeProduct">
        <Language ID="$LanguageId" />
    </Product>
    </Add>
</Configuration>
"@

    if (!(Test-Path $downloadsodt)) {New-Item $downloadsodt -ItemType Directory -Force | Out-Null}
    $ODTXml | Out-File "$downloadsodt\OSDUpdate.xml" -Encoding utf8 -Force
    
    if (!($XmlOnly)) {
        write-infolog ""
        write-infolog "***** Downloading ... This may take a while *****" -Verbose
        
        Start-Process -FilePath "$OfficeODT" -ArgumentList "/download","`"$downloadsodt\OSDUpdate.xml`"" -Wait -NoNewWindow
       
    }
    write-infolog "***** Download Completed! *****" -Verbose
    }
Catch {
        Write-ErrorLog "***** Error Downloading Office File! *****" $_.Exception.message
        $errorbody = "$_.Exception.message"
        [string]$subject = "Officedownload Catch Error!"
        Send-Email $errorbody $subject
       } #catch end
############################
# Email IT Term Complete   #
############################
$datasource = "$Yoursharename\Office365\Office\Data"
$version = (Get-ChildItem -Path $dataSOURCE -Recurse -Directory).name
	tRY {
	    Write-infolog ""
		  Write-infolog "***** Email IT Download Complete ******" 
      $subject = "Latest Office Download has completed!"
		[string]$body = "The latest Monthly Enterprise version ($version) of Office has downloaded. "
		send-mailmessage -from $emailaddress -To $emailaddress  -SmtpServer $mailserver -Body $body -Subject $subject }
	Catch {
		  Write-ErrorLog "(Error!) sending email Function Email-Error!!" $_.Exception.message
		  $errorbody = "$_.Exception.message"
      [string]$subject = "Email Catch Error!"
      Send-Email $errorbody $subject		  
		  }

Close-logger
