#!/usr/bin/env bash
set -u -e -E -C -o pipefail


cd /usr/local/share/
sudo chmod -R 755 zsh
sudo chown -R root:staff zsh
cd -

git submodule update --init --recursive
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" || true
brew update
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
brew install tig

if ! [ -d ~/bin ]; then
  mkdir ~/bin
fi

ln -sf $(grealpath ./shell/profile) ~/.profile
ln -sf $(grealpath ./shell/tmux.conf) ~/.tmux.conf
ln -sf $(grealpath ./shell/zshrc.local) ~/.zshrc.local
ln -sf $(grealpath ./shell/vimrc) ~/.vimrc
ln -sf $(grealpath ./shell/zshrc) ~/.zshrc
ln -sf $(grealpath ./shell/gitconfig) ~/.gitconfig
ln -sf $(grealpath ./git-radar/git-radar) ~/bin/git-radar

git config --global alias.lg "log --all --decorate --oneline --graph"

