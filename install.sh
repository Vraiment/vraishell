#!/bin/bash

# Location of helper shell files
RC_FILE="$HOME/.bashrc"
PROFILE_FILE="$HOME/.profile"
VRAI_SHELL_DIR="$HOME/.local/etc/vraishell"

function backup_if_exists {
    if [ -e "$PROFILE_FILE" ] || [ -e "$RC_FILE" ] || [ -e "$VRAI_SHELL_DIR" ]; then
        local CONTINUE
        read -r -p "Shell preferences already setup, type 'Y' to backup existing files and continue: " CONTINUE
        case "$CONTINUE" in
            Y) ;;
            *) exit 0;;
        esac
        
        local EPOCH
        EPOCH=$(date +%s)
        echo "Backups will be suffixed with '$EPOCH'"
        
        if [ -e "$RC_FILE" ]; then
            echo "Backing up $RC_FILE"
            mv "$RC_FILE" "${RC_FILE}_$EPOCH"
        fi
        
        if [ -e "$PROFILE_FILE" ]; then
            echo "Backing up $PROFILE_FILE"
            mv "$PROFILE_FILE" "${PROFILE_FILE}_$EPOCH"
        fi
        
        if [ -e "$VRAI_SHELL_DIR" ]; then
            echo "Backing up $VRAI_SHELL_DIR"
            mv "$VRAI_SHELL_DIR" "${VRAI_SHELL_DIR}_$EPOCH"
        fi
    fi
}

backup_if_exists

echo "Creating config dir"
mkdir -p "$VRAI_SHELL_DIR"

SHELL_FILES='bashrc.sh
profile.sh
aliases/000common.sh
environment/000common.sh
functions/env-variables.sh
functions/prompt.sh
path/000common.sh
path/010rbenv.sh'
for SHELL_FILE in $SHELL_FILES; do
    echo "Installing $SHELL_FILE in config dir"
    mkdir -p "$(dirname ${VRAI_SHELL_DIR}/${SHELL_FILE})"
    cp "${SHELL_FILE}" "${VRAI_SHELL_DIR}/${SHELL_FILE}"
done

echo "Linking .bashrc in home dir"
ln -s "$VRAI_SHELL_DIR/bashrc.sh" "$HOME/.bashrc"

echo "Linking .profile in home dir"
ln -s "$VRAI_SHELL_DIR/profile.sh" "$HOME/.profile"
