#!/usr/bin/env bash
set -u -e -E -C -o pipefail

brew install wget
brew install coreutils
brew install zsh
brew install tmux

ln -sf $(grealpath ./profile) ~/.profile
ln -sf $(grealpath ./tmux.conf) ~/.tmux.conf
ln -sf $(grealpath ./zshrc.local) ~/.zshrc.local
ln -sf $(grealpath ./vimrc) ~/.vimrc
ln -sf $(grealpath ./zshrc) ~/.zshrc

