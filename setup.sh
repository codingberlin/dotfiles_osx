#!/usr/bin/env bash
set -u -e -E -C -o pipefail

brew install wget
brew install coreutils
brew install zsh
brew install tmux
brew install tree
brew install --with-cocoa emacs
brew install aspell
brew install hunspell
brew install sbt
brew install ag

ln -sf $(grealpath ./shell/profile) ~/.profile
ln -sf $(grealpath ./shell/tmux.conf) ~/.tmux.conf
ln -sf $(grealpath ./shell/zshrc.local) ~/.zshrc.local
ln -sf $(grealpath ./shell/vimrc) ~/.vimrc
ln -sf $(grealpath ./shell/zshrc) ~/.zshrc
ln -sf $(grealpath ./shell/gitconfig) ~/.gitconfig

