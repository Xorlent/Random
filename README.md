# Random
## MissingMetadata.ps1
This script will connect to a specified SharePoint Online site or subsite and generate a list of all items missing mandatory metadata  
### Setup
First, you must install the PowerShell module, PnP.Powershell using the following command from an administrative PowerShell prompt:
```Install-Module PnP.PowerShell -RequiredVersion 1.12.0```  
### Use
- Open PowerShell ISE and load/run the MissingMetadata.ps1 file.  
- From the ISE command prompt, execute Get-MissingMetadata, supplying the site URL and the number of days of lookback:  
```Get-MissingMetadata -Site yourtenant.sharepoint.com/sites/sitename -Days 180```  
- The example above will iterate through all libraries found in _sitename_ for items created in the past 180 days.  An output _sitename_.csv file will be created with your results.
- The output file includes the following information about items missing mandatory metadata: "FileName","CreatedBy","MissingMetadata","FileLocation"
  - FileName is the title of the item
  - CreatedBy is the uploader or creator's name
  - MissingMetadata is the name of the column(s) missing mandatory metadata
  - FileLocation is the library where the item is stored
- When the script launches, you will be prompted to sign in to your SharePoint Online environment.  These credentials are used to access the specified site.  
