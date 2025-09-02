# npm
alias n pnpm

alias ni 'n install'
alias nr 'n run'
alias nid 'ni -D'
alias nig 'ni -g'
alias nrd 'nr dev'
alias nrb 'nr build'
alias nrs 'nr start'

# Laravel
alias a 'php artisan'

alias as 'a serve'
alias akg 'a key:generate'
alias ads 'a db:seed'
alias amf 'a migrate:fresh'
alias amfs 'a migrate:fresh --seed'
alias at 'a tinker'
alias ah 'a ide-helper:generate && a ide-helper:models -NR && a ide-helper:meta && a ide-helper:eloquent'
alias aqw 'a queue:work'
alias arl 'a route:list'

# Python
alias py python

alias venv 'py -m venv ./.venv'
alias vact '. ./.venv/bin/activate.fish'
alias vdea deactivate

alias pi 'pip install -U'
alias piu 'pip uninstall'
alias pir 'pi -r requirements.txt'
alias pie 'pi -e .'

alias pix 'pipx install'
alias pixu 'pipx uninstall'

# Git
alias g git

alias gdc 'g diff --cached'
alias gpr 'g pull --rebase'
alias grch 'g reset --hard && g clean -fd'
alias main 'g checkout main'
alias master 'g checkout master'

# Gh
alias ghin 'g init -q && g add . && g commit -m "First commit" && gh repo create -s . --push'

# Composer
alias co composer

alias coi 'co install'
alias cou 'co update'
alias cor 'co require'
alias cord 'co require --dev'
alias cot 'co test'

# howdoi
alias howto 'howdoi -c -n 5 how to'

# Gradle
alias gr gradle
alias gw './gradlew'

# Git-extras
alias root 'cd (g root)'

# Eza
alias ls 'eza -g --icons'
alias ll 'ls -la'
alias l ll

# Vim
alias v nvim
alias vim 'nvim --clean'

# Cargo
alias c cargo
alias cb 'cargo build -q'
alias cr 'cargo run -q'

# Docker
alias d docker
alias d-ip 'docker inspect -f "{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}"'

# Podman
alias p podman
alias p-ip 'podman inspect -f "{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}"'
alias lazypodman 'DOCKER_HOST=unix:///var/run/user/1000/podman/podman.sock lazydocker'

# Eqo
alias lt 'eqo listen -cq'

# Tput
alias cols 'tput cols'
alias lines 'tput lines'
alias rows 'tput lines'

# Terraform
alias tf terraform

# Others
alias services 'systemctl list-unit-files --type=service'

alias dl 'cd ~/Downloads'
alias dt 'cd ~/Desktop'

alias paths 'string split : $PATH'

alias unset 'set -e'

alias mux tmuxinator
alias myip 'curl ifconfig.me'
alias weather 'curl wttr.in'

alias cls clear

alias i 'sudo apt install -y'
alias r 'sudo apt remove --purge -y'
alias u 'sudo apt update'

alias pbcopy 'xsel --clipboard --input'
alias pbpaste 'xsel --clipboard --output'

alias cpu 'ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head'
alias repos 'rg ^[^#] --colors "match:none" /etc/apt/sources.list /etc/apt/sources.list.d/*.list'

alias chmox 'chmod +x'
alias hosts 'sudo $EDITOR /etc/hosts'

alias cat-cert 'openssl x509 -text -noout -in'
alias certs 'awk -v cmd="openssl x509 -noout -subject" "/BEGIN/{close(cmd)};{print | cmd}" < /etc/ssl/certs/ca-certificates.crt'
