source ~/.config/fish/path.fish
source ~/.config/fish/aliases.fish
source ~/.config/fish/functions.fish
source ~/.config/fish/extra.fish

if test -e "$HOME/.extra.fish";
	source ~/.extra.fish
end

set -gx fish_greeting
set -gx XDG_CONFIG_HOME ~/.config
set -gx EDITOR nvim
set -gx TERM xterm-256color

set -gx FZF_OPEN_COMMAND 'rg --files --no-require-git --hidden -g "!.git" --sort-files 2>/dev/null'
set -gx FZF_CD_COMMAND 'fd --type d --ignore-file ~/.gitignore'
set -gx FZF_CD_WITH_HIDDEN_COMMAND 'fd --type d --ignore-file ~/.gitignore --exclude ".git" --hidden'
