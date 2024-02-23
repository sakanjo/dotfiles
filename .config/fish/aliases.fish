# npm
alias nid 'npm install -D'
alias ni 'npm install'
alias nr 'npm run'
alias nrc 'npm run check'
alias nrd 'npm run dev'
alias nrp 'npm run preview'
alias nrb 'npm run build'
alias nrs 'npm run start'
alias nrt 'npm run test'
alias nrtw 'npm run test:watch'
alias nrw 'npm run watch'

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
alias ah 'a ide-helper:generate; a ide-helper:models -NR; a ide-helper:meta; a ide-helper:eloquent'
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
alias gi 'git init'
alias gd 'git diff'
alias gdc 'gd --cached'
alias ga 'git add'
alias gst 'git status'
alias gbr 'git branch'
alias gp 'git push'
alias gpl 'git pull'
alias gpr 'git pull --rebase'
alias grch 'git reset --hard && git clean -fd'
alias gci 'git commit'
alias gco 'git checkout'
alias main 'git checkout main'
alias master 'git checkout master'
alias czps 'cz && git ps'
alias gpa 'ga . && czps'

# Gh
alias ghr 'gh repo'
alias ghin 'git init -q && git add . && git commit -m "First commit" && gh repo create -s . --push'
alias gha 'gh auth'
alias ghb 'gh browse'
alias ghi 'gh issue'

# Composer
alias co 'composer'
alias coi 'composer install'
alias cou 'composer update'
alias cor 'composer require'

# howdoi
alias howto 'howdoi -c -n 5 how to'

# Gradle
alias gw './gradlew'

# Git-extras
alias root 'cd (git root)'

# Exa
alias ls 'exa -g --icons'
alias ll 'ls -la'
alias l 'll'

# Vim
alias v 'nvim'
alias vim 'nvim --clean'

# Others
alias dl 'cd ~/Downloads'
alias dt 'cd ~/Desktop'

alias paths 'string split : $PATH'

alias unset 'set -e'

alias mux 'tmuxinator'
alias myip 'curl ifconfig.me'
alias weather 'curl wttr.in'

alias c 'clear'
alias i 'sudo apt install -y'
alias r 'sudo apt remove -y'

alias pbcopy 'xsel --clipboard --input'
alias pbpaste 'xsel --clipboard --output'

alias cpu 'ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head'
alias repos 'grep ^[^#] /etc/apt/sources.list /etc/apt/sources.list.d/*'

alias chmox 'chmod +x'
alias hosts 'sudo $EDITOR /etc/hosts'

alias duh 'du -sh * | sort -h'
