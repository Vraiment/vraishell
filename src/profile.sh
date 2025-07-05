#!/bin/sh

export VRAI_SHELL_DIR="${VRAI_SHELL_DIR:-"$HOME"/.local/etc/vraishell}"

if [ -z "${VRAI_SHELL_INIT+x}" ] || [ -z "$VRAI_SHELL_INIT" ]; then
    export VRAI_SHELL_INIT=profile.sh
else
    export VRAI_SHELL_INIT="${VRAI_SHELL_INIT}":profile.sh
fi

if ls -A "$VRAI_SHELL_DIR"/plugins/*/profile.d/* > /dev/null 2>&1; then
    for _VRAI_PLUGIN in "$VRAI_SHELL_DIR"/plugins/*; do
        for _VRAI_FILE in "$_VRAI_PLUGIN"/profile.d/*; do
            # shellcheck disable=SC1090
            . "$_VRAI_FILE"
        done
        unset _VRAI_FILE
    done
    unset _VRAI_PLUGIN
fi
