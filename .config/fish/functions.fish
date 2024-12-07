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

function e --description 'exit on finish'
    eval $argv

    if test $status -eq 0
        exit
    end
end

function backup --description 'backup current dir'
    set format (basename (pwd))-(date +%Y-%m-%d.%H:%M:%S)
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
        gh repo clone $argv && cd (basename $argv[1] .git)
    else
        gh repo clone $argv && cd $argv[2]
    end
end

function gcl --description 'git clone and cd into it'
    if test -z $argv[2]
        g clone $argv && cd (basename $argv[1] .git)
    else
        g clone $argv && cd $argv[2]
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

    bind \ee _yazi
    bind \cZ zi
    bind \eg lazygit
    bind \ed lazydocker
end
