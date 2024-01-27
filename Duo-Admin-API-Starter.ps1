################### See https://duo.com/docs/adminapi for general API information ##################

# Adjust these three values according to your specific environment:
$integrationKey = 'YOUR INTEGRATION KEY HERE'
$secretKey = 'YOUR SECRET KEY HERE'
$APIBaseURL = 'api-123abc12.duosecurity.com'

# Adjust according to your desired query:
$APIURL = [uri]::EscapeUriString('/admin/v1/users')
$APIRequest = [uri]::EscapeUriString('username=someuser')

# GET to retrive data, POST to publish data, DELETE to delete records:
$URLMethod = 'GET'

# Generate authentication payload
$DTS = (Get-Date).ToUniversalTime().ToString("ddd, dd MMM yyyy HH:mm:ss -0000")
$EncPayload = $DTS + "`n" + $URLMethod + "`n" + $APIBaseURL + "`n" + $APIURL + "`n" + $APIRequest
$APIURL = 'https://' + $APIBaseURL + $APIURL + '?' + $APIRequest

$hmacsha = New-Object System.Security.Cryptography.HMACSHA1
$hmacsha.key = [Text.Encoding]::ASCII.GetBytes($secretKey)
$signature = $hmacsha.ComputeHash([Text.Encoding]::ASCII.GetBytes($EncPayload))
$signature = [BitConverter]::ToString($signature).Replace('-','')

$authorization = $integrationKey + ":" + $signature
$EncodedAuth = [Text.Encoding]::ASCII.GetBytes($authorization)
$authorizationInfo = "Basic " + [Convert]::ToBase64String($EncodedAuth)
 
# Force TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Build request header
$headerData = @{
    'X-Duo-Date' = $DTS
    'Authorization' = $authorizationInfo
    'Host' = $APIBaseURL
    #'Content-Type' = 'x-www-form-urlencoded' # Uncomment this for POST requests
    }

# Perform request
$response = Invoke-RestMethod -Uri $APIURL -Headers $headerData -Method $URLMethod
$response