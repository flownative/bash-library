#!/bin/bash

# =======================================================================================
# LIBRARY: LOG
# =======================================================================================

export FLOWNATIVE_LOG_PATH_AND_FILENAME=${FLOWNATIVE_LOG_PATH_AND_FILENAME:-/opt/flownative/log/flownative.log}

# ---------------------------------------------------------------------------------------
# stderr_print() - Print to STDERR
#
# @arg The message to print
# @return void
#
stderr_print() {
    printf "%b\\n" "${*}" >> "${FLOWNATIVE_LOG_PATH_AND_FILENAME}"
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
        log "[debug] ${*}"
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
        echo "${FLOWNATIVE_LOG_PATH_AND_FILENAME}"
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
    stderr_print "${*}"
}

# ---------------------------------------------------------------------------------------
# info() - Log a message with severity "info"
#
# @arg The message to log
# @return void
#
info() {
    log "[info] ${*}"
}

# ---------------------------------------------------------------------------------------
# warn() - Log a message with severity "warning"
#
# @arg The message to log
# @return void
#
warn() {
    log "[warn] ${*}"
}

# ---------------------------------------------------------------------------------------
# error() - Log a message with severity "error"
#
# @arg The message to log
# @return void
#
error() {
    log "[error] ${*}"
}

# ---------------------------------------------------------------------------------------
# output() - Log output of another script or process
#
# @arg The message to log
# @return void
#
output() {
    local message
    if [ "$*" != "" ]; then
        log "${*}"
        return
    fi

    while read -r message; do
        log "${message}"
    done
}
