Set-PSReadLineKeyHandler -Chord Ctrl+d -Function DeleteCharOrExit

$PSDefaultParameterValues = @{
    "Get-ChildItem:Force"=$True
}

if (!(Test-Path Alias:npp)) {
    New-Alias -Name npp -Value "notepad++.exe"
}

if (!(Test-Path Alias:k)) {
    New-Alias -Name k -Value "kubectl.exe"
}

if (!(Test-Path Alias:tf)) {
    New-Alias -Name tf -Value "terraform.exe"
}

if (!(Test-Path Env:GODEBUG)) {
    [Environment]::SetEnvironmentVariable('GODEBUG', 'asyncpreemptoff=1', 'User')
}

Set-Alias -Name curl -Value curl.exe -Option AllScope

Import-Module posh-git
oh-my-posh init pwsh --config "$HOME\dotfiles\oh-my-posh\ohmyposh.json" | Invoke-Expression
$env:POSH_GIT_ENABLED = $true

Invoke-Expression "$HOME\dotfiles\powershell\sshCompletion.ps1"
Invoke-Expression "$HOME\dotfiles\powershell\awsCompletion.ps1"

function curlx {
    curl.exe -x proxy.example.com:8080 --url $args[0]
}

function e. {
    explorer .
}

function Get-ProcessMemoryUsage {
    if ([string]::IsNullOrEmpty($args[0])) {
        Write-Error "Missing process name, e.g. Get-ProcessMemoryUsage msedge"
        return
    }
    $searchName = '*' + $args[0] + '*'
    Get-Process -Name $searchName
    Write-Output "`r`n"
    $usage = (Get-Process -Name $searchName | Measure-Object WorkingSet -Sum).Sum / 1GB
    Write-Output "Total memory usage of the above processes: $usage GB"
}

function Get-ProcessOnPort {
    if ([string]::IsNullOrEmpty($args[0])) {
        Write-Error "Missing port number, e.g. Get-ProcessOnPort 4502"
        return
    }
    Get-Process -Id (Get-NetTCPConnection -LocalPort $args[0]).OwningProcess
}

function help {
    Get-Help $args[0] -Full | less
}

function vim {
    wsl -- nvim $args.Replace('C:\','/mnt/c/').Replace('.\','').Replace('\','/')
}

function which {
    (Get-Command $args[0] | Select Source).Source
}

##########################
## Custom Git functions ##
##########################
function gb {
    git branch -vv
}

function glog {
    git log --graph --decorate --oneline $args
}

function gs {
    git status
}

function gtop {
    $gitRoot = git rev-parse --show-toplevel
    Set-Location $gitRoot
}

function git_clean_branches {
    git fetch -p
    git branch -vv | Select-String ': gone]' | ForEach-Object { git branch -D $_.ToString().Split(' ')[2] }
}

function git_ssh {
    $newRemoteUrl = (git remote get-url origin).Replace("https://kdien@bitbucket.org/", "git@bitbucket.org:")
    git remote set-url origin $newRemoteUrl
}

function git_https {
    $newRemoteUrl = (git remote get-url origin).Replace("git@bitbucket.org:", "https://kdien@bitbucket.org/")
    git remote set-url origin $newRemoteUrl
}

function Git-Help {
    wsl -- git help $args
}

function Set-GitProxy {
    git config --global http.proxy http://proxy.example.com:8080
}

function Unset-GitProxy {
    git config --global --unset http.proxy
}

##########################
## Custom AEM functions ##
##########################
function Install-AEMPackage {
    if ([string]::IsNullOrEmpty($args[0])) {
        Write-Error "Missing package file, e.g. Install-AEMPackage content-package.zip"
        return
    }

    $pkg = $args[0]
    $pass = ConvertTo-SecureString -AsPlainText -String 'admin'
    $creds = New-Object PSCredential('admin', $pass)
    $form = @{
        file = Get-Item -Path "$pkg"
        name = (Get-Item -Path "$pkg").BaseName
        force = 'true'
        install = 'true'
    }

    $ProgressPreference = 'SilentlyContinue'
    $response = (Invoke-WebRequest -Authentication Basic -Credential $creds -AllowUnencryptedAuthentication -Method Post -Form $form -Uri 'http://localhost:4502/crx/packmgr/service.jsp').StatusCode

    if ($response -eq 200) {
        Write-Output "Package $((Get-Item -Path "$pkg").Name) successfully installed"
    } else {
        Write-Error "Error trying to install $pkg"
    }
}

function repo {
    wsl -- repo $args.Replace('.\','').Replace('\','/')
}
