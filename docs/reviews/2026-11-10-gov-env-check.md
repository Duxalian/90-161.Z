# Gov-device environment check, 2026-11-10

Source: output of scripts/gov/Test-Environment.ps1, run by the PFM on the gov device. Sanitized: no host, user or unit data.

| Check | Result | Effect |
|---|---|---|
| PowerShell | 5.1 Desktop, 64-bit | Windows PowerShell; PnP 1.x supports it |
| LanguageMode | FullLanguage | COM and .NET allowed |
| Execution policy | MachinePolicy=Unrestricted, LocalMachine=Bypass | .ps1 files run; paste-only not required |
| Word COM | OK, version 16.0; edit OK; Times New Roman set | Renderer option A works |
| Times New Roman font | present | F-001 can be met |
| PnP.PowerShell | 1.12.0 installed | Can script SharePoint; 1.x has -UseWebLogin (no app registration); not yet tested |
| SPO Management Shell | not installed | Not needed |
| PSGallery | not reachable | No new modules; use only what is installed |

Conclusion (Agent): renderer = PowerShell + Word COM (option A) is viable. Provisioning by PnP 1.12 is likely viable; confirm with scripts/gov/Test-PnPConnection.ps1.
