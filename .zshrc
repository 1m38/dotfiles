# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt autocd nomatch
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/owner/.zshrc'
# End of lines added by compinstall

export PATH=$HOME/usr/bin:$HOME/bin:$HOME/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin

# ==== zplug ====
export ZPLUG_HOME=~/.zplug
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-history-substring-search"
zplug "b4b4r07/enhancd", use:init.sh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-completions"
zplug "asdf-vm/asdf", at:v0.10.2     # load later

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

# asdf (installed by zplug)
if [[ -d $ZPLUG_REPOS/asdf-vm/asdf ]]; then
    . $ZPLUG_REPOS/asdf-vm/asdf/asdf.sh
    fpath=(${ASDF_DIR}/completions $fpath)
fi

setopt correct              # 間違ったcommandを修正
setopt share_history        # 他zshインスタンスと履歴を共有
setopt extended_history     # コマンドの開始時間と終了時間をhistory fileに記録
setopt hist_ignore_dups     # 連続で同じコマンドが実行されたら履歴に記録しない
setopt hist_reduce_blanks   # 余分な空白を削除して履歴に記録
setopt magic_equal_subst    # `opt=arg`の形のオプションも補完できる
setopt auto_pushd
disable r

# ==== aliases ====
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

if builtin command -v exa > /dev/null; then
    alias ls='exa --time-style long-iso'
else
    alias ls='ls -F --color=tty'
fi

# history
alias h='history -i'
alias history-all='history -i 1'
alias histgrep='history-all | grep --color=auto'

# '...RET'で階層を2つ上がる
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# tmux
alias t='tmux attach || tmux new-session'
alias tls='tmux ls'

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
fdcd() {
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

# コマンド実行時にプロンプトをリセット(RPROMPTの時刻を更新)
re-prompt() {
    zle .reset-prompt
    zle .accept-line
}
zle -N accept-line re-prompt

autoload -Uz compinit
compinit
# https://qiita.com/watertight/items/2454f3e9e43ef647eb6b
# 小文字を入力したときは大文字も補完する (大文字を入力したときは小文字を補完しない)
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'

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
