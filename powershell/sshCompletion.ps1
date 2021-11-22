using namespace System.Management.Automation

Register-ArgumentCompleter -CommandName ssh,scp,sftp -Native -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    $knownHosts = Get-Content $HOME\.ssh\known_hosts |
        ForEach-Object { ([string]$_).Split(' ')[0] } |
        ForEach-Object { $_.Split(',') } |
        Sort-Object -Unique

    $configHosts = Get-Content $HOME\.ssh\config |
        Select-String -Pattern "^Host (?!\*)" |
        ForEach-Object { $_ -replace "host ", "" } |
        Sort-Object -Unique

    $knownHosts += $configHosts

    $textToComplete = $wordToComplete
    $generateCompletionText = {
        param($x)
        $x
    }

    if ($wordToComplete -match "^(?<user>[-\w/\\]+)@(?<host>[-.\w]+)$") {
        $textToComplete = $Matches["host"]
        $generateCompletionText = {
            param($hostname)
            $Matches["user"] + "@" + $hostname
        }
    }

    $knownHosts |
        Where-Object { $_ -like "${textToComplete}*" } |
        ForEach-Object { [CompletionResult]::new((&$generateCompletionText($_)), $_, [CompletionResultType]::ParameterValue, $_) }
}
