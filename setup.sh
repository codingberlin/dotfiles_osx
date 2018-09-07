#!/usr/bin/env bash
set -u -e -E -C -o pipefail

mkdir -p ~/bin

brew tap caskroom/fonts
brew bundle -v --file=brewfile

ln -s -f $(grealpath ./shell/vimrc) ~/.vimrc
ln -s -f $(grealpath ./shell/zshrc) ~/.zshrc
ln -s -f $(grealpath ./shell/tmux.conf) ~/.tmux.conf
ln -s -f $(grealpath ./shell/ideavimrc) ~/.ideavimrc
ln -s -f $(grealpath ./shell/gitconfig) ~/.gitconfig

