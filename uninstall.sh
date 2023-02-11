#!/bin/bash

echo "Remove .bashrc from the home dir"
rm -f "$HOME/.bashrc"

echo "Remove .profile from the home dir"
rm -f "$HOME/.profile"

echo "Remove config dir"
rm -rf "$HOME/.local/etc/vraishell"
