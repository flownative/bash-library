#!/bin/bash

# =======================================================================================
# LIBRARY: FILES
# =======================================================================================

. "${FLOWNATIVE_LIB_PATH}/log.sh"

# ---------------------------------------------------------------------------------------
# file_move_if_exists() - Moves a file if it exists, otherwise does nothing
#
# @arg The full path and filename if the source file
# @arg The target path or path and filename
# @return void
#
file_move_if_exists() {
    if [ -f "${1:?missing source filename}" ]; then
        mv "${1}" "${2:?missing target path}"
    else
        debug "Not moving '$1', because the file does not exist"
    fi
}
