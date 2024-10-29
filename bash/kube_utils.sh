#!/usr/bin/env bash
# shellcheck disable=SC1090

alias k='kubectl'

. <(kubectl completion bash)
complete -F __start_kubectl k

if command -v kustomize &>/dev/null; then
  . <(kustomize completion bash)
fi

if command -v minikube &>/dev/null; then
  . <(minikube completion bash)
fi

if command -v eksctl &>/dev/null; then
  . <(eksctl completion bash)
fi

kconf() {
  local config
  config=$(find "$HOME/.kube" -mindepth 1 -maxdepth 1 -type f -exec basename {} \; | fzf --prompt='Select kube config: ')
  if [[ -n "$config" ]]; then
    export KUBECONFIG="$HOME/.kube/$config"
  fi
}

kct() {
  [[ -z "$KUBECONFIG" ]] && kconf

  local context
  context=$(kubectl config get-contexts --output name | fzf --prompt='Select kube context: ')
  if [[ -n "$context" ]]; then
    kubectl config use-context "$context"
  fi
}
