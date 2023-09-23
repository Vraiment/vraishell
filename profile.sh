#!/bin/sh

# This file is a plain /bin/sh file which removes a lot of what bash
# brings like being able to use `source` instead of `.`, but it's
# supposed to be shell agnostic so we have to deal with it

# Expected location of helper shell files
export VRAI_SHELL_DIR="${HOME}/.local/etc/vraishell"
# The following line is confusing but basically means:
# `if VRAI_SHELL_INIT is undefined or VRAI_SHELL_INIT is empty`
if [ -z "${VRAI_SHELL_INIT+x}" ] || [ -z "$VRAI_SHELL_INIT" ]; then
    VRAI_SHELL_INIT="profile.sh"
else
    VRAI_SHELL_INIT="${VRAI_SHELL_INIT}:profile.sh"
fi
export VRAI_SHELL_INIT

# commands to manipulate the path
# shellcheck disable=SC1091
. "$VRAI_SHELL_DIR/functions/env-variables.sh"

# Setup environment variables
for ENVIRONMENT_FILE in "${VRAI_SHELL_DIR}/environment/"*.sh; do
    # shellcheck disable=SC1090
    . "${ENVIRONMENT_FILE}"
done

# If running bash source the bashrc
if [ -n "$BASH_VERSION" ]; then
    # shellcheck disable=SC1091
    . "$HOME/.bashrc"
fi

# Initialize sdkman
SDKMAN_DIR="$HOME/.sdkman"
if [ -d "$SDKMAN_DIR" ]; then
    export SDKMAN_DIR
    # shellcheck disable=SC1091
    [ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ] && . "${SDKMAN_DIR}/bin/sdkman-init.sh"
fi

# Setup PATH (last thing to do in the .profile)
for PATH_FILE in $(command ls -r "${VRAI_SHELL_DIR}/path/"*.sh); do
    # shellcheck disable=SC1090
    . "${PATH_FILE}"
done
