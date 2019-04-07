#!/bin/zsh

local -A opthash
zparseopts -D -A opthash -- -change-repo -no-change-repo

# emacs
if [[ ! -d ~/.emacs.d ]]; then
    mkdir -p ~/.emacs.d
fi
ln -sf ~/dotfiles/emacs_init.el ~/.emacs.d/init.el
ln -sf ~/dotfiles/emacs_inits ~/.emacs.d/inits

# git
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
# screen
ln -sf ~/dotfiles/.screenrc ~/.screenrc
# zsh
ln -sf ~/dotfiles/.zshrc ~/.zshrc

# ssh
mkdir -p ~/.ssh
ln -sf ~/dotfiles/sshconfig ~/.ssh/config

# vim
ln -sf ~/dotfiles/.vimrc ~/.vimrc
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
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

# aspell
ln -sf ~/dotfiles/.aspell.conf ~/.aspell.conf
# latex
ln -sf ~/dotfiles/.latexmkrc ~/.latexmkrc
# flake8
ln -sf ~/dotfiles/.flake8 ~/.flake8

# fish
mkdir -p ~/.config
ln -sf ~/dotfiles/fish ~/.config/fish

# dotfilesへのURL変更
function change-repo-url() {
    cd `dirname $1`
    git remote set-url origin github:1m38/dotfiles.git
}

if [[ -n "${opthash[(i)--change-repo]}" ]]; then
    change-repo-url $0
elif [[ ! -n "${opthash[(i)--no-change-repo]}" ]]; then
    read Answer\?"dotfiles リポジトリのremote URLを変更しますか [Y/n] "
    case $Answer in
	[yY]*|'')
	    change-repo-url $0
	    ;;
    esac
fi
