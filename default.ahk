#SingleInstance force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;; Executable for launching chrome
GlobalChromeApp = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"

;; Make CapsLock send ESC - use Win+CapsLock to toggle CapsLock
Capslock::Esc

#Capslock::
  if (GetKeyState("CapsLock", "T")) {
    SetCapsLockState, Off
  } else {
    SetCapsLockState, On
  }
return

;; Launch the Windows Calculator on Win+Numpad0
#Numpad0::
Run %A_WinDir%\system32\calc.exe
return

;; Sleep on Win+Alt+Pause
#!pause::
DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)
return

;; Launch the SnippingTool
printscreen::
Run %A_WinDir%\system32\SnippingTool.exe
return

;; Launch a new chrome windows on Win+backtick
#`::
Run %GlobalChromeApp% -new-window
return

;; Google search for whatever is currently selected
#g::
; The following values are in effect only for the duration of this hotkey thread.
; Therefore, there is no need to change them back to their original values
; because that is done automatically when the thread ends:
SetWinDelay 10
SetKeyDelay 0
AutoTrim, On

C_ClipboardPrev = %clipboard%
clipboard =

Send, ^c
ClipWait, 0.1
if ErrorLevel <> 0
{
   clipboard = %C_ClipboardPrev%
   return
}

C_Cmd = %clipboard%  ; This will trim leading and trailing tabs & spaces.
clipboard = %C_ClipboardPrev%  ; Restore the original clipboard for the user.

Run %GlobalChromeApp% -new-window http://www.google.ca/search?q="%C_Cmd%"

return


;
; cppreference search and auto launch first link (I'm Feeling Lucky)
; (Update: google shows a redirect notice now - there is no easy workaround for this)
;

#c::
SetWinDelay 10
SetKeyDelay 0
AutoTrim, On

C_ClipboardPrev = %clipboard%
clipboard =

Send, ^c
ClipWait, 0.1
if ErrorLevel <> 0
{
   clipboard = %C_ClipboardPrev%
   return
}

C_Cmd = %clipboard%  ; This will trim leading and trailing tabs & spaces.
clipboard = %C_ClipboardPrev%  ; Restore the original clipboard for the user.

c_application = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"

Run %GlobalChromeApp% -new-window https://www.google.ca/search?q=site:en.cppreference.com+"%C_Cmd%"&btnI=I

return


