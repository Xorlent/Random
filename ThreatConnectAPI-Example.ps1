$APIBaseURL = 'https://api.threatconnect.com'

# Change these values to match your ThreatConnect API authentication details
$accessID = 'youraccessIDhere'
$secretKey = 'yoursecretkey'

# Change the $APIURL value below as required for your use case
$APIURL = '/v2/owners'

# Generate Unix +%s date format required for API authentication
$DTS = (Get-Date).ToUniversalTime() | Get-Date -UFormat %s
$timestamp = $DTS.Split(".")

# Compose the encrypted payload string
$EncPayload = $APIURL + ':GET:' + $timestamp[0]

# Compose the request URL
$APIURL = $APIBaseURL + $APIURL

# Generate the signed authorization string
$hmacsha = New-Object System.Security.Cryptography.HMACSHA256
$hmacsha.key = [Text.Encoding]::ASCII.GetBytes($secretKey)
$signature = $hmacsha.ComputeHash([Text.Encoding]::ASCII.GetBytes($EncPayload))
$signature = [Convert]::ToBase64String($signature)
$authorization = 'TC ' + $accessID + ':' + $signature

# Force TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Assemble the request header
$headerData = @{
   'Timestamp' = $timestamp[0]
   'Authorization' = $authorization
   'Accept' = 'application/json'
   }

# Perform the request
$response = Invoke-WebRequest -Uri $APIURL -Header $headerData # -Method GET

# Display the results
Write-Output $response