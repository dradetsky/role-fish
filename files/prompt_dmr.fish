function prompt_dmr
    set -l last_status $status

    set -l normal (set_color normal)
    set -l usercolor (set_color $fish_color_user)

    set -l delim '$ '
    fish_is_root_user; and set delim '# '

    # Prompt status only if it's not 0
    set -l prompt_status
    test $last_status -ne 0; and set prompt_status (set_color $fish_color_error)"[$last_status]$normal"

    set -l prompt_from_right
    if test $skip_right_prompt -eq 1
        set prompt_from_right (prompt_right_dmr_unconditional)' '
    end

    echo -n -s $prompt_from_right $prompt_status $delim
end
