# -----------------------------------------------------------------------------#
# Author: Vraiment                                                             #
#                                                                              #
# Template for a "$HOME/.profile" file, to install:                            #
#     1. Backup any existing "$HOME/.profile"                                  #
#     2. Copy all files under the "Shell Preferences" folder to                #
#        "$HOME/.local/etc/vraishell"                                          #
#     3. Create an alias from "$HOME/.profile" that points to                  #
#        "$HOME/.local/etc/vraishell/profile.sh"                               #
# -----------------------------------------------------------------------------#

# Location of helper shell files
export VRAI_SHELL_DIR="${HOME}/.local/etc/vraishell"
if [[ -z ${VRAI_SHELL_INIT+x} ]]; then
    VRAI_SHELL_INIT="profile.sh"
else
    VRAI_SHELL_INIT="${VRAI_SHELL_INIT}:profile.sh"
fi
export VRAI_SHELL_INIT

# commands to manipulate the path
source "$VRAI_SHELL_DIR/functions/env-variables.sh"

# Setup environment variables
for ENVIRONMENT_FILE in "${VRAI_SHELL_DIR}/environment/"*.sh; do
    source "${ENVIRONMENT_FILE}"
done

# If running bash source the bashrc
if [ -n "$BASH_VERSION" ]; then
    source "$HOME/.bashrc"
fi

# Initialize sdkman
SDKMAN_DIR="$HOME/.sdkman"
if [ -d "$SDKMAN_DIR" ]; then
    export SDKMAN_DIR
    [[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"
fi

# Setup PATH (last thing to do in the .profile)
for PATH_FILE in $(command ls -r "${VRAI_SHELL_DIR}/path/"*.sh); do
    source "${PATH_FILE}"
done
