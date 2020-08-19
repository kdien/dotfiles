parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

git_clean_branches() {
    git fetch -p
    git branch -vv | grep ': gone]' | while read -r branch; do
        git branch -D "${branch%% *}"
    done
}

git_https() {
    git remote set-url origin $(git remote get-url origin | sed -e "s/git@bitbucket\.org:/https:\/\/kdien@bitbucket\.org\//")
}

git_ssh() {
    git remote set-url origin $(git remote get-url origin | sed -e "s/https:\/\/kdien@bitbucket\.org\//git@bitbucket\.org:/")
}

set_apt_proxy() {
    echo 'Acquire::http::Proxy "http://proxy.example.com:8080";' | sudo tee /etc/apt/apt.conf
}

unset_apt_proxy() {
    sudo sed -i "s/Acquire::http::Proxy.*//" /etc/apt/apt.conf
}

## FileVault ##
add_vlt() {
    vlt st | grep \? | cut -c 2- | xargs -I {} vlt add {}
}

rm_vlt() {
    vlt st | grep ! | cut -c 2- | xargs -I {} vlt rm {}
}

