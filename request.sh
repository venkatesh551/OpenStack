bucket=bucket1
resource="/${bucket}"
contentType="application/x-compressed-tar"
dateValue=`date -R`
stringToSign="PUT\n\n${contentType}\n${dateValue}\n${resource}"
s3Key=admin
s3Secret=asecret
signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64`

curl -v -X PUT \
  -H "Date: ${dateValue}" \
  -H "Content-Type: ${contentType}" \
  -H "Authorization: AWS ${s3Key}:${signature}" \
  http://127.0.0.1:7070/${bucket}
