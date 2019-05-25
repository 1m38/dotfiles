alias cp 'cp -i'
alias mv 'mv -i'
alias rm 'rm -i'

alias sort 'LANG=C sort'
alias uniq 'LANG=C uniq'

alias ipython 'ipython --colors=linux'
alias ipython2 'ipython2 --colors=linux'
alias ipython3 'ipython3 --colors=linux'

# python3を使う
if command --search python3 > /dev/null
    alias python 'python3'
    alias pip 'pip3'
end

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

# ls automatically after cd
# ref: https://blog.matzryo.com/entry/2018/09/02/cd-then-ls-with-fish-shell
functions --copy cd standard_cd
function cd
    standard_cd $argv; and ls
end

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
