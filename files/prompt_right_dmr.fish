function prompt_right_dmr
    set -g last_status $status

    if test $skip_right_prompt -eq 1
        return
    end

    prompt_right_dmr_unconditional
end

function prompt_right_dmr_unconditional
    set -g __fish_git_prompt_showdirtystate 1
    set -g __fish_git_prompt_showuntrackedfiles 1
    set -g __fish_git_prompt_showupstream informative
    set -g __fish_git_prompt_showcolorhints 1
    set -g __fish_git_prompt_use_informative_chars 1
    set -g __fish_git_prompt_char_dirtystate '*'
    set -g __fish_git_prompt_char_untrackedfiles "?"

    set -l normal (set_color normal)
    set -l cwd (set_color $fish_color_cwd)
    if command -sq cksum
        set cwd (set_color (text_to_color (pwd -P)))
    end

    # The git prompt's default format is ' (%s)'.
    # We don't want the leading space.
    set -l vcs (fish_vcs_prompt '(%s)' 2>/dev/null)
    # set -l wd (echo -n -s $cwd $prompt_pwd $normal)
    set -l wd (echo -n -s $cwd (prompt_pwd) $normal)
    set -l d (set_color brgrey)(date "+%R")(set_color normal)

    set -l duration "$cmd_duration$CMD_DURATION"
    if test $duration -gt 100
        set duration (math $duration / 1000)s
    else
        set duration
    end

    set -q VIRTUAL_ENV_DISABLE_PROMPT
    or set -g VIRTUAL_ENV_DISABLE_PROMPT true
    set -q VIRTUAL_ENV
    and set -l venv (string replace -r '.*/' '' -- "$VIRTUAL_ENV")

    # Prompt status only if it's not 0
    set -l prompt_status
    test $last_status -ne 0; and set prompt_status (set_color $fish_color_error)"[$last_status]$normal"

    set_color normal
    string join " " -- $prompt_status $venv $duration $vcs $wd $d
end

function clear_right_prompt
    if test -n (commandline)
        set -g skip_right_prompt 1
        commandline -f repaint
    end
end

function reset_right_prompt --on-event fish_postexec
    set -g skip_right_prompt 0
    commandline -f repaint
end
