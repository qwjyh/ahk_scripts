#SingleInstance, force
#NoEnv
SendMode, Input

#InstallKeybdHook

; ; set time for each line 0
; SetBatchLines, -1
; key history
#KeyHistory 400
KeyHistory
ListVars


last_released_vkf0 := A_TickCount
last_pressed_vkf0 := A_TickCount
vkf0_state := "Off"   ; "Off" | "Short" | "Long" | "Pending"
seq_count := 0
prv_seq_count := 0

called := 0
reset_last_release := 0

vk83_state := GetKeyState("vk83", "P")

SetTimer, Update_vkf0_state, 100


vk83::
  SetTimer, Update_vkf0_state, 20
  prv_seq_count := seq_count
  seq_count += 1
  return

vk83 Up::
  prv_seq_count := seq_count
  seq_count := 0
  return

Update_vkf0_state:
  ; called += 1 ; for debug

  ; vk83_state := GetKeyState("vk83", "P") ; for debug
  if (vkf0_state == "Off") {
  }
  ; long
  if ((seq_count >= 2) && (GetKeyState("vk83", "P") == 1)) {
    Send, {LCtrl Down}
    vkf0_state := "Long"
  }
  ; reset
  if ((prv_seq_count == 1) && (GetKeyState("vk83", "P") == 0)) {
    Send, {U+005C} ; \
    vkf0_state := "Off"
    prv_seq_count := seq_count
  }
  if ((vkf0_state == "Long") && (GetKeyState("vk83", "P") == 0)) {
    Send, {LCtrl Up}
    vkf0_state := "Off"
    prv_seq_count := seq_count
  }
  ; ListVars
  return
