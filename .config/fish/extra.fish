if test -f ~/.pythonrc
    set -gx PYTHONSTARTUP ~/.pythonrc
end

if test -d /home/linuxbrew/.linuxbrew
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
end

if type -q zoxide
    zoxide init fish | source
end

if type -q oh-my-posh && test -f ~/.theme.omp.json
    oh-my-posh init fish --config ~/.theme.omp.json | source
end

if type -q fnm
    fnm env --shell fish | source
end

if type -q starship
    starship init fish | source
end

if type -q atuin
    atuin init fish | source
end

if type -q direnv
    direnv hook fish | source
end
