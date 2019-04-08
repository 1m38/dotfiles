function fish_prompt --description 'Write out the prompt'

    set -l stat $status


    set -l prompt "[ "

    # hostname
    set -l l_prompt_hostname (set_color --bold blue)(prompt_hostname)(set_color normal)
    set -l prompt $prompt $l_prompt_hostname

    # fish
    set -l prompt $prompt " " (set_color blue) "><>" (set_color normal)

    set -l prompt $prompt " | "

    # working directory
    set -l l_prompt_pwd (set_color yellow)(prompt_pwd)(set_color normal)
    set -l prompt $prompt $l_prompt_pwd

    # git branch
    set l_prompt_git
    git rev-parse --is-inside-work-tree >/dev/null ^/dev/null
    if [ $status -eq 0 ]
	set -l color_git_branch 'green'
	set -l color_git_diff 'red'
	set -l color_git_untracked 'yellow'
	set -l git_branch (git rev-parse --abbrev-ref HEAD ^/dev/null)
	set -l git_diff
	git status --porcelain | grep -E '^ *M' >/dev/null
	if [ $status -eq 0 ]
	    set git_diff (set_color --bold $color_git_diff) '+'
	end
	set -l git_untracked
	git status --porcelain | grep -E '^ *\?\?' >/dev/null
	if [ $status -eq 0 ]
	    set git_untracked (set_color --bold $color_git_untracked) '?'
	end
	set l_prompt_git " " \
	    (set_color $color_git_branch) $git_branch \
	    $git_diff \
	    $git_untracked \
	    (set_color normal)
    end
    set -l prompt $prompt $l_prompt_git

    set -l prompt $prompt " | "

    # status
    set -l l_stat_color
    if [ $stat -ne 0 ]
	set l_stat_color (set_color --bold yellow)
    end
    set -l prompt $prompt $l_stat_color $stat (set_color normal) " | "

    # date
    set -l prompt $prompt (date "+%y-%m-%d %H:%M:%S")

    set -l prompt $prompt " ]"
    echo -n -s $prompt

    # prompt character
    switch "$USER"
        case root toor
	    printf "\n # "
	case '*'
	    printf "\n %% "
    end

end
