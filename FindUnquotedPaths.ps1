<#  This script requires Remote Server Administration Tools (RSAT)

Prerequisites:
1. If you receive Get-ADComputer errors, from an administrative PowerShell window, run the following:
    Add-WindowsCapability -Name RSAT.ActiveDirectory.DS-LDS.Tools* -Online
2. WinRM must be enabled and accessible from the host you run this tool on.

#>

# Adjust $OU to match the search scope for the computers you want to check for unquoted service paths
$OU = 'OU=Servers,DC=ad,DC=domain,DC=com'
$Computers = Get-ADComputer -Filter "Enabled -eq 'True'" -SearchBase $OU | Select-Object Name
$Findings = ""
 
foreach($Computer in $Computers){
   try{
       $Services = Invoke-Command -ScriptBlock {Get-Service} -ComputerName $Computer.Name -ErrorAction SilentlyContinue
   }
   catch{
       break
   }
   finally{
       Write-Output $Computer.Name
       foreach($Service in $Services){
           $RegPath = 'HKLM:System\CurrentControlSet\Services\' + $Service.ServiceName
           $Command = "Get-ItemPropertyValue -Path $RegPath -Name ImagePath"
           $FullValue = Invoke-Command -ComputerName $Computer.Name -ScriptBlock { $Command }
           if($FullValue.Length > 0){
               if((-not $FullValue.Contains("svchost.exe")) -and (-not $FullValue.Contains("dllhost.exe")) -and (-not $FullValue.Contains("msiexec.exe")) -and (-not $FullValue.Contains("SearchIndexer.exe")) -and (-not $FullValue.StartsWith('"')) -and ($FullValue.Contains(" "))){
                   $Findings = $Findings + 'FINDING: Hostname ' + $Computer.Name + ' : ' + $Service.ServiceName + ' : ' + $FullValue + '`r`n'
               }
           }
       }
   }
}
Write-Output $Findings
