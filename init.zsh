#!/bin/zsh

if [[ ! -d ~/.emacs.d ]]; then
    mkdir -p ~/.emacs.d
fi
ln -sf ~/dotfiles/emacs_init.el ~/.emacs.d/init.el
ln -sf ~/dotfiles/emacs_inits ~/.emacs.d/inits

ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.screenrc ~/.screenrc
ln -sf ~/dotfiles/.zshrc ~/.zshrc
# hostごとの設定
case $OSTYPE in
    linux*)
	if [[ `hostname -d` = "lang-private.kuee.kyoto-u.ac.jp" ]]; then
	    # sshconfig: 研究室内ではlocal鍵を使う
	    ln -sf ~/dotfiles/sshconfig_k2l ~/.ssh/config
	    # gxprc
	    ln -sf ~/dotfiles/gxprc ~/gxprc
	else
	    ln -sf ~/dotfiles/sshconfig ~/.ssh/config
	fi
	;;
    *)
	ln -sf ~/dotfiles/sshconfig ~/.ssh/config
	;;
esac
ln -sf ~/dotfiles/.vimrc ~/.vimrc
if [[ ! -d ~/.vimbackup ]]; then
    mkdir -p ~/.vimbackup
fi
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

ln -sf ~/dotfiles/.aspell.conf ~/.aspell.conf
ln -sf ~/dotfiles/.latexmkrc ~/.latexmkrc
