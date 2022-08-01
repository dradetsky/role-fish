function prompt_dmr
    set -g last_status $status

    set -l delim '$ '
    fish_is_root_user; and set delim '# '

    set -l prompt_from_right
    if test $skip_right_prompt -eq 1
        set -g last_status 0
        set prompt_from_right (prompt_right_dmr_unconditional)' '
    end

    echo -n -s $prompt_from_right $delim
end
