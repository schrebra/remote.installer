# remote.installer
Install Programs Remotely with PsExec


The collection of scripts was created to remotely install a program on remote systems.
It can install executables on remote systems

It works by running PsExec.exe on the remote system and runs commands to allow remote
administration to work properly

You need to modify all files in order for it to work properly.


<H1>How does it all work?
  
You run the group.installer.ps1 it runs individual commands against remote machines.
PsExec runs as a service on the remote machine and executes commands.
It then copys the files local.installer.bat and your program into the C:\temp\ on the remote machine
Then the installer.ps1 runs local.installer.bat which runs the target program.

<H2>Is there a better or faster way to do this?
  
Yes! Absolutely there is, but this is the way I knew how to do it at the time.
