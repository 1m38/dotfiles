set user_paths $HOME/usr/bin $HOME/bin $HOME/local/bin $HOME/.local/bin
set system_paths /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
set LANG ja_JP.UTF-8
set --export EDITOR emacsclient

# linuxbrew / homebrew(local)
if [ -d $HOME/.linuxbrew ]
	set system_paths $HOME/.linuxbrew/bin $system_paths
	#     export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
	#     export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
else if [ -d /usr/local/Homebrew ]
	#     export MANPATH=/usr/local/share/man:${MANPATH}
	# coreutils
	if [ -d /usr/local/opt/coreutils ]
		set system_paths /usr/local/opt/coreutils/libexec/gnubin $system_paths
		# 	export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}
	end
end

# kuro-lab_cluster: GPU / linuxbrew
if [ -f /usr/local/cuda/bin/nvcc ]
	set --export LD_LIBRARY_PATH $LD_LIBRARY_PATH /usr/local/cuda/lib64
	set --export CUDA_HOME /usr/local/cuda
	set system_paths /usr/local/cuda/bin $system_paths
else if [ -f /mnt/orange/brew/brew.zsh ]
	# /orange/brew
	. /mnt/orange/brew/brew.sh
end

# loadaverage(OSごとの設定)
# http://yonchu.hatenablog.com/entry/20120414/1334422075
if [ -d $HOME/dotfiles/bin ]
	set user_paths $user_paths $HOME/dotfiles/bin
end

# OS,hostごとの設定
# mac: TeX Live
switch (uname)
	case 'darwin*'		# mac
		# TeX Live
		set --export _TeXPATH /usr/local/texlive/2016/bin/x86_64-darwin
		if [ -d  $_TeXPATH ]
			PATH=$PATH:$_TeXPATH
		end
	case '*'
end

set -U fish_user_paths $user_paths $system_paths $fish_user_paths
