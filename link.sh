#!/bin/sh

#ln -sf ~/dotfiles/.emacs ~/.emacs
ln -sf ~/dotfiles/emacs_init.el ~/.emacs.d/init.el

for init_file in ~/dotfiles/emacs_inits/*.el
do
    ln -sf $init_file ~/.emacs.d/inits/
done

ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.screenrc ~/.screenrc
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/sshconfig ~/.ssh/config
