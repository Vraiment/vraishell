# -----------------------------------------------------------------------------#
# Author: Vraiment                                                             #
#                                                                              #
# Template for a "$HOME/.bashrc" file, to install:                             #
#     1. Backup any existing "$HOME/.bashrc"                                   #
#     2. Copy all files under the "Shell Preferences" folder to                #
#        "$HOME/.local/etc/vraishell"                                          #
#     3. Create an alias from "$HOME/.bashrc" that points to                   #
#        "$HOME/.local/etc/vraishell/bashrc.sh"                                #
# -----------------------------------------------------------------------------#

# Location of helper shell files
export VRAI_SHELL_DIR="${HOME}/.local/etc/vraishell"
if [[ -z ${VRAI_SHELL_INIT+x} ]]; then
    VRAI_SHELL_INIT="bashrc.sh"
else
    VRAI_SHELL_INIT="${VRAI_SHELL_INIT}:bashrc.sh"
fi
export VRAI_SHELL_INIT

# commands to manipulate the path
source "$VRAI_SHELL_DIR/functions/env-variables.sh"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Common environment variables
for ALIAS_FILE in "${VRAI_SHELL_DIR}/aliases/"*.sh; do
    source "${ALIAS_FILE}"
done

# Custom prompt
source "$VRAI_SHELL_DIR/functions/prompt.sh"

