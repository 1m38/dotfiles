# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt autocd nomatch
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/f1m38/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export PATH=$HOME/usr/bin:$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin

# ==== zplug ====
export ZPLUG_HOME=~/.zplug
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-history-substring-search"
zplug "b4b4r07/enhancd", use:init.sh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-completions"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# nim
if [[ -d $HOME/.nimble/bin ]]; then
    export PATH=$HOME/.nimble/bin:$PATH
fi

# brew
if [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

setopt correct              # 間違ったcommandを修正
setopt share_history        # 他zshインスタンスと履歴を共有
setopt extended_history     # コマンドの開始時間と終了時間をhistory fileに記録
setopt hist_ignore_dups     # 連続で同じコマンドが実行されたら履歴に記録しない
setopt hist_reduce_blanks   # 余分な空白を削除して履歴に記録
setopt auto_pushd
disable r

# ==== aliases ====
alias ls='ls -F --color=tty'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# history
alias h='history -i'
alias history-all='history -i 1'
alias histgrep='history-all | grep --color=auto'

# '...RET'で階層を2つ上がる
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# pbcopy / cpfile
if builtin command -v pbcopy > /dev/null; then
    function cpfile() {
        cat $1 | reattach-to-user-namespace pbcopy
    }
elif builtin command -v xsel > /dev/null; then
    alias pbcopy='xsel --clipboard --input'
    function cpfile() {
        cat $1 | xsel --clipboard --input
    }
fi

# ==== fzf ====
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_COMPLETION_OPTS='--border --info=inline'

# https://qiita.com/kamykn/items/aa9920f07487559c0c7e
# fd - cd to selected directory
fd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune \
            -o -type d -print 2> /dev/null | fzf +m) &&
    cd "$dir"
}

# ==== prompt ====
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
PROMPT='[ %B%F{blue}%m%f%b | %F{yellow}%~%f ${vcs_info_msg_0_}| %(?.%?.%F{yellow}%B%?%b%f) | %D %* ]
 %# '
