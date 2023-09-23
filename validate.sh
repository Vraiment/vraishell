#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status.
set -o pipefail # Propagate exit code on a pipeline
set -x # Print commands and their arguments as they are executed.

function main() {
    ensure-shellcheck
    validate-files
}

function ensure-shellcheck() {
    if ! command -v shellcheck; then
        >&2 echo shellcheck not found
        exit 1
    fi
}

function validate-files() {
    local files files_path

    files=(
        aliases/*
        environment/*
        functions/*
        path/*
        bashrc.sh
        install.sh
        profile.sh
        validate.sh
    )
    readonly files

    files_path=$(mktemp)
    readonly files_path

    # I need a mechanism to skip files and Bash, asinine as it is, requires a very convoluted
    # way to acomplish it, put them into a file skipping the ones I don't want and then use
    # that file as an argument list.
    printf "%s\n" "${files[@]}" \
        | grep -v '^path/010rbenv.sh$' \
        | grep -v '^functions/env-variables.sh$' \
        > "$files_path"
    xargs -a "$files_path" -d "\n" shellcheck
}

main "$@"
