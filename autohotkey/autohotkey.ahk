#q::Send !{F4}

#+t::
EnvGet, userdir, USERPROFILE
Run powershell.exe -WindowStyle Hidden "%userdir%\dotfiles\powershell\toggleWindowsTheme.ps1"
return
