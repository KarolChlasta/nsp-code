# script that generate AWS session credensials
#  
$x=aws sts get-session-token
$y=$x | ConvertFrom-Json


write-output  $y.Credentials.AccessKeyId 
write-output  $y.Credentials.SecretAccessKey 

$y.Credentials.SessionToken 
$z=" "+$y.Credentials.AccessKeyId 
$z+=" "+$y.Credentials.SecretAccessKey 
$z+=" "+$y.Credentials.SessionToken
write-output XXXXX"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXx"
write-output keys
write-output XXXXX"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXx"
write-output $z
