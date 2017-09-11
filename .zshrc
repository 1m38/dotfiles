# basic env
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export LANG=ja_JP.UTF-8
HOSTNAME_S=`hostname -s`
if [[ -f ~/.my_zsh_envs ]]; then
    source ~/.my_zsh_envs
fi

# linuxbrew / homebrew(local)
if [[ -d $HOME/.linuxbrew ]]; then
    export PATH="$HOME/.linuxbrew/bin:$PATH"
    export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
    export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
fi
if [[ -d /home/linuxbrew/.linuxbrew ]]; then
    export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi
if [[ -d /usr/local/Homebrew ]]; then
    # export PATH=/usr/local/bin:${PATH}
    export MANPATH=/usr/local/share/man:${MANPATH}
    # coreutils
    if [[ -d /usr/local/opt/coreutils ]]; then
	export PATH=/usr/local/opt/coreutils/libexec/gnubin:${PATH}
	export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}
    fi
fi

# =========
#   zplug
# =========

# install
if [[ ! -d $HOME/.zplug ]]; then
    if (( $+commands[curl] )); then
	curl -sL zplug.sh/installer | zsh
    else
	echo "zplug install: curl -sL zplug.sh/installer | zsh"
    fi
fi
source ~/.zplug/init.zsh

# tmux内でのみload
if [[ -n $TMUX ]] && builtin command -v zplug > /dev/null; then
    zplug "zsh-users/zsh-history-substring-search"
    zplug "b4b4r07/enhancd", use:init.sh
    zplug "zsh-users/zsh-syntax-highlighting", defer:2
    zplug "mollifier/anyframe"

    # Install plugins if there are plugins that have not been installed
    if ! zplug check --verbose; then
        zplug install
    fi

    zplug load --verbose

    if zplug check zsh-users/zsh-history-substring-search; then
        bindkey -M emacs '^P' history-substring-search-up
        bindkey -M emacs '^N' history-substring-search-down
    fi
    if zplug check zsh-users/zsh-syntax-highlighting; then
	ZSH_HIGHLIGHT_STYLES[globbing]='fg=cyan'
    fi
fi

# kuro-lab_cluster: GPU / linuxbrew
if [[ -f /usr/local/cuda/bin/nvcc ]]; then
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/lib64"
    export CUDA_HOME="/usr/local/cuda"
    export PATH="$PATH:/usr/local/cuda/bin"
elif [[ -f /mnt/orange/brew/brew.zsh ]]; then
    # /orange/brew
    BREW_ZSH=/mnt/orange/brew/data/bin/zsh
    if [[ -x $BREW_ZSH ]]; then
	BREW_VER=$($BREW_ZSH --version | cut -f 2 -d ' ')
	if [[ $BREW_VER != $ZSH_VERSION ]]; then
	    exec $BREW_ZSH -l
	    exit
	fi
    fi
    source /mnt/orange/brew/brew.zsh
fi

# =================
#   env variables
# =================
export PATH=$HOME/usr/bin:$HOME/bin:$HOME/local/bin:$HOME/.local/bin:$PATH
export EDITOR=emacsclient

# history
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=$HOME/.zsh_history

export LS_COLORS=':no=00:fi=00:di=36:ln=35:pi=33:so=32:bd=34;46:cd=34;43:ex=31:'

# ===========
#   options
# ===========
bindkey -e
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
disable r

# cdした先のディレクトリをスタックに追加 'cd -<TAB>'で履歴表示
setopt auto_pushd
setopt pushd_ignore_dups

setopt correct			# 間違ったcommandを修正

# cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs


# ===========
#   aliases
# ===========
alias ls='ls -F --color=tty'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias j='jumanpp'
alias jk='jumanpp | knp'
alias sort='LANG=C sort'
alias uniq='LANG=C uniq'

# history
alias h='history -i'
alias history-all='history -i 1'
alias histgrep='history-all | grep --color=auto'

# '...RET'で階層を2つ上がる
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias ssh-addk='ssh-add ~/.ssh/k2l.id_ecdsa'

# emacsclient
alias e='emacsclient -c -t -a ""'
alias killemacs='emacsclient -e "(kill-emacs)"'
alias restartemacs='killemacs; e'

# pbcopy / cpfile
if builtin command -v pbcopy > /dev/null; then
    function cpfile() {
	cat $1 | pbcopy
    }
elif builtin command -v xsel > /dev/null; then
    alias pbcopy='xsel --clipboard --input'
    function cpfile() {
	cat $1 | xsel --clipboard --input
    }
fi


# =======
#   fzf
# =======
if [[ ! -d $HOME/.fzf ]]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --key-bindings --no-completion --no-update-rc
fi
export FZF_TMUX=1
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}
alias ll=fshow


# completion
autoload -U compinit && compinit
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select interactive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'


autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

autoload replace-string
zle -N replace-string

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


# tmux
if ! builtin command -v tmux > /dev/null && [[ -f /mnt/orange/brew/data/bin/tmux ]]; then
    alias tmux=/mnt/orange/brew/data/bin/tmux
fi
alias t='tmux attach || tmux new-session'
alias tls='tmux ls'
if [ "$TMUX" = "" ]; then
    export TERM=xterm-256color
else
    export TERM=screen-256color
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
	_TeXPATH=/usr/local/texlive/2016/bin/x86_64-darwin
	if [[ -d  $_TeXPATH ]]; then
	    PATH=$PATH:$_TeXPATH
	fi
	# alias ls='ls -FG'
	# export LSCOLORS=gxfxcxdxbxegedabagacad
	if ! [[ -z $TMUX ]]; then
	    alias open='reattach-to-user-namespace open'
	fi
    ;;
    linux*)
	# ulimit (hostごとに変更)
	case $HOSTNAME_S in
	    basil300|basil301|basil302)
		# 128GB
		ulimit -m 128000000
		ulimit -v 128000000
		;;
	    jungle)
		# 600GB
		ulimit -m 600000000
		ulimit -v 600000000
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
	    baracuda*)
		# 20GB
		ulimit -m 20000000
		ulimit -v 20000000
		;;
	    moss*)
		# 200GB
		ulimit -m 200000000
		ulimit -v 200000000
		;;

	esac
esac

case $HOSTNAME_S in
    masaya-*|FS-*|fs-*)
	tmux_hostname_color="fg=black,bg=colour249"
	tmux_window_color="colour20"
	prompt_hostname_color="blue"
	;;
    basil*|jungle)
	tmux_hostname_color="fg=white,bg=colour22"
	tmux_window_color="colour22"
	prompt_hostname_color="green"
	;;
    baracuda*|moss*)
	tmux_hostname_color="fg=white,bg=colour166"
	tmux_window_color="colour166"
	prompt_hostname_color="green"
	;;
    *)
	tmux_hostname_color="fg=white,bg=colour52"
	tmux_window_color="colour52"
	prompt_hostname_color="white"
	;;
esac

# tmux: ステータスライン設定反映
if [ "$TMUX" != "" ]; then
    tmux set-option -g status-left "#[fg=colour234,bg=colour250]#{?client_prefix,#[bg=colour118],}[#S]#[$tmux_hostname_color,bold] #h #[default] " > /dev/null
    tmux set-option -g window-status-current-format "#{?pane_synchronized,#[fg=colour0]#[bg=colour11]#[bold],#[fg=colour255]#[bg=$tmux_window_color]#[bold]} #I: #W #[default]" > /dev/null
    tmux set-option -g window-status-last-style "fg=$tmux_window_color" > /dev/null
fi

# ==========
#   PROMPT
# ==========

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


# コマンドラインスタック
# http://d.hatena.ne.jp/kei_q/20110308/1299594629
show_buffer_stack() {
      POSTDISPLAY="
stack: $LBUFFER"
      zle push-line
}
zle -N show_buffer_stack
bindkey "^[q" show_buffer_stack

# ipython: 色をlinux準拠に
alias ipython='ipython --colors=linux'
alias ipython3='ipython3 --colors=linux'


# less設定
export LESS='-g -i -M -R'
# manに色を付ける
export PAGER='less'
export LESS_TERMCAP_mb=$'\E[01;31m'      # Begins blinking.
export LESS_TERMCAP_md=$'\E[01;31m'      # Begins bold.
export LESS_TERMCAP_me=$'\E[0m'          # Ends mode.
export LESS_TERMCAP_se=$'\E[0m'          # Ends standout-mode.
export LESS_TERMCAP_so=$'\E[00;47;30m'   # Begins standout-mode.
export LESS_TERMCAP_ue=$'\E[0m'          # Ends underline.
export LESS_TERMCAP_us=$'\E[01;32m'      # Begins underline.

if which lesspipe.sh > /dev/null; then
    export LESSOPEN='| /usr/bin/env lesspipe.sh %s 2>&-'
fi


# anyenv
if [[ -d $HOME/.anyenv ]]; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init - --no-rehash)"

    if $pyenv_install; then
	if ! builtin command -v pyenv > /dev/null; then
	    echo "pyenv not installed."
	    printf "Install? [y/N]: "
            if read -q; then
		anyenv install pyenv
	    else
		echo "pyenv_install=false" >> ~/.my_zsh_envs
            fi
	fi
    fi
else
    if builtin command -v git > /dev/null; then
	git clone https://github.com/riywo/anyenv ~/.anyenv
    else
	echo "anyenv not installed."
	echo "run: git clone https://github.com/riywo/anyenv ~/.anyenv"
    fi
fi


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
    alias stanford-parser="/mnt/orange/brew/data/bin/java -mx4000m -cp $STP_DIR/\* edu.stanford.nlp.parser.lexparser.LexicalizedParser -tokenized -maxLength 200 -outputFormat penn,typedDependencies -escaper edu.stanford.nlp.process.PTBEscapingProcessor -sentences newline edu/stanford/nlp/models/lexparser/englishRNN.ser.gz -"
fi
STCore_DIR=$HOME/tools/stanford-corenlp-full-2015-12-09
if [[ -d $STCore_DIR ]]; then
    alias stanford-corenlp="/mnt/orange/brew/data/bin/java -Xmx5g -cp $STCore_DIR/\* edu.stanford.nlp.pipeline.StanfordCoreNLP -annotators tokenize,ssplit,pos,lemma,ner,parse,dcoref,depparse -ssplit.eolonly true"
    alias stanford-corenlp-zh="/mnt/orange/brew/data/bin/java -Xmx5g -cp $STCore_DIR/\* edu.stanford.nlp.pipeline.StanfordCoreNLP -props StanfordCoreNLP-chinese.properties"
fi

# spark
if [[ -d $HOME/src/spark ]]; then
    export SPARK_HOME=$HOME/src/spark
fi


# コマンドの実行が終わったらメール
function rep_mail (){
    subj="report mail:$HOSTNAME_S"
    mail_from="uno@nlp.ist.i.kyoto-u.ac.jp"
    mail_to="uno@nlp.ist.i.kyoto-u.ac.jp"

    cmd=$@
    start_time=`date "+%m/%d %H:%M:%S"`
    text="${cmd}\n開始 ${start_time}\n"

    trap "python3 ~/src/ReportMail/sendmail.py -s \"$subj\" -b \"${text}強制終了\"  ;trap INT  EXIT ERR;" INT
    trap "python3 ~/src/ReportMail/sendmail.py -s \"$subj\" -b \"${text}異常終了\"  ;trap INT  EXIT ERR;" ERR
    trap "python3 ~/src/ReportMail/sendmail.py -s \"$subj\" -b \"${text}正常終了\"  ;trap INT  EXIT ERR;" EXIT
    $@
}

# Ubuntu terminalなどVTE環境での一部全角記号ズレ軽減
VTE_CJK_WIDTH=1
