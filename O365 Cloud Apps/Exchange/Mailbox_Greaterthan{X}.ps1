#PS Script Finds USERS mailboxes 90gb or larger and sends them an email alert.
#Requires the following modules:
#PS2HTMLTable (HTML Output)
#ExchangeOnlineManagement (To connect to exchangeonline)

#Sets log file name to name of script
$scriptName =  $MyInvocation.MyCommand.Name
$script = $scriptname -replace(".ps1","")

Start-Transcript -path "C:\Scripts\Logs\$script.txt"

#Connect to Exchange
$username = 'user@company.com'
$password = Get-Content "C:\Scripts\password1.txt" | ConvertTo-SecureString
$credential = New-Object System.Management.Automation.PsCredential($username, $password)
$Session = Connect-ExchangeOnline -Credential $Credential 


CLS
Write-Host "Finding Mailboxes Larger than 90GB..."

$users = Get-EXOMailbox -ResultSize Unlimited | Get-EXOMailboxStatistics | Where-Object {[int64]($PSItem.TotalItemSize.Value -replace '.+\(|bytes\)') -gt "90GB"} | Sort-Object TotalItemSize -Descending | Select-Object DisplayName, ItemCount, TotalItemSize


$Reports = [System.Collections.Generic.List[Object]]::new() # Create output file
Write-Host "Processing" $Users.Count "accounts..." 
ForEach ($User in $Users) {
       
   $ReportLine = [PSCustomObject] @{
           Name        = $User.Displayname
           Size = $User.TotalItemSize
                     }
                 
    $Reports.Add($ReportLine) 
} # End For


if ($reports -ne $null){
$HTML = New-HTMLHead
$HTML += $reports | New-HTMLTable 
$HTML = $HTML | Close-HTML
#who will get is email
$emailuser="user@company.com"

# source email address 
$SendingEmail="user@company.com"

# server settings for internal use
$SMTPServer="user@company.com"

# Subject of mail
$EmailSubject = "Mailboxes Larger than 90GB"

#Message body
[string]$body=$Reports  | ConvertTo-Html 
#Sending mail
Send-MailMessage -to $emailuser -from $SendingEmail -SmtpServer $SMTPServer -subject $EmailSubject  -body $html -BodyAsHtml}

#Disconnect Excahnge connection
Disconnect-ExchangeOnline -Confirm:$false 
Stop-Transcript
