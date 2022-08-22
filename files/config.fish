if status is-interactive
    fish_config theme choose 'Tomorrow Night Bright'

    set -U fish_greeting
    set -g skip_right_prompt 0

    function ctrl_c_dmr
        if test -z "$(commandline)"
            printf '\n'
            commandline -f repaint
        else
            commandline -f cancel-commandline
        end
    end

    bind \cc ctrl_c_dmr

    bind \n 'clear_right_prompt ; commandline -f execute'
    bind \r 'clear_right_prompt ; commandline -f execute'

    alias fish_prompt='prompt_dmr'
    alias fish_right_prompt='prompt_right_dmr'

    fish_add_path ~/bin
    fish_add_path ~/.emacs.d/bin
    fish_add_path ~/.npm/bin
    fish_add_path ~/code/go/bin

    alias emg='emacsclient -a /bin/false -c'
    alias emc='emacsclient -a /bin/false --tty'

    abbr -a gpnc git pull --no-commit
    abbr -a gd git diff
    abbr -a gcd1 git clone --depth 1
end

source (status dirname)/conf.d/env_unconditional.fish
