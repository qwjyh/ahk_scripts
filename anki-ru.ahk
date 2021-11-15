lang := 1

#IfWinActive, ahk_exe anki.exe
+Space::
Sleep, 200
If (lang = 1)
{
  Send, {LAlt down}
  Send, {LShift}
  Send, {LAlt up}

  lang := lang + 1
} Else {
  Send, {LAlt down}
  Send, {LShift}
  Send, {LAlt up}
  Send, {LAlt down}
  Send, {LShift}
  Send, {LAlt up}
  lang := lang - 1
}