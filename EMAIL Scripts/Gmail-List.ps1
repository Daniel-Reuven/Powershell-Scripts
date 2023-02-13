<#
    # Define the parameters below prior to running:
    $EncodedPw - Base64 encoded password
    $EmailFrom - Sender Email address
    $Subject - Subject of the Email
    $Body - Email's Body
    EmailToList - List of Email addresses
    # Requires to allow "less secure app access" in google account settings.
 #>

$EncodedPw = “<BASE64_ENCODED_PASSWORD>”
$DecodedPw = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($EncodedPw))
$DecodedPw
$EmailFrom = "<USERNAME_A>@gmail.com"
$EmailToList = "<USERNAME_B>@gmail.com"
$Subject = "<SUBJECT_TEXT>"
$Body = "<BODY_TEXT>"
$SMTPServer = "smtp.gmail.com"
$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587)
$SMTPClient.EnableSsl = $true
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential($EmailFrom, $DecodedPw);

foreach ($emailaddress in $EmailToList)
{
    Try
    {
        $SMTPClient.Send($EmailFrom, $emailaddress, $Subject, $Body)
    }
    catch
    {
        Write-Host "Something went wrong:"
        Write-Host $_.Exception.Message
    }
}
$SMTPClient.Dispose()