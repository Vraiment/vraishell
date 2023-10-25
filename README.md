# VraiShell
-----------

VraiShell is a series of scripts to setup the shell's environment, in particular Bash. Is very confusing to know what code should go into what script so this document intents to clarify what each script is for. Note that this focus mostly on Bash but it may apply for other shells like ZSh.

## Definitions

- Login Shell: Shell that is created when initializing a new session. This is for example when starting a new session on a TTY, or via a desktop environment.
- Interactive Shell: Shells where the user is supposed interact with them directly, these does not include desktop environments.

## Script files

The scripts to setup a shell environment can be devided in two sets: for login shells and for interactive shells. This doesn't mean they can't be used on the other but it helps to understand when they are executed so they can be invoked "out of context" if needed.

Scripts like `/etc/profile`, `$HOME/.bash_profile`, `$HOME/.bash_login` and `$HOME/.profile`  will get invoked when a login shell is started. Note `/etc/profile` and `$HOME/.profile` are shell agnostic and can be invoked even by the startup process of desktop environments like Gnome. Bash in particular will read `/etc/profile` and then one of the scripts located on the home directory, following a priority list.

On the other hand `/etc/bash.bashrc` and `/etc/.bashrc` are scripts for interactive shells. These will get invoked when a new interactive shell is started, that is for example when starting a new terminal application.

## How VraiShell works?

VraiShell is a simple plugin based framework for startups scripts. It allows you to provide sections of the aforementioned scripts and ensures each set of scripts get invoked for the appropiate shell type regardless of the kind of shell (ie: you can still have generic logic for `.profile` but Bash specific logic on `.bash_profile`).

Just place (ex: checkout the git repository) on the `plugins` folder, ensure they contain at least one of: `bash_profile.d`, `profile.d`, `bashrc.d`. This will make it so they are loaded when the appropiate setup script gets invoked.

## How can I make these apply on new terminal emulator (ie: Gnome terminal) sessions?

The terminal emulator by default may be starting a new *interactive **non-login** shell*. That means that `*bashrc*` scripts get executed but not the `*profile*` ones. You must change the configuration of the terminal emulator so it starts new sessions as a login shell.

## What goes where?

Here's an heuristic to define what goes where:

1. If it's also going to be needed for other shells (like `/bin/sh` or a desktop environment), place it on `profile.d`.
2. If it's bash specific it goes on either `bash_profile.d` or `bashrc.d`.
3. If it should run only on Bash login, goes to `bash_profile.d`.
4. If it's for an interactive environment goes to `bashrc.d`.
  - This is regardless if the shell is a login shell, as this gets loaded automatically by `.bash_profile`.

## Installation

```shell
SCRATCH_DIR=$(mktemp -d)
BRANCH=master

wget --output-document="$SCRATCH_DIR"/"$BRANCH".zip https://github.com/Vraiment/vraishell/archive/refs/heads/"$BRANCH".zip && \
    unzip "$SCRATCH_DIR"/"$BRANCH".zip -d "$SCRATCH_DIR" && \
    mkdir --parents "$HOME"/.local/src && \
    mv --interactive --no-target-directory --backup=numbered "$SCRATCH_DIR"/vraishell-"$BRANCH" "$HOME"/.local/src/vraishell && \
    "$HOME"/.local/src/vraishell/install.sh
```

## Validation

These shell scripts use [`shellcheck`](https://www.shellcheck.net) to validate correctness as much as possible. Just run `./validate.sh` to run ShellCheck against all relevant scripts. Adding a new folder at the oot will require updating this file.
