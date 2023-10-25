#!/bin/bash

export VRAI_SHELL_DIR="${VRAI_SHELL_DIR:-"$HOME"/.local/etc/vraishell}"

if [ -z "${VRAI_SHELL_INIT+x}" ] || [ -z "$VRAI_SHELL_INIT" ]; then
    export VRAI_SHELL_INIT=bash_profile.sh
else
    export VRAI_SHELL_INIT="${VRAI_SHELL_INIT}":bash_profile.sh
fi

# Bash will skip `.profile` if ` .bash_profile` exists, this will ensure both
# are sourced. This is so generic setup can be placed just as `.profile` and is
# separate from bash specific logic.
if [ -e "$HOME"/.profile ]; then
    # shellcheck disable=SC1091
    source "$HOME"/.profile
fi

if ls -A "$VRAI_SHELL_DIR"/plugins/*/bash_profile.d/* &> /dev/null; then
    for PLUGIN in "$VRAI_SHELL_DIR"/plugins/*; do
        for FILE in "$PLUGIN"/bash_profile.d/*; do
            # shellcheck disable=SC1090
            source "$FILE"
        done
    done
fi

# Load `.bashrc` if an interactive shell is started
if [[ $- == *i* ]] && [ -e "$HOME"/.bashrc ]; then
    # shellcheck disable=SC1091
    source "$HOME"/.bashrc
fi
