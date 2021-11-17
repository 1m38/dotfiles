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
