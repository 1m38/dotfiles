# .zshrc

_MYPATH=$HOME/usr/bin
_SYSPATH=/usr/local/bin:/usr/X11R6/bin:/sbin:/bin:/usr/sbin:/usr/bin

case $CPUTYPE in
x86_64)
    _CPUPATH=/share/usr-x86_64/bin
    ;;
i686)
    _CPUPATH=/share/usr/bin
    ;;
esac

PATH=$_MYPATH:$_CPUPATH:$_SYSPATH
unset _MYPATH _CPUPATH _SYSPATH

#PROMPT="[%m-(%~)] % "
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=$HOME/.zsh_history
WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

export LANG=ja_JP.UTF-8
export EDITOR=emacsclient
export LS_COLORS=':no=00:fi=00:di=36:ln=35:pi=33:so=32:bd=34;46:cd=34;43:ex=31:'
export PERL5LIB=$HOME/usr/lib/perl
export CVSROOT=reed:/share/service/cvs
export CVS_RSH=ssh
export XMODIFIERS="@im=kinput2"

export TEXINPUTS=.:$HOME/TeX/inputs//:
export BIBINPUTS=.:$HOME/TeX/inputs//:
export BSTINPUTS=.:$HOME/TeX/inputs//:

# options
setopt auto_cd
setopt auto_param_slash
setopt auto_pushd
setopt auto_remove_slash
setopt extended_glob
setopt function_argzero
setopt ignore_eof
setopt list_types
setopt pushd_ignore_dups
setopt pushd_silent
setopt pushd_to_home
setopt sun_keyboard_hack
setopt print_eight_bit
setopt complete_in_word
setopt no_nomatch
setopt share_history
setopt extended_history
setopt nohup
setopt hist_ignore_dups
setopt hist_reduce_blanks

unsetopt promptcr

# aliases
alias ls='ls -F --color=tty'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias h='history'
alias -g L='| lv'
alias -g H='| head'
alias -g T='| tail'
alias -g W='| wc'
alias -g G='| grep'
alias gomi='rm -f *~'
alias cpan='perl -MCPAN -e shell'
alias j='juman -e2 -B'
alias jk='juman -e2 -B | knp'

# completion
autoload -U compinit
compinit

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# bindkey
bindkey -e
# bindkey "^[f" emacs-forward-word
# bindkey "^[b" emacs-backward-word

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
# bindkey "^[p" history-beginning-search-backward-end
# bindkey "^[n" history-beginning-search-forward-end

autoload replace-string
zle -N replace-string
bindkey "^[%" replace-string

if [ "$EMACS" = t ]; then
    unsetopt zle
    stty -echo
    alias ls='ls -F --color'
fi


#====== 個人設定 ======

# '...RET'で階層を2つ上がる
alias ...='cd ../..'
alias ....='cd ../../..'

# cdした先のディレクトリをスタックに追加 'cd -<TAB>'で履歴表示
setopt auto_pushd
setopt pushd_ignore_dups

# 間違ったcommandを修正してくれる
setopt correct

# PROMPT設定
if [ "$EMACS" = t ]; then
    # emacs_shellの場合は左プロンプトを簡略化
    PROMPT="[%2~]%# "
else
    PROMPT="[%m-(%~)]%# "
fi

# 時刻表示
RPROMPT="[%*]"

# rbenv 設定
if [[ -d $HOME/.rbenv ]] then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

# $HOME/local/bin をPATHに追加
export PATH="$HOME/local/bin:$PATH"

# ssh-add alias
alias ssh-addk='ssh-add ~/.ssh/k2l.id_rsa'
alias ssh-addb='ssh-add ~/.ssh/bitbucket.uno1038.id_rsa'
alias ssh-addb2='ssh-add ~/.ssh/bitbucket.fs_lt34.id_rsa'
alias eval-ssh-agent='eval `ssh-agent`'

# ulimit (hostごとに変更)
case `hostname -s` in
    masaya-*|FS-*)
	# 3GB
	ulimit -m 3000000
	;;
    basil300|basil301|basil302|jungle)
	# 128GB
	ulimit -m 128000000
	ulimit -v 128000000
	;;
    basil*)
	# 10GB
	ulimit -m 10000000
	ulimit -v 10000000
	;;
    *)
	# 3GB
	ulimit -m 3000000
	ulimit -v 3000000
	;;
esac

# 実験環境
alias kyotoebmt_server="nice -n 19 ~/kyotoebmt/parse_tools/src/parse_server.pl --port 13351 --n_best_num 1"
alias kyotoebmt_client='nice -n 19 ~/kyotoebmt/bin/KyotoEBMT -c ~/kyotoebmt.ini --input_filter_type 2 --input_threshold 50 --nb_threads 10 --parse_command "echo \"%SENTENCE%\" | ~/kyotoebmt/parse_tools/src/parse_client.pl --lang ja --port 13351" --input_mode plain'
alias klm_query="nice -n 19 /share/tool/MT/tool/kenlm/bin/query ~/mt_pre/ems_test/lm/ja"
if [[ -d $HOME/svm_rank ]] then
   alias svm-rank-learn="~/svm_rank/svm_rank_learn"
   alias svm-rank-classify="~/svm_rank/svm_rank_classify"
fi

# sort,uniq にはLANG=Cをつける
alias sort='LANG=C sort'
alias uniq='LANG=C uniq'

# コマンドの実行が終わったらメール
function rep_mail (){
    subj="report mail:`hostname -s`"
    mail_from="uno@nlp.ist.i.kyoto-u.ac.jp"
    mail_to="uno@nlp.ist.i.kyoto-u.ac.jp"

    cmd=$@
    text="\"$cmd\" \n 開始 `date \"+%m/%d %H:%M\"` \n"

    trap "ssh lotus \"echo -e \\\" $text 強制終了 `date \"+%m/%d %H:%M\"` \\\" | mail -s \\\"${subj}\\\" ${mail_to} -- -f ${mail_from}\" ;trap INT  EXIT ERR;" INT
    trap "ssh lotus \"echo -e \\\" $text 異常終了 `date \"+%m/%d %H:%M\"` \\\" | mail -s \\\"${subj}\\\" ${mail_to} -- -f ${mail_from}\" ;trap INT  EXIT ERR;" ERR
    trap "ssh lotus \"echo -e \\\" $text 正常終了 `date \"+%m/%d %H:%M\"` \\\" | mail -s \\\"${subj}\\\" ${mail_to} -- -f ${mail_from}\" ;trap INT  EXIT ERR;" EXIT
    nice -19 $@
}

# cd時にlsする
# http://qiita.com/yuyuchu3333/items/b10542db482c3ac8b059
chpwd() {
    ls_abbrev
}
ls_abbrev() {
    if [[ ! -r $PWD ]]; then
        return
    fi
    # -a : Do not ignore entries starting with ..
    # -C : Force multi-column output.
    # -F : Append indicator (one of */=>@|) to entries.
    local cmd_ls='ls'
    local -a opt_ls
    opt_ls=('-aCF' '--color=always')
    case "${OSTYPE}" in
        freebsd*|darwin*)
            if type gls > /dev/null 2>&1; then
                cmd_ls='gls'
            else
                # -G : Enable colorized output.
                opt_ls=('-aCFG')
            fi
            ;;
    esac

    local ls_result
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

    if [ $ls_lines -gt 10 ]; then
        echo "$ls_result" | head -n 5
        echo '...'
        echo "$ls_result" | tail -n 5
        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
        echo "$ls_result"
    fi
}

# [xk]term/screenで実行時、タイトルを設定する
case "${TERM}" in
    # [xk]term: user@hostname
    kterm*|xterm)
	precmd() {
	    echo -ne "\033]0;${USER}@${HOST%%.*}\007"
	}
	;;
    # screen: 実行コマンド
    screen)
	if [[ "$TMUX" == "" ]]; then
	    # コマンド実行前: 実行されたコマンドをタイトルに設定
	    preexec() {
		echo -ne "\ek${1%%.*}\e\\"
	    }
	    # プロンプト表示前: sh名を設定
	    precmd() {
		echo -ne "\ek$(basename ${0%%.*})\e\\"
	    }
	fi
	;;
esac

# コマンド実行時にプロンプトをリセット(RPROMPTの時刻を更新)
re-prompt() {
    zle .reset-prompt
    zle .accept-line
}
zle -N accept-line re-prompt

# PARA
export PARA_SYSTEM=$HOME/PARA

# emacsclient
alias emacs='emacsclient -c -t -a ""'
alias e='emacsclient -c -t -a ""'
alias killemacs='emacsclient -e "(kill-emacs)"'

# screen
alias s='screen -xR'

# Ubuntu terminalなどVTE環境での一部全角記号ズレ軽減
VTE_CJK_WIDTH=1

# tmux
export TERM=xterm-256color
alias t='tmux attach || tmux new-session'
alias tls='tmux ls'
# 研究室鯖用alias
if [[ `hostname -s` == basil* || `hostname -s` == jungle ]]; then
    alias tmux='LD_PRELOAD=/lib64/libncurses.so.5 tmux'
    alias t='LD_PRELOAD=/lib64/libncurses.so.5 tmux attach || tmux new-session'
fi
# htopをscreenで起動する
if [ "$TMUX" = "" ]; then
    unalias htop 2>/dev/null
else
    alias htop='screen htop'
fi
# hostnameの色を変更
if [ "$TMUX" != "" ]; then
    case `hostname -s` in
	masaya-*|FS-*)
	    tmux_hostname_color="fg=black,bg=colour202"
	    ;;
	basil*|jungle)
	    tmux_hostname_color="fg=white,bg=colour22"
	    ;;
	*)
	    tmux_hostname_color="fg=colour22,bg=colour250"
	    ;;
    esac
    tmux set-option -g status-left "#[fg=colour234,bg=colour250]#{?client_prefix,#[bg=colour118],}[#S]#[$tmux_hostname_color] #h #[default] "
fi

# torch(ローカルマシン用)
if [ -d /home/masaya/torch ]; then
    . /home/masaya/torch/install/bin/torch-activate
fi

# SSH_AUTH_SOCK固定
# Reference: http://unix.stackexchange.com/a/76256/91598
SOCK="/tmp/ssh-agent-$USER-screen"
if ! test $SSH_AUTH_SOCK
then
    eval `ssh-agent`
fi
if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $SOCK ]
then
    rm -f /tmp/ssh-agent-$USER-screen
    ln -sf $SSH_AUTH_SOCK $SOCK
    export SSH_AUTH_SOCK=$SOCK
fi
