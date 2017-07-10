function fish_prompt --description 'Write out the prompt'
        set -l color_cwd
	set -l suffix
	switch $USER
		case root toor
			if set -q fish_color_cwd_root
				set color_cwd $fish_color_cwd_root
			else
				set color_cwd $fish_color_cwd
			end
			set suffix '#'
		case '*'
			# set color_cwd $fish_color_cwd
			set color_cwd 'yellow'
			set suffix '>'
	end
	set -l prompt_gxp_hostname_color 'red'
	set -l exit_code $status
	set -l color_exit_code
	set -l bold_exit_code
	if [ $exit_code -eq 0 ]
		set color_exit_code 'normal'
		set bold_exit_code
	else
		set color_exit_code 'yellow'
		set bold_exit_code '--bold'
	end

	# git status
	set -l color_git_branch 'green'
	set -l color_git_diff 'red'
	set -l color_git_untracked 'yellow'
	set -l git_branch
	set -l git_diff
	set -l git_untracked
	git rev-parse --is-inside-work-tree >/dev/null ^/dev/null
	if [ $status -eq 0 ]
		set git_branch (git rev-parse --abbrev-ref HEAD ^/dev/null)
		git status --porcelain | grep -E '^ *M' >/dev/null
		if [ $status -eq 0 ]
			set git_diff '+'
		end
		git status --porcelain | grep -E '^ *\?\?' >/dev/null
		if [ $status -eq 0 ]
			set git_untracked '?'
		end
	end

	# set prompt "$USER" @ (prompt_hostname) ' [' (set_color $bold_exit_code $color_exit_code) "$exit_code" (set_color normal) '] '(set_color $color_cwd) (prompt_pwd) (set_color normal) "$suffix "
	set -l prompt "[ "
	if [ -n "$GXP_ON" ]	# change hostname color when gxp is activated
		set prompt $prompt (set_color --bold $prompt_gxp_hostname_color)
	else
		set prompt $prompt (set_color --bold $prompt_hostname_color)
	end
	set prompt $prompt (prompt_hostname) (set_color normal) " "
	set prompt $prompt (set_color --bold blue) "><>" (set_color normal) " | "
	set prompt $prompt (set_color $color_cwd) (prompt_pwd) (set_color normal) 
	if [ -n "$git_branch" ]	# branch_name, dirty markerを表示
		set prompt $prompt (set_color $color_git_branch) " $git_branch" (set_color --bold $color_git_diff) "$git_diff" (set_color --bold $color_git_untracked) "$git_untracked" (set_color normal)
	end
	set prompt $prompt " | "
	set prompt $prompt (set_color $bold_exit_code $color_exit_code) "$exit_code" (set_color normal) " | "
	if [ -n "$GXP_ON" ]	# gxp: [N/N/N] を表示
		set prompt $prompt (set_color 'cyan') (gxpc prompt 2> /dev/null) (set_color normal)
		set prompt $prompt " | "
	end
	set prompt $prompt (date "+%y-%m-%d %H:%M:%S") " ]"

	echo -n -s $prompt
	printf "\n %% "
end
