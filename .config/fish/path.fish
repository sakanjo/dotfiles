# Local
set -gx PATH ~/.local/bin $PATH

# NodeJs
set -gx PATH node_modules/.bin $PATH

# Composer
set -gx PATH vendor/bin $PATH
set -gx PATH ~/.config/composer/vendor/bin $PATH

# PNPM
set -gx PNPM_HOME ~/.local/share/pnpm
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end

# Cargo
set -gx PATH ~/.cargo/bin $PATH
set -gx PATH debug $PATH
set -gx PATH release $PATH

# Flutter
set -gx PATH ~/.local/flutter/bin $PATH

# Android
set -gx PATH ~/Android/Sdk/emulator $PATH

# Go
set -gx GOPATH ~/go
set -gx PATH $GOPATH/bin $PATH

# Bun
set -gx PATH ~/.bun/bin $PATH

# Yarn
if type -q yarn
	set -gx PATH (yarn global bin) $PATH
end
