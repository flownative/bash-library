#!/bin/bash

# =======================================================================================
# LIBRARY: LOG
# =======================================================================================

# Colors
RESET='\033[0m'
RED='\033[38;5;1m'
GREEN='\033[38;5;2m'
YELLOW='\033[38;5;3m'
MAGENTA='\033[38;5;5m'

# ---------------------------------------------------------------------------------------
# stderr_print() - Print to STDERR
#
# @arg The message to print
# @return void
#
stderr_print() {
    printf "%b\\n" "${*}" >&2
}

# ---------------------------------------------------------------------------------------
# debug() – Log a message with severity "debug"
#
# @arg The message to log
# @return void
#
debug() {
    local -r bool="${LOG_DEBUG:-false}"
    shopt -s nocasematch
    if [[ "$bool" == 1 || "$bool" =~ ^(yes|true)$ ]]; then
        log "${MAGENTA}DEBUG${RESET} ${*}"
    fi
}

# ---------------------------------------------------------------------------------------
# debug_device() – Returns "/dev/stdout" if in debug mode, otherwise "/dev/null"
#
# @return void
#
debug_device() {
    local -r bool="${LOG_DEBUG:-false}"
    shopt -s nocasematch
    if [[ "$bool" == 1 || "$bool" =~ ^(yes|true)$ ]]; then
        echo "/dev/stdout"
    else
        echo "/dev/null"
    fi
}

# ---------------------------------------------------------------------------------------
# log() - Log a message
#
# @arg The message to log
# @return void
#
log() {
    stderr_print "${MAGENTA}$(date "+%T.%2N ")${RESET}${*}"
}

# ---------------------------------------------------------------------------------------
# info() - Log a message with severity "info"
#
# @arg The message to log
# @return void
#
info() {
    log "${GREEN}INFO ${RESET} ${*}"
}

# ---------------------------------------------------------------------------------------
# warn() - Log a message with severity "warning"
#
# @arg The message to log
# @return void
#
warn() {
    log "${YELLOW}WARN ${RESET} ${*}"
}

# ---------------------------------------------------------------------------------------
# error() - Log a message with severity "error"
#
# @arg The message to log
# @return void
#
error() {
    log "${RED}ERROR${RESET} ${*}"
}
