#!/bin/sh

if [ ! -d ~/.emacs.d ]; then
    mkdir -p ~/.emacs.d
fi
ln -sf ~/dotfiles/emacs_init.el ~/.emacs.d/init.el
ln -sf ~/dotfiles/emacs_inits ~/.emacs.d/inits

ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.screenrc ~/.screenrc
ln -sf ~/dotfiles/.zshrc ~/.zshrc
# hostごとの設定
if [ `hostname -d` = "lang-private.kuee.kyoto-u.ac.jp" ]; then
    # sshconfig: 研究室内ではlocal鍵を使う
    ln -sf ~/dotfiles/sshconfig_k2l ~/.ssh/config
    # gxprc
    ln -sf ~/dotfiles/gxprc ~/gxprc
else
    ln -sf ~/dotfiles/sshconfig ~/.ssh/config
fi
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
