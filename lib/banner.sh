#!/bin/bash

# =======================================================================================
# LIBRARY: BANNER
# =======================================================================================

export BANNER_FLOWNATIVE_SKIP=${BANNER_FLOWNATIVE_SKIP:-}

# ---------------------------------------------------------------------------------------
# banner_flownative() - Display a Flownative banner
#
# @return void
#
banner_flownative() {
    local -r image_name="${1:?missing image name}"

    if [ "${BANNER_FLOWNATIVE_SKIP}" = "" ]; then
        echo '[38;5;255;255;255m        [0m[38;5;7m                                             [0m'
        echo "[38;5;196;48;5;196m       [0m[38;5;255;255;255m   $(printf "%-41s" "${image_name}") [0m"
        echo '[38;5;196;48;5;196m       [0m[38;5;7m   This Docker image was handcrafted for you [0m'
        echo '[38;5;196;48;5;196m       [0m[38;5;7m   by Flownative.         www.flownative.com [0m'
        echo '[38;5;255;255;255m        [0m[38;5;7m                                             [0m'
    fi
}

# ---------------------------------------------------------------------------------------
# banner_beach_instance() - Display a Beach instance banner
#
# @return void
#
banner_beach_instance() {
    local -r instance_name="${1:?missing instance name}"
    local -r instance_identifier="${2:-}"

    if [ "${BANNER_FLOWNATIVE_SKIP}" = "" ]; then
        echo '[38;5;255;255;255m        [0m[38;5;7m                                                                 [0m'
        echo "[38;5;196;48;5;196m       [0m[38;5;255;255;255m   $(printf "%-61s" "Flownative Beach") [0m"
        echo "[38;5;196;48;5;196m       [0m[38;5;7m   $(printf "%-61s" "${instance_name}") [0m"
        echo "[38;5;196;48;5;196m       [0m[38;5;7m   $(printf "%-61s" "${instance_identifier}") [0m"
        echo '[38;5;255;255;255m        [0m[38;5;7m                                                                 [0m'
    fi
}
