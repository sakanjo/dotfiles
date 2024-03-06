# npm
alias n 'pnpm'
alias ni 'n install'
alias nr 'n run'
alias nid 'ni -D'
alias nig 'ni -g'
alias nrc 'nr check'
alias nrd 'nr dev'
alias nrp 'nr preview'
alias nrb 'nr build'
alias nrs 'nr start'
alias nrt 'nr test'
alias nrtw 'nr test:watch'
alias nrw 'nr watch'

# Laravel
alias a 'php artisan'
alias as 'a serve'
alias akg 'a key:generate'
alias am 'a migrate'
alias ads 'a db:seed'
alias adw 'a db:wipe'
alias amm 'a make:model -m'
alias amc 'a make:controller'
alias ams 'a make:seeder'
alias amt 'a make:test'
alias amf 'a migrate:fresh'
alias amfs 'a migrate:fresh --seed'
alias at 'a tinker'
alias ah 'a ide-helper:generate && a ide-helper:models -NR && a ide-helper:meta && a ide-helper:eloquent'
alias aqw 'a queue:work'
alias arl 'a route:list'
alias sail '[ -f sail ] && bash sail || bash vendor/bin/sail'

# Python
alias py 'python3'

alias ve 'py -m venv ./venv'
alias va '. ./venv/bin/activate.fish'
alias vd 'deactivate'

alias pi 'pip3 install'
alias pir 'pip3 install -r requirements.txt'
alias pird 'pip3 install -r requirements-dev.txt'
alias pie 'pip3 install -e .'

# Git
alias g 'git'
alias gi 'g init'
alias gd 'g diff'
alias gdc 'gd --cached'
alias ga 'g add'
alias gst 'g status'
alias gbr 'g branch'
alias gp 'g push'
alias gpl 'g pull'
alias gpr 'g pull --rebase'
alias grch 'g reset --hard && g clean -fd'
alias gci 'g commit'
alias gco 'g checkout'
alias main 'g checkout main'
alias master 'g checkout master'
alias czps 'cz && g ps'
alias gpa 'ga . && czps'

# Gh
alias ghr 'gh repo'
alias ghin 'g init -q && g add . && g commit -m "First commit" && gh repo create -s . --push'
alias gha 'gh auth'
alias ghb 'gh browse'
alias ghi 'gh issue'

# Composer
alias co 'composer'
alias coi 'co install'
alias cou 'co update'
alias cor 'co require'

# howdoi
alias howto 'howdoi -c -n 5 how to'

# Gradle
alias gr 'gradle'
alias gw './gradlew'

# Git-extras
alias root 'cd (g root)'

# Exa
alias ls 'exa -g --icons'
alias ll 'ls -la'
alias l 'll'

# Vim
alias v 'nvim'
alias vim 'nvim --clean'

# Cargo
alias c 'cargo'
alias cb 'cargo build -q'
alias cr 'cargo run -q'

# Docker
alias d 'docker'

# Others
alias dl 'cd ~/Downloads'
alias dt 'cd ~/Desktop'

alias paths 'string split : $PATH'

alias unset 'set -e'

alias mux 'tmuxinator'
alias myip 'curl ifconfig.me'
alias weather 'curl wttr.in'

alias cls 'clear'

alias i 'sudo apt install -y'
alias r 'sudo apt remove -y'

alias pbcopy 'xsel --clipboard --input'
alias pbpaste 'xsel --clipboard --output'

alias cpu 'ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head'
alias repos 'grep ^[^#] /etc/apt/sources.list /etc/apt/sources.list.d/*'

alias chmox 'chmod +x'
alias hosts 'sudo $EDITOR /etc/hosts'

alias duh 'du -sh * | sort -h'
