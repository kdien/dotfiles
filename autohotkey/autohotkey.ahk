#q::Send !{F4}

+CapsLock::CapsLock

*CapsLock::
{
    Send {Blind}{Ctrl Down}
    global cDown := A_TickCount
    Return
}

*CapsLock up::
{
    If (A_TickCount - cDown < 100)  ; Modify press time as needed (milliseconds)
        Send {Blind}{Ctrl Up}{Esc}
    Else
        Send {Blind}{Ctrl Up}
    Return
}

#+p::Run "mspaint.exe"
