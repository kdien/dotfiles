if (!(Test-Path Alias:npp)) {
    New-Alias -Name npp -Value "notepad++.exe"
}

Set-Alias -Name curl -Value curl.exe -Option AllScope

#Import-Module posh-git
#$GitPromptSettings.DefaultPromptSuffix = $GitPromptSettings.DefaultPromptSuffix.Replace("'>'", "'`n>'")

Import-Module posh-git,oh-my-posh
Set-Theme Paradox

function curlx {
    curl.exe -x proxy.example.com:8080 --url $args[0]
}

function e. {
    explorer .
}

##########################
## Custom Git functions ##
##########################
function gb {
    git branch -vv
}

function glog {
    git log --graph --decorate --oneline
}

function gs {
    git status
}

function gtop {
    $gitRoot = git rev-parse --show-toplevel
    Set-Location $gitRoot
}

function git_ssh {
    $newRemoteUrl = (git remote get-url origin).Replace("https://kdien@bitbucket.org/", "git@bitbucket.org:")
    git remote set-url origin $newRemoteUrl
}

function git_https {
    $newRemoteUrl = (git remote get-url origin).Replace("git@bitbucket.org:", "https://kdien@bitbucket.org/")
    git remote set-url origin $newRemoteUrl
}

function Set-GitProxy {
    git config --global http.proxy http://proxy.example.com:8080
}

function Unset-GitProxy {
    git config --global --unset http.proxy
}

