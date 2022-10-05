#q::Send !{F4}

*CapsLock::
    Send {Blind}{Ctrl Down}
    cDown := A_TickCount
Return

*CapsLock up::
    If ((A_TickCount-cDown)<400)  ; Modify press time as needed (milliseconds)
        Send {Blind}{Ctrl Up}{Esc}
    Else
        Send {Blind}{Ctrl Up}
Return

$Esc::Capslock

#+t::
EnvGet, userdir, USERPROFILE
Run powershell.exe -WindowStyle Hidden "%userdir%\dotfiles\powershell\toggleWindowsTheme.ps1"
return

#+p::Run mspaint.exe
