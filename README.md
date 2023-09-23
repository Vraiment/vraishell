# vraishell
-----------

This is a personal shell setup configuration. It comes out of the box with some handy bash functions and environment variables. There's also a set of directories to configure aliases, environment variables and the `PATH` environment variable.

There are a couple of environment that are set:

- `VRAI_SHELL_INIT`: Lists what files have been invoked for setup and in what order.
- `VRAI_SHELL_DIR`: The location where the shell setup files are.

## Installation

```shell
SCRATCH_DIR=$(mktemp -d)
BRANCH=master

wget -O "$SCRATCH_DIR"/"$BRANCH".zip https://github.com/Vraiment/vraishell/archive/refs/heads/"$BRANCH".zip && \
    unzip "$SCRATCH_DIR"/"$BRANCH".zip -d "$SCRATCH_DIR" && \
    mkdir -p "$HOME"/.local/src && \
    mv -i -T --backup=t "$SCRATCH_DIR"/vraishell-"$BRANCH" "$HOME"/.local/src/vraishell && \
    "$HOME"/.local/src/vraishell/install.sh
```

## Validation

These shell scripts use [`shellcheck`](https://www.shellcheck.net) to validate correctness as much as possible. Just run `./validate.sh` to run ShellCheck against all relevant scripts. Adding a new folder at the oot will require updating this file.
