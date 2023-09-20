# vraishell
-----------

This is a personal shell setup configuration. It comes out of the box with some handy bash functions and environment variables. There's also a set of directories to configure aliases, environment variables and the `PATH` environment variable.

There are a couple of environment that are set:

- `VRAI_SHELL_INIT`: Lists what files have been invoked for setup and in what order.
- `VRAI_SHELL_DIR`: The location where the shell setup files are.

## Installation

```shell
mkdir -p $HOME/.local/etc
git clone git@github.com:Vraiment/vraishell.git $HOME/.local/etc/vraishell

# Backup original files
mv $HOME/.bashrc $HOME/.bashrc_original
mv $HOME/.bash_profile $HOME/.bashrc_profile_original
mv $HOME/.profile $HOME/.profile_original

# Crate links to the files from vraishell
ln -s $HOME/.local/etc/vraishell/bashrc.sh $HOME/.bashrc
ln -s $HOME/.local/etc/vraishell/profile.sh $HOME/.profile
```
