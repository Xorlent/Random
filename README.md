# Random
## Cloudflare-Access+EntraID.md
[Lessons learned using Cloudflare Access SSO with Entra ID](https://github.com/Xorlent/Random/blob/main/Cloudflare-Access%2BEntraID.md)
## Cloudflare-Worker-Tips.md  
[Lessons learned while exploring and implementing Workers](https://github.com/Xorlent/Random/blob/main/Cloudflare-Worker-Tips.md)  
## CoPilotGPO.png
Screenshot showing the location in the user group policy tree where Microsoft's CoPilot can be disabled.  
For standalone hosts: ```reg add HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot /v TurnOffWindowsCopilot /t REG_DWORD /d 1 /f```
## Duo-Admin-API-Starter.ps1
[This script](https://github.com/Xorlent/Random/blob/main/Duo-Admin-API-Starter.ps1) is a PowerShell starter example to connect your project to Duo's Admin API  
I notice loads of people online struggling to get API authentication working.  This minimal example successfully implements Admin API authentication in PowerShell with no dependencies.  
## FindUnquotedPaths.ps1
[This script](https://github.com/Xorlent/Random/blob/main/FindUnquotedPaths.ps1) will connect to Active Directory, get a list of hosts based on the user configured search path, and check each host for [unquoted service path vulnerabilities](https://attack.mitre.org/techniques/T1574/009/). Results are printed to the PowerShell console  
## MissingMetadata.ps1  
[This script](https://github.com/Xorlent/Random/blob/main/MissingMetadata.md) will connect to a specified SharePoint Online site or subsite and generate a list of all items missing mandatory metadata  
## ThreatConnectAPI-Starter.ps1  
[This script](https://github.com/Xorlent/Random/blob/main/ThreatConnectAPI-Starter.ps1) is a PowerShell starter example to connect your project to ThreatConnect's API  
## ThreatConnect-QuickQuery.ps1  
[A very simple query console to fetch Indicators.](https://github.com/Xorlent/Random/blob/main/ThreatConnect-QuickQuery.ps1)  Helpful for exploring data within ThreatConnect.  
The following record types are supported:  
  1. IPs (malicious IP addresses)
  2. Hosts (malicious hostnames)
  3. URLs (malicious web URLs)
  4. Email (malicious email addresses)
  5. File (malicious file hashes)
## Configuring modern/certificate-based app authentication for Office 365  
  - [Follow this guide published by Microsoft](https://learn.microsoft.com/en-us/sharepoint/dev/solution-guidance/security-apponly-azuread)  
## Hijacklibs catalog of hijack-able DLLs  
  - https://hijacklibs.net
  - [Scanning tools](https://github.com/wietze/HijackLibs/wiki/)
  - [Possible mitigation strategy?](https://github.com/Xorlent/Fix-Exploitable-DLLs)
## Windows 11 Debloat script
  _Appropriate for enterprise deployments; Great for removing all of the bundled games and useless apps, tracking and telemetry settings_
  - https://github.com/Raphire/Win11Debloat
## Editing or clearing special Active Directory object attributes
  _If you ever encounter the following message when trying to edit an attribute in AD Users and Computers or ADSIEdit: "There is no editor registered to handle this attribute type."_
  - Use Set-ADComputer PowerShell, included with [RSAT](https://learn.microsoft.com/en-US/troubleshoot/windows-server/system-management-components/remote-server-administration-tools)
  - To clear a value (example clears the msDS-AllowedToActOnBehalfOfOtherIdentity attribute):
    - ```Set-ADComputer COMPUTERNAME -Clear msDS-AllowedToActOnBehalfOfOtherIdentity```
  - To set or add to a value, use -Add or -Replace instead of -Clear.  [More info](https://learn.microsoft.com/en-us/powershell/module/activedirectory/set-adcomputer?view=windowsserver2022-ps)  
## PowerShell Helpful Links
  - [Automatic Variables](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_automatic_variables?view=powershell-7.3)

