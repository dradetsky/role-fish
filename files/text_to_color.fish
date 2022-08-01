function text_to_color
    set -l shas (echo $argv | cksum | string split -f1 ' ' | math --base=hex | string sub -s 3 | string match -ra ..)
    set -l col 0x$shas[1..3]

    # If the (simplified idea of) luminance is below 120 (out of 255), add some more.
    # (this runs at most twice because we add 60)
    while test (math 0.2126 x $col[1] + 0.7152 x $col[2] + 0.0722 x $col[3]) -lt 120
        set col[1] (math --base=hex "min(255, $col[1] + 60)")
        set col[2] (math --base=hex "min(255, $col[2] + 60)")
        set col[3] (math --base=hex "min(255, $col[3] + 60)")
    end
    set -l col (string replace 0x '' $col | string pad -c 0 -w 2 | string join "")
    echo -n -s $col
end

function text_to_color_demo
    set -l normal (set_color normal)
    set -l col (text_to_color (pwd -P))
    set -l delim '$ '
    echo -n -s (set_color $col) $delim $normal
end
