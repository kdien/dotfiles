parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

## FileVault ##
add_vlt() {
  vlt st | grep \? | cut -c 2- | xargs -I {} vlt add {}
}

rm_vlt() {
  vlt st | grep ! | cut -c 2- | xargs -I {} vlt rm {}
}
