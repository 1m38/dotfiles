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
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

# powerline
if [ -d ~/.local/lib/python*/site-packages/powerline ]; then
    ln -sf ~/.local/lib/python*/site-packages/powerline ~/.local/share/powerline
fi
if [ ! -d ~/.config ]; then
    mkdir ~/.config
fi
ln -sf ~/dotfiles/powerline ~/.config

ln -sf ~/dotfiles/.aspell.conf ~/.aspell.conf
