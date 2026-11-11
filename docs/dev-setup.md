# Dev setup (agent workspace, Linux)

Checks run PowerShell 7 on Linux. They check syntax and PS 5.1 compatibility only. Word COM and PnP cannot run here; those parts are verified on the gov device.

1. pwsh 7.4.6: download `https://github.com/PowerShell/PowerShell/releases/download/v7.4.6/powershell-7.4.6-linux-x64.tar.gz`, extract to /opt/pwsh, link /usr/local/bin/pwsh.
2. PSScriptAnalyzer 1.23.0: download `https://github.com/PowerShell/PSScriptAnalyzer/releases/download/1.23.0/PSScriptAnalyzer.1.23.0.nupkg`, unzip to /opt/psmods/PSScriptAnalyzer. (PSGallery is blocked by the workspace proxy.)
3. Run `scripts/lint.sh`. Pass = `LINT files=N findings=0`, exit 0.
