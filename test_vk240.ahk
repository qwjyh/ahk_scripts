#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

; contain previously pressed time
previous := A_TickCount

; when vkf0 pressed
vkf0::
; update variables
diff := A_TickCount - previous
previous := A_TickCount

Send, %A_TickCount%
Send, {Space}
Send, %diff%
Send, {Enter}
return