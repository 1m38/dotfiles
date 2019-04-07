alias cp 'cp -i'
alias mv 'mv -i'
alias rm 'rm -i'

alias sort 'LANG=C sort'
alias uniq 'LANG=C uniq'

alias ipython 'ipython --colors=linux'
alias ipython2 'ipython2 --colors=linux'
alias ipython3 'ipython3 --colors=linux'

# '...RET'で階層を2つ上がる
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'

# tmux
alias t 'tmux attach; or tmux new-session'
alias tls 'tmux ls'

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
