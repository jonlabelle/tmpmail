#!/usr/bin/env bash

set -e

# shellcheck disable=SC2005
readonly SCRIPTSDIR="$(cd "$(dirname "${0}")"; echo "$(pwd)")"
readonly SCRIPTNAME=$(basename "${0}")

SOURCE_PATH="${SCRIPTSDIR}/bin/tmpmail.sh"
INSTALL_PATH=~/bin/tmpmail

update_tmpmail() {
    if [[ -f "${SOURCE_PATH}" ]]; then
        echo "> Removing previous version '$SOURCE_PATH'"
        rm -f "${SOURCE_PATH}"
    fi

    echo "> Downloading latest 'sdushantha/tmpmail' version from GitHub"
    curl "https://raw.githubusercontent.com/sdushantha/tmpmail/master/tmpmail" -o "${SOURCE_PATH}"
}

usage() {
    echo
    echo "Usage: ${SCRIPTNAME} <install_option>"
    echo
    echo "Install/uninstall the program."
    echo
    echo "Install options:"
    echo
    echo "  -i, --install     to install '${SOURCE_PATH}' to '${INSTALL_PATH}'"
    echo "  -u, --uninstall   to uninstall/remove '${INSTALL_PATH}'"
    echo "  -h, --help        show this message and exit"
    echo
}

ensure_install_path() {
    # append '.ext' to install path in case the program being installed doesn't
    # have an extension; otherwise, `dirname` will think the program is a dir.
    local install_path

    install_path=$(dirname ${INSTALL_PATH}.ext)

    if [ ! -d "$install_path" ]; then
        echo "> Creating install path '${install_path}'"
        mkdir -p "$install_path"
    fi
}

uninstall() {
    echo "> Checking for previously installed version '$INSTALL_PATH'"

    if [[ -L "${INSTALL_PATH}" || -f "${INSTALL_PATH}" ]]; then
        echo "Removing old version"
        rm -f "${INSTALL_PATH}"
    else
        echo "Existing installation not found."
    fi
}

install() {
    echo "> Creating symlink '$SOURCE_PATH' -> '$INSTALL_PATH'"
    ln -s "$SOURCE_PATH" $INSTALL_PATH
}

make_executable() {
    echo "> Making '$INSTALL_PATH' executable"
    chmod +x $INSTALL_PATH
}

main() {
    if [[ "$1" = "-h" || "$1" = "--help" || "$1" = "help" ]]; then
        usage
        exit 1
    elif [[ "$1" = "-i" || "$1" = "--install" ]]; then
        ensure_install_path
        uninstall
        update_tmpmail
        install
        make_executable
    elif [[ "$1" = "-u" || "$1" = "--uninstall" ]]; then
        uninstall
    else
        echo
        echo "'$1' is not a valid option."
        usage
        exit 1
    fi

    exit 0
}

if [ $# -eq 0 ]; then
    usage
    exit 1
else
    main "$*"
fi
