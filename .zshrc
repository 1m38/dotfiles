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

PATH=$_CPUPATH:$_SYSPATH
# /orange/brew (kuro-lab_cluster)
if [[ -f /mnt/orange/brew/brew.zsh ]]; then
    source /mnt/orange/brew/brew.zsh
fi
PATH=$_MYPATH:$PATH
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
# alias h='history'
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
autoload -U compinit && compinit
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select interactive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
setopt menu_complete


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

# rbenv 設定
if [[ -d $HOME/.rbenv ]]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

# $HOME/bin, $HOME/local/bin, $HOME/.local/bin をPATHに追加
export PATH="$HOME/bin:$HOME/local/bin:$HOME/.local/bin:$PATH"

# ssh-add alias
alias ssh-addk='ssh-add ~/.ssh/k2l.id_rsa'
alias ssh-addb='ssh-add ~/.ssh/bitbucket.uno1038.id_rsa'
alias ssh-addb2='ssh-add ~/.ssh/bitbucket.fs_lt34.id_rsa'
alias eval-ssh-agent='eval `ssh-agent`'

# 実験環境
KyotoEBMT_DIR=$HOME/tools/kyotoebmt
if [[ -d $KyotoEBMT_DIR ]]; then
    alias kyotoebmt_server="nice -n 19 $KyotoEBMT_DIR/parse_tools/src/parse_server.pl --port 13351 --n_best_num 1"
    alias kyotoebmt_client='nice -n 19 $KyotoEBMT_DIR/bin/KyotoEBMT -c ~/kyotoebmt.ini --input_filter_type 2 --input_threshold 50 --nb_threads 10 --parse_command "echo \"%SENTENCE%\" | $KyotoEBMT_DIR/parse_tools/src/parse_client.pl --lang ja --port 13351" --input_mode plain'
    alias klm_query="nice -n 19 /share/tool/MT/tool/kenlm/bin/query /windroot/uno/kyotoebmt_ems/lm/ja"
fi
if [[ -d $HOME/svm_rank ]]; then
   alias svm-rank-learn="~/svm_rank/svm_rank_learn"
   alias svm-rank-classify="~/svm_rank/svm_rank_classify"
fi
STP_DIR=$HOME/tools/stanford-parser-full-2015-04-20
if [[ -d $STP_DIR ]]; then
    alias stanford-parser="/share/usr-x86_64/bin/java -mx4000m -cp $STP_DIR/\* edu.stanford.nlp.parser.lexparser.LexicalizedParser -tokenized -maxLength 200 -outputFormat penn,typedDependencies -escaper edu.stanford.nlp.process.PTBEscapingProcessor -sentences newline edu/stanford/nlp/models/lexparser/englishRNN.ser.gz -"
fi
STCore_DIR=$HOME/tools/stanford-corenlp-full-2015-12-09
if [[ -d $STCore_DIR ]]; then
    alias stanford-corenlp="/share/usr-x86_64/bin/java -Xmx5g -cp $STCore_DIR/\* edu.stanford.nlp.pipeline.StanfordCoreNLP -annotators tokenize,ssplit,pos,lemma,ner,parse,dcoref,depparse -ssplit.eolonly true"
    alias stanford-corenlp-zh="/share/usr-x86_64/bin/java -Xmx5g -cp $STCore_DIR/\* edu.stanford.nlp.pipeline.StanfordCoreNLP -props StanfordCoreNLP-chinese.properties"
fi

# sort,uniq にはLANG=Cをつける
alias sort='LANG=C sort'
alias uniq='LANG=C uniq'

# history
alias h='history -i'
alias histgrep='history -i 1 | grep --color=auto'

# コマンドの実行が終わったらメール
function rep_mail (){
    subj="report mail:`hostname -s`"
    mail_from="uno@nlp.ist.i.kyoto-u.ac.jp"
    mail_to="uno@nlp.ist.i.kyoto-u.ac.jp"

    cmd=$@
    start_time=`date "+%m/%d %H:%M:%S"`
    text="$cmd \n 開始 $start_time \n"

    trap "ssh lotus \"echo -e \\\" $text 強制終了 \\\" | mail -s \\\"${subj}\\\" ${mail_to} -- -f ${mail_from}\" ;trap INT  EXIT ERR;" INT
    trap "ssh lotus \"echo -e \\\" $text 異常終了 \\\" | mail -s \\\"${subj}\\\" ${mail_to} -- -f ${mail_from}\" ;trap INT  EXIT ERR;" ERR
    trap "ssh lotus \"echo -e \\\" $text 正常終了 \\\" | mail -s \\\"${subj}\\\" ${mail_to} -- -f ${mail_from}\" ;trap INT  EXIT ERR;" EXIT
    $@
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

# emacsclient
alias e='emacsclient -c -t -a ""'
alias killemacs='emacsclient -e "(kill-emacs)"'
alias restartemacs='killemacs; e'

# screen
# alias s='screen -xR'

# Ubuntu terminalなどVTE環境での一部全角記号ズレ軽減
VTE_CJK_WIDTH=1

# tmux
export TERM=xterm-256color
alias t='tmux attach || tmux new-session'
alias tls='tmux ls'
# htopをscreenで起動する
if [ "$TMUX" = "" ]; then
    unalias htop 2>/dev/null
else
    alias htop='screen htop'
fi

# loadaverage(OSごとの設定)
# http://yonchu.hatenablog.com/entry/20120414/1334422075
if [[ -d $HOME/dotfiles/bin ]]; then
    PATH=$PATH:$HOME/dotfiles/bin
fi

# OS,hostごとの設定
# ulimit
# mac: TeX Live
# tmux, PROMPT: hostnameの色を変更
# 研究室鯖: tmuxのalias
case ${OSTYPE} in
    darwin*)			# mac
	# TeX Live
	_TeXPATH=/usr/local/texlive/2015/bin/x86_64-darwin
	if [[ -d  $_TeXPATH ]]; then
	    PATH=$PATH:$_TeXPATH
	fi
    ;;
    linux*)
	# ulimit (hostごとに変更)
	case `hostname -s` in
	    masaya-*|FS-*)
		# 3GB
		if [ `hostname -s | grep -v 'win'` ]; then
		    ulimit -m 3000000
		fi
		;;
	    basil300|basil301|basil302|jungle)
		# 128GB
		ulimit -m 128000000
		ulimit -v 128000000
		;;
	    basil2*|basil3*|basil4*)
		# basil200/300/400series: 32GB
		ulimit -m 32000000
		ulimit -v 32000000
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
esac

case `hostname -s` in
    masaya-*|FS-*|fs-*)
	tmux_hostname_color="fg=black,bg=colour249"
	tmux_window_color="colour20"
	prompt_hostname_color="blue"
	;;
    basil*|jungle)
	tmux_hostname_color="fg=white,bg=colour22"
	tmux_window_color="colour22"
	prompt_hostname_color="green"
	# alias tmux='LD_PRELOAD=/lib64/libncurses.so.5 tmux'
	# alias t='LD_PRELOAD=/lib64/libncurses.so.5 tmux attach || tmux new-session'
	;;
    *)
	tmux_hostname_color="fg=colour22,bg=colour250"
	tmux_window_color="colour130"
	prompt_hostname_color="white"
	;;
esac

# tmux: ステータスライン設定反映
if [ "$TMUX" != "" ]; then
    tmux set-option -g status-left "#[fg=colour234,bg=colour250]#{?client_prefix,#[bg=colour118],}[#S]#[$tmux_hostname_color,bold] #h #[default] " > /dev/null
    tmux set-option -g window-status-current-format "#{?pane_synchronized,#[fg=colour0]#[bg=colour11]#[bold],#[fg=colour255]#[bg=$tmux_window_color]#[bold]} #I: #W #[default]" > /dev/null
    tmux set-option -g window-status-last-style "fg=$tmux_window_color" > /dev/null
fi

# tmux: ssh時にwindow名を接続先host名にする
# http://qiita.com/shrkw/items/167be53796d4507c736b
# function ssh_tmux() {
#     local window_name=$(tmux display -p '#{window_name}')
#     tmux rename-window -- "$@[-1]" # zsh specified
#     # tmux rename-window -- "${!#}" # for bash
#     command ssh $@
#     tmux rename-window $window_name
# }
# if [[ -n $(printenv TMUX) ]]; then
#     alias ssh=ssh_tmux
# fi

# PROMPT設定

if [ "$EMACS" = t ]; then
    # emacs_shellの場合は左プロンプトを簡略化
    PROMPT="[%2~]:%? %# "
else
    # gitのbranch名を表示
    # http://tkengo.github.io/blog/2013/05/12/zsh-vcs-info/
    autoload -Uz vcs_info
    setopt prompt_subst
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' stagedstr " %B%F{yellow}!%b%f"
    zstyle ':vcs_info:git:*' unstagedstr " %B%F{red}+%b%f"
    zstyle ':vcs_info:*' formats "%F{green}%b%f%c%u "
    zstyle ':vcs_info:*' actionformats '%b | %a'
    precmd () { vcs_info }
    PROMPT='[ %B%F{$prompt_hostname_color}%m%f%b | %F{yellow}%~%f ${vcs_info_msg_0_}| %(?.%?.%F{yellow}%B%?%b%f) | %D %* ]
 %# '
fi

# torch(ローカルマシン用)
# if [ -d /home/masaya/torch ]; then
#     . /home/masaya/torch/install/bin/torch-activate
# fi

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

# コマンドラインスタック
# http://d.hatena.ne.jp/kei_q/20110308/1299594629
show_buffer_stack() {
      POSTDISPLAY="
stack: $LBUFFER"
      zle push-line
}
zle -N show_buffer_stack
bindkey "^[q" show_buffer_stack
