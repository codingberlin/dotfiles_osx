#!/usr/bin/env bash
set -u -e -E -C -o pipefail

USE_BREW=true
brew update >/dev/null 2>&1 || USE_BREW=false 

if [ "$USE_BREW" = true ]; then
  which brew || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update
  brew install coreutils
  INSTALL_COMMAND="brew install"
  REALPATH_COMMAND="grealpath"
fi

if [ "$USE_BREW" = false ]; then
  INSTALL_COMMAND="sudo pacman -S --needed --noconfirm"
  REALPATH_COMMAND="realpath"
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
$INSTALL_COMMAND aws-cli
$INSTALL_COMMAND fzf
$INSTALL_COMMAND npm

git submodule update --init --recursive
if ! [ -f ~/.vim/autoload/plug.vim ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

[[ -f ~/.cargo/bin/dotcopter ]] || cargo install dotcopter
~/.cargo/bin/dotcopter dotcopter.yaml apply

if [ "$USE_BREW" = false ]; then
  $INSTALL_COMMAND scrot
  $INSTALL_COMMAND hub
  $INSTALL_COMMAND arandr
  $INSTALL_COMMAND dmenu
  $INSTALL_COMMAND i3
  $INSTALL_COMMAND i3lock
  $INSTALL_COMMAND i3status
  $INSTALL_COMMAND network-manager-applet 
  $INSTALL_COMMAND chromium
  $INSTALL_COMMAND docker
  $INSTALL_COMMAND docker-compose
  yaourt -S --noconfirm aura
  sudo aura -A --noconfirm intellij-idea-ultimate-edition
fi

if [ "$USE_BREW" = true ]; then
  # https://stackoverflow.com/questions/13762280/zsh-compinit-insecure-directories/22753363
  sudo chmod -R 755 /usr/local/share/zsh
  sudo chown -R root:staff /usr/local/share/zsh
fi

### zsh
ln -sf $($REALPATH_COMMAND ./shell/profile) ~/.profile
ln -sf $($REALPATH_COMMAND ./shell/zshrc) ~/.zshrc
ln -sf $($REALPATH_COMMAND ./shell/zshrc.local) ~/.zshrc.local
ln -sf $($REALPATH_COMMAND ./shell/ideavimrc) ~/.ideavimrc

ln -sf $($REALPATH_COMMAND ./shell/tmux.conf) ~/.tmux.conf

ln -sf $($REALPATH_COMMAND ./shell/vimrc) ~/.vimrc
ln -sf $($REALPATH_COMMAND ./shell/gitconfig) ~/.gitconfig

if ! [ -d ~/bin ]; then
  mkdir ~/bin
fi
ln -sf $($REALPATH_COMMAND ./git-radar/git-radar) ~/bin/git-radar

### nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
