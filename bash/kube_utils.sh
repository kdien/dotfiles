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
  [[ -n "$config" ]] && export KUBECONFIG="$HOME/.kube/$config"
}

# shellcheck disable=SC2120
kct() {
  if [[ "$1" == '-u' ]]; then
    kubectl config unset current-context
    return $?
  fi

  [[ -z "$KUBECONFIG" ]] && kconf

  local context
  context=$(kubectl config get-contexts --output name | fzf --prompt='Select kube context: ')
  [[ -n "$context" ]] && kubectl config use-context "$context"
}

kns() {
  if [[ "$1" == '-u' ]]; then
    local current_context
    current_context=$(kubectl config current-context 2>/dev/null)
    [[ -n "$current_context" ]] && kubectl config unset contexts."$current_context".namespace
    return $?
  fi

  kubectl config current-context &>/dev/null || kct

  if kubectl config current-context &>/dev/null; then
    local namespace
    namespace=$(kubectl get namespaces --output name | awk -F '/' '{print $2}' | fzf --prompt='Select namespace: ')
    [[ -n "$namespace" ]] && kubectl config set-context --current --namespace="$namespace"
  fi
}
