#!/bin/bash
. "${FLOWNATIVE_LIB_PATH}/log.sh"
. "${FLOWNATIVE_LIB_PATH}/os.sh"

# ---------------------------------------------------------------------------------------
# is_process_running() - Checks if the specified process is running
#
# @arg The process id (PID)
# @return bool 0 if the process is running, otherwise >0
#
is_process_running() {
    local -r pid="${1:?missing process id}"
    kill -0 "${pid}" 2>/dev/null
}

# ---------------------------------------------------------------------------------------
# is_process_not_running() - Checks if the specified process is not running
#
# @arg The process id (PID)
# @return bool 0 if the process is not running, otherwise 1
#
is_process_not_running() {
    local -r pid="${1:?missing process id}"
    kill -0 "${pid}" 2>/dev/null && return 1
    return 0
}

# ---------------------------------------------------------------------------------------
# process_stop() - Stops a process specified by PID
#
# @arg The process id (PID)
# @arg (optional) The signal to send. Default: "QUIT". Other possible signals: "TERM", "INT" ...
# @return void
#
process_stop() {
    local -r pid="${1:?missing process id}"
    local signal="${2:-QUIT}"
    kill -s "${signal}" "${pid}"
    sleep 2
    with_backoff "is_process_not_running $pid" || kill -9 "${pid}" 2>/dev/null
}

# ---------------------------------------------------------------------------------------
# process_get_pid_from_file() - Extracts the process id from a specified (PID) file
#
# @arg The process id (PID)
# @return int Number of the process id or 0
#
process_get_pid_from_file() {
    local pid_path_and_filename="${1:?missing path and filename of pid file}"

    if [[ -f "${pid_path_and_filename}" ]]; then
        if [[ -n "$(< "${pid_path_and_filename}")" ]] && [[ "$(< "${pid_path_and_filename}")" -gt 0 ]]; then
            echo "$(< "${pid_path_and_filename}")"
        fi
    fi
}
