     ################### See https://threatconnect.readme.io/reference/getting-started-1 for general API information ##################
################### See https://knowledge.threatconnect.com/docs/constructing-query-expressions for query language details ##################

# Adjust according to your unique, private API credentials:
$accessID = 'yourAccessID'
$secretKey = 'yourSecretKey'

# Adjust according to your ThreatConnect environment:
$APIBaseURL = 'https://api.threatconnect.com'

# Build record option prompt
$RecordPrompt = @(
'Enter the number corresponding to the type of data to retrieve:
1. IPs (malicious IP addresses)
2. Hosts (malicious hostnames)
3. URLs (malicious web URLs)
4. Email (malicious email addresses)
5. File (malicious file hashes)
'
) -join ' '

# Record type selector for TQL query
$SelectedType = @('"ASN"','"Address"','"Host"','"URL"','"EmailAddress"','"File"')

# CSV header spec for returned results, based on selected record type
$TypeHeaders = @(
@("dateAdded", "lastModified", "ownerName", "ASN", "confidence"),
@("dateAdded", "lastModified", "ownerName", "ip", "confidence"),
@("dateAdded", "lastModified", "ownerName", "hostName", "confidence"),
@("dateAdded", "lastModified", "ownerName", "text", "confidence"),
@("dateAdded", "lastModified", "ownerName", "address", "confidence"),
@("dateAdded", "lastModified", "ownerName", "sha256", "confidence")
)

# Prompt for record type to query
$RecordType = 0
while (($RecordType -lt 1) -or ($RecordType -gt 5)){
    $RecordType = Read-Host $RecordPrompt
}

# Prompt for query confidence level
$defaultConfidence = 39
if (($SelectedConfidence = Read-Host "Enter the desired confidence level from 0 to 100.  Press enter to accept the default of $defaultConfidence") -eq '') {$SelectedConfidence = $defaultConfidence}

#Prompt for the query createdDate
$defaultDate = (Get-Date).AddDays(-7).ToString("yyyy-MM-dd")
if (($SelectedDate = Read-Host "Enter the earliest record date desired.  Generally, more than a few weeks will exceed the non-paging API limit.  Press enter to accept the default of $defaultDate") -eq '') {$SelectedDate = $defaultDate}

# Assemble the request URI.  Adjust according to your desired TQL query:
$URIString = '/api/v3/indicators?tql=(confidence > ' + $SelectedConfidence + ') and (indicatorActive=true) and (dateAdded > "' + $SelectedDate + '") and (typeName in (' + $SelectedType[$RecordType] + '))&resultLimit=10000'

# Escape invalid characters to build the request string
$APIURL = [uri]::EscapeUriString($URIString)

# GET to retrive data, POST to publish data, OPTIONS to get details about a specific API call:
$URLMethod = 'GET'

# Prep request data per the API spec
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

# Assemble request header
$headerData = @{
    'Timestamp' = $timestamp[0]
    'Authorization' = $authorization
    'Accept' = 'application/json'
    }

# Execute GET request.  Since we know the response format, create a friendly CSV output file
if($URLMethod -eq 'GET') {
    $LaunchDTS = (Get-Date).ToString("MMddyy-HHmmss")
    $outputFilePath = "./ThreatIntel-$LaunchDTS.csv"
    Invoke-RestMethod -Uri $APIURL -Header $headerData -Method $URLMethod | Select-Object -ExpandProperty data | Select-Object $TypeHeaders[$RecordType] | Export-Csv $outputFilePath -NoTypeInformation
}
# Otherwise, execute the specified request and dump response output to console
else {
    $response = Invoke-WebRequest -Uri $APIURL -Header $headerData -Method $URLMethod
    Write-Output $response
}
