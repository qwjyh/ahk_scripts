## configs (set these variable before installing)

# set Ahk2Exe.exe path
# example "C:\Program Files\AutoHotKey\Compiler\Ahk2Exe.exe"
$ahk2exe_path = "C:\Program Files\AutoHotKey\Compiler\Ahk2Exe.exe"


## end config

if ($null -eq $ahk2exe_path) {
  exit
}


# compile
& $ahk2exe_path /in .\hankakuzenkaku_esc.ahk /out hankakuzenkaku_esc.exe


# add to startup folder
$startup = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\"
Copy-Item .\hankakuzenkaku_esc.exe $startup
