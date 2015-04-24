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
PROMPT="[%m-(%~)]%# "
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

# "C-@"でEmacs起動
# EDITOR_E="$(which emacs) -nw"
function starteditor() {
    exec < /dev/tty

    emacs -nw
    zle reset-prompt
}
zle -N starteditor
bindkey '^@' starteditor

# '...RET'で階層を2つ上がる
alias ...='cd ../..'

# cdした先のディレクトリをスタックに追加 'cd -<TAB>'で履歴表示
setopt auto_pushd
setopt pushd_ignore_dups

# 間違ったcommandを修正してくれる
setopt correct

# 時刻表示
RPROMPT="[%*]"

# rbenv 設定
if [[ -d $HOME/.rbenv ]] then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

# $HOME/local/bin をPATHに追加
export PATH="$HOME/local/bin:$PATH"
