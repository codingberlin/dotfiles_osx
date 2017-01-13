#!/usr/bin/env bash
set -u -e -E -C -o pipefail

#brew
which brew || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update

brew install wget
brew install coreutils

### zsh
brew install zsh
ln -sf $(grealpath ./shell/profile) ~/.profile
ln -sf $(grealpath ./shell/zshrc) ~/.zshrc
ln -sf $(grealpath ./shell/zshrc.local) ~/.zshrc.local
ln -sf $(grealpath ./shell/ideavimrc) ~/.ideavimrc
# https://stackoverflow.com/questions/13762280/zsh-compinit-insecure-directories/22753363
sudo chmod -R 755 /usr/local/share/zsh
sudo chown -R root:staff /usr/local/share/zsh

brew install tmux
ln -sf $(grealpath ./shell/tmux.conf) ~/.tmux.conf
brew install tree
brew install aspell
brew install hunspell
brew install sbt
brew install ag
brew install tig

ln -sf $(grealpath ./shell/vimrc) ~/.vimrc
ln -sf $(grealpath ./shell/gitconfig) ~/.gitconfig

### git radar
git submodule update --init --recursive
if ! [ -d ~/bin ]; then
  mkdir ~/bin
fi
ln -sf $(grealpath ./git-radar/git-radar) ~/bin/git-radar

### vim
if ! [ -f ~/.vim/autoload/plug.vim ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

