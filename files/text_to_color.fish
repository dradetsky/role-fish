function text_to_hash_1
    # NOTE: we use blake2b (a cryptographic hash) rather than just a simple cksum despite this not
    # being a use-case requiring cryptographic hash guarantees since
    #
    # - it seems to spread the values out better (so more likely for colors to be distinct), and
    # - blake2b appears to only be a few ns slower than plain cksum anyway
    set -l shas (echo $argv | cksum -a blake2b | string split -f4 ' ' | string sub -e 6)
    echo $shas
end

alias text_to_hash='text_to_hash_1'

# based on the text color hash block from disco.fish
function text_to_color
    set -l hash (text_to_hash $argv)
    hash_to_color $hash
end

function hash_to_color
    set -l shas (string match -ra .. $argv)
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
