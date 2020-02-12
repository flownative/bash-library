#!/bin/bash
. "${FLOWNATIVE_LIB_PATH}/log.sh"
. "${FLOWNATIVE_LIB_PATH}/os.sh"

set -e
set -u

# ---------------------------------------------------------------------------------------
# packages_install() - Install packages via apt-get and retry if installation fails
#
# @arg A list of packages
# @return exit code
#
packages_install() {
    local -r packages="${1:?missing package names}"
    export DEBIAN_FRONTEND=noninteractive

    info "Installing the following packages: ${packages}"
    with_backoff "packages_apt_get_install ${packages}" || (error "Failed installing packages"; exit 1)

    rm -rf /var/lib/apt/lists /var/cache/apt/archives
}

# ---------------------------------------------------------------------------------------
# packages_apt_get_install() - Internal, runs apt-get update && apt-get install
#
# @arg A list of packages
# @return exit code
#
packages_apt_get_install() {
    apt-get update -qq && apt-get install -y --no-install-recommends "$@"
}
