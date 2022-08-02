function prompt_dmr
    set -g last_status $status

    if not set -q fish_color_host_id
        set -U fish_color_host_id (text_to_color $hostname)
    end

    set -l normal (set_color normal)
    set -l delimcolor (set_color $fish_color_host_id)

    set -l delim_inner '$ '
    fish_is_root_user; and set delim_inner '# '

    set -l delim "$delimcolor""$delim_inner""$normal"

    set -l prompt_from_right
    if test $skip_right_prompt -eq 1
        set -g last_status 0
        set prompt_from_right (prompt_right_dmr_unconditional)' '
    end

    echo -n -s $prompt_from_right $delim
end
