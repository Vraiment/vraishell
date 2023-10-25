#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status.
set -o pipefail # Propagate exit code on a pipeline
set -x # Print commands and their arguments as they are executed.

readonly relative_install_dir=.local/etc/vraishell

function main() {
    mkdir --parents "$HOME"/"$(dirname "$relative_install_dir")"

    symlink-vraishell-dir

    # Install files required for the shell
    install-rc-file src/profile.sh "$HOME"/.profile
    install-rc-file src/bash_profile.sh "$HOME"/.bash_profile
    install-rc-file src/bashrc.sh "$HOME"/.bashrc
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

function backup-file() {
    local file tmp
    
    file="$1"
    readonly file

    if [ ! -e "$file" ]; then
        # Do nothing if the file does not exist
        return
    fi

    # Convoluted way of moving `"$HOME"/.bash_profile`
    # "into itself" so we can leverage `mv --backup`
    # 1. Create a temporary file
    # 2. Move the temporary file into the file we
    #    want to backup
    # 3. Delete the temporary file
    tmp="$(mktemp)"
    readonly tmp

    mv --backup=numbered "$tmp" "$file"
    rm "$file"
}

function install-rc-file() {
    local source target

    source="$1"
    readonly source

    target="$2"
    readonly target

    if ! first-symlinks-to-second "$target" "$HOME"/"$relative_install_dir"/"$source"; then
        backup-file "$target"
        ln --symbolic --force --backup=numbered "$relative_install_dir"/"$source" "$target"
    fi
}

function first-symlinks-to-second() {
    [ -L "$1" ] && [ "$(readlink --canonicalize "$1")" = "$(readlink --canonicalize "$2")" ]
}

main "$@"
