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
