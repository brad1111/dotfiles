#!/usr/bin/env bash
DOTSURL=git@github.com:brad1111/dotfiles

# check if git exists
if ! type git > /dev/null; then
    echo "Please install git"
    exit
fi

if ! type ssh-keygen > /dev/null; then
    echo "Please install openssh"
    exit
fi

ssh git@github.com 2>&1 | grep Hi
if [[ $? != 0 ]]; then
    echo "Please add your ssh key to github---"
    if [[ -f "$HOME/.ssh/id_rsa.pub" ]]; then
        cat "$HOME/id_rsa.pub"
    else 
        echo "Generating key with ssh-keygen"
        ssh-keygen -f "$HOME/.ssh/id_rsa"
        echo "SSH key to copy:"
        cat "$HOME/.ssh/id_rsa.pub"
    fi
    exit
fi

mkdir -p "$HOME/src"
git clone --bare "$DOTSURL" "$HOME/src/dotfiles"
git --git-dir="$HOME/src/dotfiles" --work-tree="$HOME" checkout
