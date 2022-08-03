#SingleInstance, force
#NoEnv
SendMode, Input

#InstallKeybdHook

#KeyHistory 400
KeyHistory

; Gui, New
; Gui, Show, W400 H300 NoActivate
height := 0


last_released_vkf0 := A_TickCount
last_pressed_vkf0 := A_TickCount
; long_pressed_vkf0 := false
; short_pressed_vkf0 := false
vkf0_state := "Off"   ; "Off" | "Short" | "Long"

short_interval := 50
long_interval := 200
release_interval := 400

called := 0
reset_last_release := 0

; #Persistent
SetTimer, Update_vkf0_state, 1000
; return


vkf0::
Send, .
if ((vkf0_state = "Off") && ((A_TickCount - last_released_vkf0) > release_interval)) {
  reset_last_release += 1
  last_pressed_vkf0 := A_TickCount
}
last_released_vkf0 := A_TickCount
SetTimer, Update_vkf0_state, 10
return

Update_vkf0_state:
called += 1
current := A_TickCount
debug := current - last_released_vkf0
debug2 := debug > long_interval
if ((current - last_released_vkf0) > long_interval) {
  if (vkf0_state = "Short") {
    Send, /
    ; SoundBeep, 350, 80
  } else if (vkf0_state = "Long") {
    Send, {CtrlUp}
    ; SoundBeep, 523, 80
  }
  vkf0_state := "Off"
  ; short_pressed_vkf0 := false
  ; long_pressed_vkf0 := false
  SetTimer, Update_vkf0_state, 1000
} else {
  if ((last_released_vkf0 - last_pressed_vkf0) < short_interval) {
    ; short_pressed_vkf0 := true
    ; long_pressed_vkf0 := false
    vkf0_state := "Short"
    ; SoundBeep, 440, 80
  } else {
    Send, {CtrlDown}
    vkf0_state := "Long"
    ; SoundBeep, 659, 80
  }
}
; height += 15
; if (height >= 300) {
;   height := 0
; }
; Gui, Show, W400 H300 NoActivate
; Gui, Add, Text, x0 y%height%, %vkf0_state%
ListVars
return
