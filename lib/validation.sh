#!/bin/bash
# shellcheck disable=SC1090

# =======================================================================================
# LIBRARY: VALIDATION
# =======================================================================================

# ---------------------------------------------------------------------------------------
# is_boolean_yes() - Checks if the given argument is a bool or if it's "true" or "yes"
#
# @arg Value to check
# @return bool
#
is_boolean_yes() {
    local -r bool="${1:-}"
    shopt -s nocasematch
    if [[ "$bool" = 1 || "$bool" =~ ^(yes|true|on)$ ]]; then
        true
    else
        false
    fi
}
