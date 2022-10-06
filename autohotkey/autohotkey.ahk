#q::Send !{F4}

$Capslock::Esc
$PrintScreen::Capslock

#+t::
EnvGet, userdir, USERPROFILE
Run powershell.exe -WindowStyle Hidden "%userdir%\dotfiles\powershell\toggleWindowsTheme.ps1"
return

#+p::Run mspaint.exe
