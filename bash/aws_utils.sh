#!/usr/bin/env bash
# shellcheck disable=SC2016

ap() {
    new_profile=$(grep '\[profile' "$HOME/.aws/config" | sed 's/\[profile \(.*\)\]/\1/g' | sort | fzf --layout=reverse --height=~50% --border=rounded --prompt='AWS Profile >> ')
    if [[ -n "$new_profile" ]]; then
        export AWS_PROFILE=$new_profile
        echo "Switched to AWS profile '$AWS_PROFILE'"
    fi
}

ssm() {
    if [[ -z "$AWS_PROFILE" ]]; then
        echo 'AWS_PROFILE must be set first'
        return 1
    fi

    echo 'Querying running EC2 instances in current AWS profile...'
    instance_id=$( \
        aws ec2 describe-instances \
        --filters 'Name=instance-state-name,Values=running' \
        --query 'Reservations[*].Instances[*].{Name:Tags[?Key==`Name`]|[0].Value,InstanceId:InstanceId}' \
        --output text \
        | sort -k 2 \
        | fzf --layout=reverse --height=~50% --border=rounded --prompt='Select instance: ' \
        | awk '{print $1}' \
    )

    if [[ "$instance_id" =~ ^i-.+ ]]; then
        echo "Connecting to instance $instance_id"
        aws ssm start-session --target "$instance_id"
    fi
}
