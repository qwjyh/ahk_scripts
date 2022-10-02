## configs (set these variable before installing)

# set Ahk2Exe.exe path
# example "C:\Program Files\AutoHotKey\Compiler\Ahk2Exe.exe"
$ahk2exe_path = "C:\Program Files\AutoHotKey\Compiler\Ahk2Exe.exe"


## end config

if ($null -eq $ahk2exe_path) {
  exit
}


# compile
& $ahk2exe_path /in .\home_util.ahk /out home_util.exe

# set taskscheduler
$action = New-ScheduledTaskAction -Execute (Resolve-Path .\home_util.exe)
$trigger = New-ScheduledTaskTrigger -AtStartup
$settings = New-ScheduledTaskSettingsSet
$user = $env:COMPUTERNAME + "\Administrator"
Register-ScheduledTask -TaskPath \ -TaskName home_util -Action $action -Trigger $trigger -Settings $settings -User $user -Force

Start-ScheduledTask -TaskName home_util

# add to startup folder
$startup = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\"
Copy-Item .\home_util.exe $startup
