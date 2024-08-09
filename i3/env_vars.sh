#!/usr/bin/env bash
# shellcheck disable=SC2155

export QT_QPA_PLATFORMTHEME=qt5ct
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_ENABLE_HIGHDPI_SCALING=1
export SSH_AUTH_SOCK="/run/user/$(id -u)/gcr/ssh"
