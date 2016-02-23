#!/usr/bin/env bash
set -u -e -E -C -o pipefail

brew install wget
brew install coreutils
brew install zsh
brew install tmux

ln -sf $(grealpath ./shell/profile) ~/.profile
ln -sf $(grealpath ./shell/tmux.conf) ~/.tmux.conf
ln -sf $(grealpath ./shell/zshrc.local) ~/.zshrc.local
ln -sf $(grealpath ./shell/vimrc) ~/.vimrc
ln -sf $(grealpath ./shell/zshrc) ~/.zshrc

