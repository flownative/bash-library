#!/bin/bash

# =======================================================================================
# LIBRARY: OS
# =======================================================================================

# Load helper lib

. "${FLOWNATIVE_LIB_PATH}/log.sh"

# ---------------------------------------------------------------------------------------
# with_backoff() - Attempt executing a command, with exponential back-off
#
# @arg The full command line as a string
# @arg Number of maximum attempts. Default: 5
# @arg Number of seconds to wait before first retry. Default: 1
# @return int 0 if the command could be executed, otherwise 1
#
with_backoff() {
    local -r command_line="${1:?missing command}"
    local -r maximum_attempts="${2:-5}"
    local -r wait_seconds="${3:-1}"

    local exit_code=1
    local current_timeout=$(( "${wait_seconds}" ))

    read -r -a command <<< "${command_line}"
    for ((attempt = 1 ; attempt < maximum_attempts ; attempt +=1 )); do
        if "${command[@]}"; then
            exit_code=0
            break
        fi
        warn "Command failed, waiting ${current_timeout} seconds until retry."
        sleep $current_timeout
        current_timeout=$(( current_timeout * 2 ))
    done

    [[ $exit_code = 0  ]] || error "Exponential backoff, command failed after ${attempt} attempts"
    return $exit_code
}
