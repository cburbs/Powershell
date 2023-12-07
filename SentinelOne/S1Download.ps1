#This will download the latest Windows 64-bit S1 Client

$APIToken =''
$server = 'servername'

# Force TLS 1.2. Not always necessary but Windows Version below 1903 will default to TLS 1.1 or worse and fail.
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

Try {
    # Set headers with API Token
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", "ApiToken $ApiToken")
    $headers.Add("Content-Type", "application/json")

    # Get the details on the latest General Availability MSI installer available from your Sentinel One server instance.
    $response = Invoke-RestMethod "https://$Server.sentinelone.net/web/api/v2.1/update/agent/packages?platformTypes=windows&minorVersion=GA&fileExtension=.msi&sortOrder=desc&limit=2" -Method 'GET' -Headers $headers
    $payload = $response.data | Where {
        $_.osArch -eq "64 bit"
    }
    # Set the filename and location for the downloaded installer
    #$file = "\\shared\files\InstallSource\SentinelOne\SentinelInstaller_windows_64bit.msi"
    $file = "c:\tools\downloads\SentinelInstaller_windows_64bit.msi"
    # Download the latest 64-Bit MSI Installer.
    Invoke-WebRequest -Uri $payload.link -Outfile $file -Headers $headers -UseBasicParsing

    #
} Catch {
    $Err = $Error[0].Exception.Message
    Write-Host $Err -ForegroundColor Red
}
