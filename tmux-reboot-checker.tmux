#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
tmux bind-key T run-shell "$CURRENT_DIR/scripts/tmux_list_plugins.sh"

place_holder="\#{reboot}"

interpolate() {
    local -r status="$1"

    local -r check=$([ -f /var/run/reboot-required ] && echo "#[fg=red]Reboot!")
    local -r status_value=$(tmux show-option -gqv "$status")
    tmux set-option -gq "$status" "${status_value/$place_holder/$check}"
}

main() {
    interpolate "status-right"
}

main
