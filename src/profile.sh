#!/bin/sh

export VRAI_SHELL_DIR="${VRAI_SHELL_DIR:-"$HOME"/.local/etc/vraishell}"

if [ -z "${VRAI_SHELL_INIT+x}" ] || [ -z "$VRAI_SHELL_INIT" ]; then
    export VRAI_SHELL_INIT=profile.sh
else
    export VRAI_SHELL_INIT="${VRAI_SHELL_INIT}":profile.sh
fi

if ls -A "$VRAI_SHELL_DIR"/plugins/*/profile.d/* > /dev/null 2>&1; then
    for PLUGIN in "$VRAI_SHELL_DIR"/plugins/*; do
        for FILE in "$PLUGIN"/profile.d/*; do
            # shellcheck disable=SC1090
            . "$FILE"
        done
    done
fi
