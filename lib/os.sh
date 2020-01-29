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
# @arg Number of maximum attempts. Default: 10
# @arg Number of seconds to wait before first retry. Default: 5
# @return bool 1 if the command could be executed, otherwise 0
#
with_backoff() {
    local -r command_line="${1:?missing command}"
    local -r maximum_attempts="${2:-5}"
    local -r wait_seconds="${3:-1}"

    local was_executed=0
    local current_timeout=$(( "${wait_seconds}" ))

    read -r -a command <<< "${command_line}"
    for ((attempt = 1 ; attempt < maximum_attempts ; attempt +=1 )); do
        if "${command[@]}"; then
            was_executed=1
            break
        fi
        debug "attempt $attempt"
        warn "Command failed, waiting ${current_timeout} until retry."
        sleep $current_timeout
        current_timeout=$(( current_timeout * 2 ))
    done

    [[ $was_executed = 1  ]] || error "Exponential backoff, command failed after ${attempt} attempts"
    return $was_executed
}
