#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status.
set -o pipefail # Propagate exit code on a pipeline
set -x # Print commands and their arguments as they are executed.

relative_install_dir=.local/etc/vraishell
readonly relative_install_dir

function main() {
    mkdir --parents "$HOME"/"$(dirname "$relative_install_dir")"

    symlink-vraishell-dir
    backup-bash-profile
    install-rc-files
}

function symlink-vraishell-dir() {
    local install_script_dir

    install_script_dir="$(readlink --canonicalize "$(dirname -- "${BASH_SOURCE[0]}")")"
    readonly install_script_dir

    # Always symlink into `$HOME/$relative_install_dir` regardless if there was a
    # symlink already there
    if ! first-symlinks-to-second "$HOME"/"$relative_install_dir" "$install_script_dir"; then
        ln --symbolic --force --backup=numbered --no-target-directory "$install_script_dir" "$HOME"/"$relative_install_dir"
    fi
}

function backup-bash-profile() {
    if [ ! -e "$HOME"/.bash_profile ]; then
        # Do nothing if the file does not exist
        return
    fi

    local tmp

    # Convoluted way of moving `"$HOME"/.bash_profile`
    # "into itself" so we can leverage `mv --backup`
    # 1. Create a temporary file
    # 2. Move the temporary file into the file we
    #    want to backup
    # 3. Delete the temporary file
    tmp=$(mktemp)
    readonly tmp

    mv --backup=numbered "$tmp" "$HOME"/.bash_profile
    rm "$HOME"/.bash_profile
}

function install-rc-files() {
    install-rc-file profile.sh .profile
    install-rc-file bashrc.sh .bashrc
}

function install-rc-file() {
    local source target

    source="$1"
    readonly source

    target="$2"
    readonly target

    if ! first-symlinks-to-second "$HOME"/"$target" "$HOME"/"$relative_install_dir"/"$source"; then
        ln --symbolic --force --backup=numbered "$relative_install_dir"/"$source" "$HOME"/"$target"
    fi
}

function first-symlinks-to-second() {
    [ -L "$1" ] && [ "$(readlink --canonicalize "$1")" = "$(readlink --canonicalize "$2")" ]
}

main "$@"
