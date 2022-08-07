if status is-interactive
    fish_config theme choose 'Tomorrow Night Bright'

    set -U fish_greeting
    set -g skip_right_prompt 0

    bind \n 'clear_right_prompt ; commandline -f execute'
    bind \r 'clear_right_prompt ; commandline -f execute'

    alias fish_prompt='prompt_dmr'
    alias fish_right_prompt='prompt_right_dmr'

    fish_add_path ~/bin
    fish_add_path ~/.emacs.d/bin
    fish_add_path ~/.npm/bin
end
