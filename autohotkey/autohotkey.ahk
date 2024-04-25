#q::Send("!{F4}")

*CapsLock::
{
    Send("{Blind}{Ctrl Down}")
    global cDown := A_TickCount
    Return
}

*CapsLock up::
{
    If ((A_TickCount - cDown) < 150)  ; Modify press time as needed (milliseconds)
        Send("{Blind}{Ctrl Up}{Esc}")
    Else
        Send("{Blind}{Ctrl Up}")
    Return
}

+CapsLock::CapsLock

#+t::
{
    userdir := EnvGet("USERPROFILE")
    Run("powershell.exe -WindowStyle Hidden `"" userdir "\dotfiles\powershell\toggleWindowsTheme.ps1`"")
    Return
}

#+p::Run("mspaint.exe")
