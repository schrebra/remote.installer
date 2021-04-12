The collection of scripts was created to remotely install a program on remote systems.
It can install executables on remote systems

It works by running PsExec.exe on the remote system and runs commands to allow remote
administration to work properly

You need to modify all files in order for it to work properly.

Copy all the files in the repo to your C:\temp

Download psexec.exe from Microsoft and copy it into your C:\Windows\System32

Edit local.installer.bat

Replace installer.exe with the program
Example:   "%~dp0example.program.exe" /s
 /x is uninstall
 /s is silent

Edit installer.ps1

Where       copy "program.exe"     edit it with your program with full location.
Example:    copy "C:\temp\program.exe"

Where       copy "local.installer.bat"     edit it with the full location
Example:    copy "C:\temp\local.installer.bat"

If you are on a domain replace -u Adminstrator -p password with -s
-s runs it as NT Authority/system 	
Example: C:\Windows\System32\PsExec.exe \\$ComputerName -s winrm.cmd quickconfig -q
	
If you want to run it with local Administrator replace every instance of -u Administrator -p password
with your credentials

Edit group.installer.ps1
Add the computers you want to remotely install
Example     C:\temp\installer.ps1.ps1 remotemachine1
Example     C:\temp\installer.ps1.ps1 remotemachine2
Example     C:\temp\installer.ps1.ps1 remotemachine3
Example     C:\temp\installer.ps1.ps1 remotemachine4
Example     C:\temp\installer.ps1.ps1 remotemachine5

How does it all work
You run the group.installer.ps1 it runs individual commands against remote machines.
PsExec runs as a service on the remote machine and executes commands.
It then copys the files local.installer.bat and your program into the C:\temp\ on the remote machine
Then the installer.ps1 runs local.installer.bat which runs the target program.

Is there a better or faster way to do this?
Yes! Absolutely there is, but this is the way I knew how to do it at the time.