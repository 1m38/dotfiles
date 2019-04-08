# fisher
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# aliases
. ~/.config/fish/aliases.fish

# linuxbrew
if [ -f /home/linuxbrew/.linuxbrew/bin/brew ]
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

# disable shortening dirnames in function prompt_pwd
set -g fish_prompt_pwd_dir_length 0

# disable greeting
set fish_greeting

# OS specific settings
switch (uname)
    case 'darwin*'		# mac
	# alias ls='ls -FG'
	# export LSCOLORS=gxfxcxdxbxegedabagacad
	if [ -n $TMUX ]	# if in tmux session
	    alias open 'reattach-to-user-namespace open'
	end
end

# Host specific settings
switch (hostname -s)
    case 'FS-*' 'fs-*'
	set tmux_hostname_color "fg=black,bg=colour249"
	set tmux_window_color "colour20"
	set prompt_hostname_color "blue"
end

# tmux: ステータスライン設定反映
if [ -n $TMUX ]
    set -l status_left "#[fg=colour234,bg=colour250]#{?client_prefix,#[bg=colour118],}[#S]#["$tmux_hostname_color",bold] #h #[default] "
    # echo $status_left
    tmux set-option -g status-left "$status_left" > /dev/null
    set -l window_status_current_format "#{?pane_synchronized,#[fg=colour0]#[bg=colour11]#[bold],#[fg=colour255]#[bg="$tmux_window_color"]#[bold]} #I: #W #[default]"
    tmux set-option -g window-status-current-format "$window_status_current_format" > /dev/null
    set -l window_status_last_style "fg="$tmux_window_color
    tmux set-option -g window-status-last-style "$window_status_last_style" > /dev/null
end
