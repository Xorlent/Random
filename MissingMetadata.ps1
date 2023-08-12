Function Get-MissingMetadata
{
    Param
    (
         [Parameter(Mandatory=$true, Position=0)]
         [string] $Site,
         [Parameter(Mandatory=$true, Position=1)]
         [int] $Days
    )
    Import-Module PnP.PowerShell
    $subSite = $Site -replace '.*/'
    $outputFile = ".\" + $subSite + ".csv"
    $results = @()

    # Default to 90 day lookback if the user did not specify a valid value
    if($Days -Lt 1)
        {
        Write-Output "Invalid entry for number of days.  Defaulting to 90-day lookback."
        $Days = 90
        }

    # Convert number of days to negative integer
    if($Days -Gt -1)
        {
        $Days = $Days * -1
        }

    Connect-PnPOnline $Site -UseWebLogin
    $allLibs = Get-PnPList | Where-Object { $_.BaseTemplate -eq 101 } #Return SharePoint Libraries only

    foreach($lib in $allLibs){
        $ListItems = Get-PnPListItem -List $lib -PageSize 500 #Get resultset without query to avoid index issues on large libraries
        $logstring = "Got " + $lib.Title + "..."
        Write-Output $logstring

        $TimeStamp = (Get-Date).AddDays($Days) # Adjust value to reflect number of days of content to search
        $allDocs  = $ListItems | Where {$_["Created"] -Gt $TimeStamp} # Filter results by only processing items created in the past n days
        Write-Output "Filtered list for newer items only.  Records to process: "$allDocs.count

        foreach($doc in $allDocs){
            $allRequiredFields = Get-PnPField -List $lib | Where-Object {$_.Required -eq $true} # Return only items that do not have mandatory field(s) populated

            foreach($field in $allRequiredFields){
                if ($null -eq $doc.FieldValues["$($field.InternalName)"]) {

                    $results += [pscustomobject]@{
                        FileName = $doc.FieldValues.FileLeafRef
                        CreatedBy = $doc.FieldValues.Author.LookupValue
                        MissingMetadata = $field.Title
                        FileLocation = $lib.Title
                    }
                }
            }
        }
    }

    $results | Select-Object FileName,CreatedBy,MissingMetadata,FileLocation | Export-Csv -Path $outputFile -NoTypeInformation
}
