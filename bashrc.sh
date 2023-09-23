#!/bin/bash

# Location of helper shell files
export VRAI_SHELL_DIR="${HOME}/.local/etc/vraishell"
# The following line is confusing but basically means:
# `if VRAI_SHELL_INIT is undefined or VRAI_SHELL_INIT is empty`
if [ -z "${VRAI_SHELL_INIT+x}" ] || [ -z "$VRAI_SHELL_INIT" ]; then
    VRAI_SHELL_INIT="bashrc.sh"
else
    VRAI_SHELL_INIT="${VRAI_SHELL_INIT}:bashrc.sh"
fi
export VRAI_SHELL_INIT

# commands to manipulate the path
# shellcheck disable=SC1091
source "$VRAI_SHELL_DIR/functions/env-variables.sh"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Common environment variables
for ALIAS_FILE in "${VRAI_SHELL_DIR}/aliases/"*.sh; do
    # shellcheck disable=SC1090
    source "${ALIAS_FILE}"
done

# Custom prompt
# shellcheck disable=SC1091
source "$VRAI_SHELL_DIR/functions/prompt.sh"

