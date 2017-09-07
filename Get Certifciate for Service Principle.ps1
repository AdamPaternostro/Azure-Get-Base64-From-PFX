# Gets the base 64 encoding of cert from a PFX file
# This is used for HDInsight when setting a service principle

# Gets the base 64 encoding of cert from a PFX file
# This is used for HDInsight when setting a service principle

$certPath = "C:\<<REMOVED>>\<<CERTNAME>>.pfx"
[System.Convert]::ToBase64String((Get-Content $certPath -Encoding Byte))
