    ################### See https://threatconnect.readme.io/reference/getting-started-1 for general API information ##################
################### See https://knowledge.threatconnect.com/docs/constructing-query-expressions for query language details ##################
 
$accessID = 'yourAccessID'
$secretKey = 'yourSecretKey'
 
# Adjust according to your specific environment:
$APIBaseURL = 'https://api.threatconnect.com'
 
# Adjust according to your desired TQL query.  Example below finds active indicators of type file OR host, modified since July 1, 2023, and with confidence > 39 of 100:
$APIURL = [uri]::EscapeUriString('/api/v3/indicators?tql=(confidence > 39) and (indicatorActive=true) and (lastModified > "2023-07-01") and (typeName in ("File","Host"))&resultLimit=100')
 
# GET to retrive data, POST to publish data, OPTIONS to get details about a specific API call:
$URLMethod = 'GET'
 
 
$DTS = (Get-Date).ToUniversalTime() | Get-Date -UFormat %s
$timestamp = $DTS.Split(".")
 
$EncPayload = $APIURL + ':' + $URLMethod + ':' + $timestamp[0]
 
$APIURL = $APIBaseURL + $APIURL
 
$hmacsha = New-Object System.Security.Cryptography.HMACSHA256
$hmacsha.key = [Text.Encoding]::ASCII.GetBytes($secretKey)
$signature = $hmacsha.ComputeHash([Text.Encoding]::ASCII.GetBytes($EncPayload))
$signature = [Convert]::ToBase64String($signature)
$authorization = 'TC ' + $accessID + ':' + $signature
 
# Force TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
 
$headerData = @{
   'Timestamp' = $timestamp[0]
   'Authorization' = $authorization
   'Accept' = 'application/json'
   }
 
if($URLMethod -ne 'POST') {
   $response = Invoke-RestMethod -Uri $APIURL -Header $headerData -Method $URLMethod
   Write-Output $response.data
}
else {
   $response = Invoke-WebRequest -Uri $APIURL -Header $headerData -Method $URLMethod
   Write-Output $response
}
