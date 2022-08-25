; https://www.autohotkey.com/board/topic/67948-detect-any-letter-key-press/

Loop 26
  Hotkey, % Chr(A_Index+96), SomeLabel ;loop creating hotkeys for a-z
Return



SomeLabel:
Func(A_ThisHotkey)
Return



Func(var) {
  MsgBox %var%
}