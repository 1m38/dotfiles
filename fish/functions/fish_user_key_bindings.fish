function fish_user_key_bindings
    # C-r: peco_select_history
    bind \cr peco_select_history
    # C-x C-r: tsu-nera/fish-peco_recentd
    bind \cx\cr peco_recentd
end
