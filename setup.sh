#!/usr/bin/env bash
set -u -e -E -C -o pipefail

USE_BREW=true
brew update >/dev/null 2>&1 || USE_BREW=false 

# https://github.com/Homebrew/brew/issues/2491
function brew_install_or_upgrade {
	brew bundle -v --file=- <<-EOS
		brew "$1"
	EOS
}

if [ "$USE_BREW" = true ]; then
  which brew || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update
  INSTALL_COMMAND="brew_install_or_upgrade"
  REALPATH_COMMAND="grealpath"
  $INSTALL_COMMAND coreutils
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
$INSTALL_COMMAND rust
$INSTALL_COMMAND fzf

git submodule update --init --recursive
if ! [ -f ~/.vim/autoload/plug.vim ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

[[ -f ~/.cargo/bin/dotcopter ]] || cargo install dotcopter
~/.cargo/bin/dotcopter dotcopter.yaml -f apply

if [ "$USE_BREW" = false ]; then
  $INSTALL_COMMAND aws-cli
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
  pip3 install awscli --upgrade --user
  # https://stackoverflow.com/questions/13762280/zsh-compinit-insecure-directories/22753363
  sudo chmod -R 755 /usr/local/share/zsh
  sudo chown -R root:staff /usr/local/share/zsh
fi

### zsh
ln -sf $($REALPATH_COMMAND ./shell/profile) ~/.profile

### nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install node

