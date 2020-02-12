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
    local -r pid="${1:?missing nginx.conf.template}"
    kill -0 "${pid}" 2>/dev/null
}

# ---------------------------------------------------------------------------------------
# process_stop() - Stops a process specified by PID
#
# @arg The process id (PID)
# @return void
#
process_stop() {
    local -r pid="${1:?missing process id}"

    kill "${pid}"
    with_backoff "[[ $(is_process_running "${pid}") != 0 ]]" || kill -9 "${pid}" 2>/dev/null
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
