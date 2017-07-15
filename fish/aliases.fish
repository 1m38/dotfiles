# alias ls 'ls -F --color=tty'
alias cp 'cp -i'
alias mv 'mv -i'
alias rm 'rm -i'
alias j jumanpp
alias jk 'jumanpp | knp'
alias sort 'LANG=C sort'
alias uniq 'LANG=C uniq'

# history

# # '...RET'で階層を2つ上がる
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'

alias ssh-addk 'ssh-add ~/.ssh/k2l.id_ecdsa'

# emacsclient
alias e 'emacsclient -c -t -a ""'
alias killemacs 'emacsclient -e "(kill-emacs)"'
alias restartemacs 'killemacs; e'

# pbcopy / cpfile
if builtin command -v pbcopy > /dev/null
	function cpfile
		cat $argv | pbcopy
	end
else if builtin command -v xsel > /dev/null
	alias pbcopy='xsel --clipboard --input'
	function cpfile
		cat $argv | xsel --clipboard --input
	end
end

# tmux(baracuda/moss)
builtin command -v tmux > /dev/null
if [ $status -ne 0 -a -f /mnt/orange/brew/data/bin/tmux ]
	alias tmux /mnt/orange/brew/data/bin/tmux
end

alias t 'tmux attach; or tmux new-session'
alias tls 'tmux ls'

