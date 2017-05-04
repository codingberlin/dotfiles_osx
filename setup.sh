#!/usr/bin/env bash
set -u -e -E -C -o pipefail

USE_BREW=true
brew update >/dev/null 2>&1 || USE_BREW=false 

if [ "$USE_BREW" = true ]; then
  which brew || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update
  brew install coreutils
  INSTALL_COMMAND="brew install"
fi

if [ "$USE_BREW" = false ]; then
  INSTALL_COMMAND="sudo pacman -S --needed --noconfirm"
fi

$INSTALL_COMMAND vim
$INSTALL_COMMAND wget
$INSTALL_COMMAND zsh
$INSTALL_COMMAND tmux
$INSTALL_COMMAND tree
$INSTALL_COMMAND aspell
$INSTALL_COMMAND hunspell
$INSTALL_COMMAND sbt
$INSTALL_COMMAND tig
$INSTALL_COMMAND cargo

git submodule update --init --recursive
if ! [ -f ~/.vim/autoload/plug.vim ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

[[ -f ~/.cargo/bin/dotcopter ]] || cargo install dotcopter
~/.cargo/bin/dotcopter dotcopter.yaml apply

if [ "$USE_BREW" = false ]; then
  $INSTALL_COMMAND scrot
  $INSTALL_COMMAND hub
fi

if [ "$USE_BREW" = true ]; then
  # https://stackoverflow.com/questions/13762280/zsh-compinit-insecure-directories/22753363
  sudo chmod -R 755 /usr/local/share/zsh
  sudo chown -R root:staff /usr/local/share/zsh

### zsh
ln -sf $(grealpath ./shell/profile) ~/.profile
ln -sf $(grealpath ./shell/zshrc) ~/.zshrc
ln -sf $(grealpath ./shell/zshrc.local) ~/.zshrc.local
ln -sf $(grealpath ./shell/ideavimrc) ~/.ideavimrc

ln -sf $(grealpath ./shell/tmux.conf) ~/.tmux.conf

ln -sf $(grealpath ./shell/vimrc) ~/.vimrc
ln -sf $(grealpath ./shell/gitconfig) ~/.gitconfig

if ! [ -d ~/bin ]; then
  mkdir ~/bin
fi
ln -sf $(grealpath ./git-radar/git-radar) ~/bin/git-radar
fi
