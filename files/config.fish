if status is-interactive
    set -g skip_right_prompt 0

    bind \n 'clear_right_prompt ; commandline -f execute'
    bind \r 'clear_right_prompt ; commandline -f execute'

    alias fish_prompt='prompt_dmr'
    alias fish_right_prompt='prompt_right_dmr'
end
