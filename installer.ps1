
<#download psexec from microsofts package called sysinternals
copy psexec.exe to system32
open cmd.exe as administrator
type powershell.exe
type set-executionpolicy -bypass localmachine -force
type psexec.exe -accepteula
for psexec use -u and -p for administrator and password of remote machine after \\$ComputerName
Example C:\Windows\System32\PsExec.exe \\$ComputerName -u administrator -p password winrm.cmd quickconfig -q
#>


Param (
	[Parameter(Position = 0)]
	[String[]]$ComputerName
)


If (Test-Connection -ComputerName $ComputerName -Quiet)
{
	
	copy "program.exe" "\\$ComputerName\c$\temp\"
	copy "local.installer.bat" "\\$ComputerName\c$\temp\"

    C:\Windows\System32\PsExec.exe \\$ComputerName -u Administrator -p password -accepteula
	C:\Windows\System32\PsExec.exe \\$ComputerName -u Administrator -p password winrm.cmd quickconfig -q
    C:\Windows\System32\PsExec.exe \\$ComputerName -u Administrator -p password netsh advfirewall firewall set rule group = "windows management instrumentation (wmi)" new enable=yes
    C:\Windows\System32\PsExec.exe \\$ComputerName -u Administrator -p password netsh advfirewall firewall add rule dir=out name "WMI_OUT" program=%systemroot%\System32\svchost.exe service=winmgmt action=allow protocol=TCP local=any
    C:\Windows\System32\PsExec.exe \\$ComputerName -u Administrator -p password netsh advfirewall firewall add rule dir=in name "UnsecApp" program=%systemroot%\System32\wbem\unsecapp.exe action=allow
    C:\Windows\System32\PsExec.exe \\$ComputerName -u Administrator -p password netsh advfirewall firewall add rule dir=in name "WMI" program=%systemroot%\System32\svchost.exe service=winmgmt action = allow protocol=TCP localport=any
    C:\Windows\System32\PsExec.exe \\$ComputerName -u Administrator -p password cmd.exe /c reg add \\$ComputerName\HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f
    C:\Windows\System32\PsExec.exe \\$ComputerName -u Administrator -p password cmd.exe /c reg add \\$ComputerName\HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters /t REG_DWORD /v hidden /d 0 /f
    C:\Windows\System32\PsExec.exe \\$ComputerName -u Administrator -p password cmd.exe /c reg add \\$ComputerName\HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters /t REG_DWORD /v autosharewks /d 1 /f
    C:\Windows\System32\PsExec.exe \\$ComputerName -u Administrator -p password cmd.exe /c reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WBEM\CIMOM\AllowAnonymousCallback" /t REG_DWORD /d 1 /f
    C:\Windows\System32\PsExec.exe \\$ComputerName -u Administrator -p password C:\temp\local.installer.bat
	
}
Else
{
	Write-Host "$ComputerName Offline" -ForegroundColor Red
}

Write-Host "$ComputerName Completed"