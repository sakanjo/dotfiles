set -gx PATH ~/.local/bin $PATH

# NodeJs
set -gx PATH node_modules/.bin $PATH

# Composer
set -gx PATH vendor/bin $PATH
set -gx PATH ~/.config/composer/vendor/bin $PATH

# Go
set -g GOPATH ~/go
set -gx PATH $GOPATH/bin $PATH

# Bun
set -gx PATH ~/.bun/bin $PATH

# Yarn
if type -q yarn
	set -gx PATH (yarn global bin) $PATH
end
