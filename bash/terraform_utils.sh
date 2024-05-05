#!/usr/bin/env bash

alias tf='terraform'
alias tft='terraform_target'
alias tfd='terraform-docs'
alias ti='terraform init'
alias tp='terraform plan'

if command -v terraform-docs &>/dev/null; then
  # shellcheck source=/dev/null
  . <(terraform-docs completion bash)
  complete -F __start_terraform-docs tfd
fi

install_or_update_terraform_docs() {
  if [[ "$RUN_OS" = WSL || "$RUN_OS" = Linux ]]; then
    sudo -v
    echo 'Downloading latest terraform-docs...'
    url="$(
      curl -sSLH 'Accept: application/vnd.github+json' \
        https://api.github.com/repos/terraform-docs/terraform-docs/releases/latest \
        | jq -r \
          '.assets[] | select(.browser_download_url | match("linux-amd64\\.tar\\.gz$"))
        | .browser_download_url'
    )"
    if curl -sSLo tfdocs.tar.gz "$url"; then
      echo 'Download completed'
      echo 'Extracting and installing terraform-docs'
      tar -xf tfdocs.tar.gz --wildcards 'terraform-docs'
      sudo install -o root -g root -m 0755 terraform-docs /usr/local/bin
      rm -f tfdocs.tar.gz terraform-docs
      echo 'Done.'
    fi
  fi
}

install_or_update_tflint() {
  if [[ "$RUN_OS" = WSL || "$RUN_OS" = Linux ]]; then
    sudo -v
    echo 'Downloading latest tflint...'
    if curl -sSLo tflint.zip https://github.com/terraform-linters/tflint/releases/latest/download/tflint_linux_amd64.zip; then
      echo 'Download completed'
      echo 'Extracting and installing tflint'
      unzip -q tflint.zip
      sudo install -o root -g root -m 0755 tflint /usr/local/bin
      rm -f tflint.zip tflint
      echo 'Done.'
    fi
  fi
}

tf_clean() {
  rm -rf .terraform .terraform.lock.hcl
}

terraform_target() {
  local file=$1
  local pattern=$2

  if [[ ! -f "$file" ]]; then
    echo "$file does not exist"
    return
  fi

  grep '^resource\|^module' "$file" | grep -E "$pattern" | sed 's/resource "\(.*\)" "\(.*\)".*/--target \1.\2 /;s/module "\(.*\)".*/--target module.\1 /'
}
