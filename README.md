# Random
## Cloudflare-Worker-Tips.md  
[Lessons learned while exploring and implementing Workers](https://github.com/Xorlent/Random/blob/main/Cloudflare-Worker-Tips.md)  
## MissingMetadata.ps1  
[This script](https://github.com/Xorlent/Random/blob/main/MissingMetadata.md) will connect to a specified SharePoint Online site or subsite and generate a list of all items missing mandatory metadata  
## FindUnquotedPaths.ps1
[This script](https://github.com/Xorlent/Random/blob/main/FindUnquotedPaths.ps1) will connect to Active Directory, get a list of hosts based on the user configured search path, and check each online host for [unquoted service path vulnerabilities](https://attack.mitre.org/techniques/T1574/009/)  
## ThreatConnectAPI-Starter.ps1  
[This script is a PowerShell starter example to connect your project to ThreatConnect's API](https://github.com/Xorlent/Random/blob/main/ThreatConnectAPI-Starter.ps1)  
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
  - [Possible mitigation strategy?](https://learn.microsoft.com/en-us/powershell/module/processmitigations/set-processmitigation?view=windowsserver2022-ps)
## Windows 11 Debloat script
  - Appropriate for enterprise deployments; Great for removing all of the bundled games and useless apps, tracking and telemetry settings  
  - https://github.com/Raphire/Win11Debloat
