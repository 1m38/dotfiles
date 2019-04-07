#!/bin/zsh

local -A opthash
zparseopts -D -A opthash -- -change-repo -no-change-repo

SCRIPT_DIR=$(dirname $0)

# emacs
if [[ ! -d ~/.emacs.d ]]; then
    mkdir -p ~/.emacs.d
fi
ln -sf $SCRIPT_DIR/emacs_init.el ~/.emacs.d/init.el
ln -sf $SCRIPT_DIR/emacs_inits ~/.emacs.d/inits

# git
ln -sf $SCRIPT_DIR/.gitconfig ~/.gitconfig
# screen
ln -sf $SCRIPT_DIR/.screenrc ~/.screenrc
# zsh
ln -sf $SCRIPT_DIR/.zshrc ~/.zshrc

# ssh
mkdir -p ~/.ssh
ln -sf $SCRIPT_DIR/sshconfig ~/.ssh/config

# vim
ln -sf $SCRIPT_DIR/.vimrc ~/.vimrc
if [[ ! -d ~/.vimbackup ]]; then
    mkdir -p ~/.vimbackup
fi
if [[ ! -d ~/.vim ]]; then
    # install vim-plug
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	 https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# neovim
if [[ ! -d ~/.config ]]; then
    mkdir -p ~/.config
fi
ln -sf ~/.vim ~/.config/nvim
ln -sf ~/.vimrc ~/.config/nvim/init.vim

# tmux
ln -sf $SCRIPT_DIR/.tmux.conf ~/.tmux.conf

# aspell
ln -sf $SCRIPT_DIR/.aspell.conf ~/.aspell.conf
# latex
ln -sf $SCRIPT_DIR/.latexmkrc ~/.latexmkrc
# flake8
ln -sf $SCRIPT_DIR/.flake8 ~/.flake8

# fish
mkdir -p ~/.config
ln -sf $SCRIPT_DIR/fish ~/.config/fish

# dotfiles repoへのURL変更
function change-repo-url() {
    cd $SCRIPT_DIR
    git remote set-url origin github:1m38/dotfiles.git
}

if [[ -n "${opthash[(i)--change-repo]}" ]]; then
    change-repo-url $0
elif [[ ! -n "${opthash[(i)--no-change-repo]}" ]]; then
    read Answer\?"dotfiles リポジトリのremote URLを変更しますか [Y/n] "
    case $Answer in
	[yY]*|'')
	    change-repo-url
	    ;;
    esac
fi
