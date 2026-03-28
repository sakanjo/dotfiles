function ..
    cd ..
end
function ...
    cd ../..
end
function ....
    cd ../../..
end
function .....
    cd ../../../..
end

function x -d "Extract archives into a folder with the same basename"
    if test (count $argv) -lt 1
        echo "usage: x FILE [FILE ...]"
        return 1
    end

    if command -q gtar
        set tar gtar
    else
        set tar tar
    end

    for file in $argv
        set name (string lower (basename "$file"))
        set dir (string replace -r '\.(tar\.gz|tgz|tar\.bz2|tbz2?|tar\.xz|txz|tar\.zst|tzst|tar\.lzma|tlz|tar\.lz|tar\.lz4|tar\.lzo|tar\.Z|taz|tar|7z|zip|gz|bz2?|xz|lzma|zst|lz4|Z|appimage)$' '' $name)

        mkdir -p "$dir"

        switch (string lower "$file")
            case '*.tar'
                $tar xvf "$file" -C "$dir"

            case '*.tar.gz' '*.tgz'
                $tar xvzf "$file" -C "$dir"

            case '*.tar.bz2' '*.tar.bz' '*.tbz' '*.tbz2'
                $tar xvjf "$file" -C "$dir"

            case '*.tar.xz' '*.txz'
                $tar xvJf "$file" -C "$dir"

            case '*.tar.Z' '*.taz'
                $tar xvZf "$file" -C "$dir"

            case '*.tar.zst' '*.tzst'
                $tar --zstd -xvf "$file" -C "$dir"

            case '*.tar.lzma' '*.tar.zma' '*.tlz'
                $tar --lzma -xvf "$file" -C "$dir"

            case '*.tar.lrz'
                lrzuntar "$file" "$dir"

            case '*.tar.lz'
                $tar --lzip -xvf "$file" -C "$dir"

            case '*.tar.lz4'
                $tar --use-compress-program=lz4 -xvf "$file" -C "$dir"

            case '*.tar.lzo'
                $tar --lzop -xvf "$file" -C "$dir"

            case '*.7z' '*.iso'
                7zz x "$file" -o"$dir"

            case '*.zip' '*.xpi' '*.jar'
                unzip "$file" -d "$dir"

            case '*.gz'
                gunzip -c "$file" >"$dir/$dir"

            case '*.bz2' '*.bz'
                bunzip2 -c "$file" >"$dir/$dir"

            case '*.xz'
                unxz -c "$file" >"$dir/$dir"

            case '*.lzma'
                unlzma -c "$file" >"$dir/$dir"

            case '*.zst'
                unzstd -c "$file" >"$dir/$dir"

            case '*.lz4'
                unlz4 -c "$file" >"$dir/$dir"

            case '*.Z'
                uncompress -c "$file" >"$dir/$dir"

            case "*.appimage"
                if not test -x "$file"
                    echo >&2 "x: failed to extract '$file': file is not executable"
                    return 1
                end

                cd "$dir"
                ../"$file" --appimage-extract
                cd ..

            case '*'
                echo >&2 "x: failed to extract '$file': unsupported file type"
                return 1
        end

        if test $status -ne 0
            echo >&2 "Failed to extract '$file'"
            return 1
        end
    end
end

function e --description 'exit on finish'
    eval $argv

    if test $status -eq 0
        exit
    end
end

function backup --description 'backup current dir'
    set format (basename (pwd))-(date +%Y-%m-%d.%H_%M_%S)
    tar -zcvf ../$format.tar.gz ../(basename (pwd))/ 1>/dev/null 2>&1
end

function beep --description 'make two beeps'
    echo -e '\a'
    sleep 0.1
    echo -e '\a'
end

function rn --description 'rename current dir'
    set new_name $argv[1]
    set current_dir (pwd)
    cd ..
    mv $current_dir $new_name
    cd $new_name
end

function gap --description 'git add all and commit'
    g add . && g commit -m "$argv[1]" && g push
end

function ghcl --description 'git clone from github and cd into it'
    if test -z $argv[2]
        gh repo clone $argv -- --depth 1 && cd (basename $argv[1] .git)
    else
        gh repo clone $argv -- --depth 1 && cd $argv[2]
    end
end

function pr --description 'list prs or checkout'
    if test -z $argv[1]
        gh pr list
    else
        gh pr checkout $argv[1]
    end
end

function gcld --description 'git clone depth 1 and cd into it'
    if test -z $argv[2]
        g clone --depth 1 $argv && cd (basename $argv[1] .git)
    else
        g clone --depth 1 $argv && cd $argv[2]
    end
end

function mc --description 'mkdir file and cd into it'
    mkdir -p $argv[1]
    cd $argv[1]
end

function sudo!! --description 'sudo last command'
    eval sudo $history[1]
end

function bind_bang
    switch (commandline -t)[-1]
        case "!"
            commandline -t -- $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function bind_dollar
    switch (commandline -t)[-1]
        case "!"
            commandline -f backward-delete-char history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

function _yazi
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

function fish_user_key_bindings
    bind ! bind_bang
    bind '$' bind_dollar

    bind alt-e _yazi
    bind ctrl-z zi
    bind alt-g lazygit
    bind alt-h lazydocker
    bind alt-H lazypodman
end
