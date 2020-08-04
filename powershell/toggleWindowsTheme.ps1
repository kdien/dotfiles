$path = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize'

if ( (Get-ItemProperty -Path $path -Name AppsUseLightTheme).AppsUseLightTheme -eq 0 ) {
    $value = '1'
} else {
    $value = '0'
}

Set-ItemProperty -Path $path -Name AppsUseLightTheme -Value $value
