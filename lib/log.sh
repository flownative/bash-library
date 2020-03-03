#!/bin/bash

# =======================================================================================
# LIBRARY: LOG
# =======================================================================================

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
        log "\033[38;5;5mDEBUG\033[0m  ${*}"
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
    stderr_print "\033[38;5;5m$(date "+%T.%2N ")\033[0m ${*}"
}

# ---------------------------------------------------------------------------------------
# info() - Log a message with severity "info"
#
# @arg The message to log
# @return void
#
info() {
    log "\033[38;5;2mINFO \033[0m  ${*}"
}

# ---------------------------------------------------------------------------------------
# warn() - Log a message with severity "warning"
#
# @arg The message to log
# @return void
#
warn() {
    log "\033[38;5;3mWARN \033[0m  ${*}"
}

# ---------------------------------------------------------------------------------------
# error() - Log a message with severity "error"
#
# @arg The message to log
# @return void
#
error() {
    log "\033[38;5;1mERROR\033[0m  ${*}"
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
        log "\033[38;5;7mOUTPUT ${*}\033[0m"
        return
    fi

    while read -r message; do
        log "\033[38;5;7mOUTPUT ${message}\033[0m"
    done
}
