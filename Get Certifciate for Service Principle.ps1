# Gets the base 64 encoding of cert from a PFX file
# This is used for HDInsight when setting a service principle

$certificatePassword="<<REMOVED>>"
$certPath = "C:\Users\<<REMOVED>>\Desktop\<<REMOVED>>.pfx"

[Reflection.Assembly]::Load("System.Security, Version=2.0.0.0, Culture=Neutral, PublicKeyToken=b03f5f7f11d50a3a")
$mypwd = ConvertTo-SecureString -String $certificatePassword -Force –AsPlainText
$cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2($certPath,$mypwd);
$keyValue = [System.Convert]::ToBase64String($cert.GetRawCertData())

# This is the JSON needed for a HDInsight ARM template
# You can create a HDI cluster in the Azure Portal, then at the end of the processs, before creating the cluster, click Export
# This section can replace what you have exported.
$json = '"clusterIdentity": {
               "clusterIdentity.applicationId": "' + $app.ApplicationId + '",
               "clusterIdentity.certificate": "' + $keyValue + '",
               "clusterIdentity.aadTenantId": "https://login.windows.net/' + $Sub.Tenant + '",
               "clusterIdentity.resourceUri": "https://management.core.windows.net/",
               "clusterIdentity.certificatePassword": "' + $certificatePassword + '"
              }'


Write-Output $json


