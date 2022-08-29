## configs (set these variable before installing)

# set Ahk2Exe.exe path
# example "C:\Program Files\AutoHotKey\Compiler\Ahk2Exe.exe"
$ahk2exe_path = $null


## end config

if ($ahk2exe_path -eq $null) {
  exit
}

# write to HKLM
powershell.exe -File .\change_sc_registrykey.ps1

# compile
& $ahk2exe_path /in .\home_util.ahk /out home_util.exe

# set taskscheduler
$action = New-ScheduledTaskAction -Execute (Resolve-Path .\home_util.exe)
$trigger = New-ScheduledTaskTrigger -AtStartup
$settings = New-ScheduledTaskSettingsSet
Register-ScheduledTask -TaskPath \ -TaskName home_util -Action $action -Trigger $trigger -Settings $settings -Force