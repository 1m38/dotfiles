#!/bin/sh

if [ ! -d ~/.emacs.d ]; then
    mkdir -p ~/.emacs.d
fi
ln -sf ~/dotfiles/emacs_init.el ~/.emacs.d/init.el
ln -sf ~/dotfiles/emacs_inits ~/.emacs.d/inits

ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.screenrc ~/.screenrc
ln -sf ~/dotfiles/.zshrc ~/.zshrc
# ln -sf ~/dotfiles/.zlogout ~/.zlogout
ln -sf ~/dotfiles/sshconfig ~/.ssh/config
ln -sf ~/dotfiles/.vimrc ~/.vimrc
