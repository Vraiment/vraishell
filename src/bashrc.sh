#!/bin/bash

export VRAI_SHELL_DIR="${VRAI_SHELL_DIR:-"$HOME"/.local/etc/vraishell}"

if [ -z "${VRAI_SHELL_INIT+x}" ] || [ -z "$VRAI_SHELL_INIT" ]; then
    export VRAI_SHELL_INIT=bashrc.sh
else
    export VRAI_SHELL_INIT="${VRAI_SHELL_INIT}":bashrc.sh
fi

if ls -A "$VRAI_SHELL_DIR"/plugins/*/bashrc.d/* &> /dev/null; then
    for PLUGIN in "$VRAI_SHELL_DIR"/plugins/*; do
        for FILE in "$PLUGIN"/bashrc.d/*; do
            # shellcheck disable=SC1090
            source "$FILE"
        done
    done
fi
