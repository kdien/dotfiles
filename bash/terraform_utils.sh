#!/usr/bin/env bash

alias tf='terraform'
alias tft='terraform_target'
alias tfd='terraform-docs'
alias ti='terraform init'
alias tp='terraform plan'

if command -v terraform-docs &> /dev/null; then
    # shellcheck source=/dev/null
    . <(terraform-docs completion bash)
    complete -F __start_terraform-docs tfd
fi

terraform_target() {
    local file=$1
    local pattern=$2

    if [[ ! -f "$file" ]]; then
        echo "$file does not exist"
        return
    fi

    grep '^resource\|^module' "$file" | grep -E "$pattern" | sed 's/resource "\(.*\)" "\(.*\)".*/--target \1.\2 /;s/module "\(.*\)".*/--target module.\1 /'
}
