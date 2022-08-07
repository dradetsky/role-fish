source /usr/share/fish/completions/screen.fish

set -l redetach '__fish_contains_opt -s d -s r'
complete -c screen -n "$redetach" -xa '(__fish_complete_screen)'
