# The following lines were added by compinstall

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2 eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hello fancy pants%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

source '/usr/share/fzf/key-bindings.zsh'
source '/usr/share/fzf/completion.zsh'

# autoload -Uz compinit
# zstyle ':completion:*' completer _complete _list _expand _ignored _match _correct _prefix
# zstyle ':completion:*' max-errors 3
# zstyle :compinstall filename '/home/ed/.zshrc'
# compinit

# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.config/zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob
unsetopt appendhistory beep
bindkey -e
# End of lines configured by zsh-newuser-install

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

bindkey "^b" backward-word
bindkey "^w" forward-word

alias reboot="sudo systemctl reboot"
alias poweroff="sudo systemctl poweroff"
alias hibernate="sudo systemctl suspend"
alias scons="scons -j8"

export EDITOR="/usr/bin/nvim"
export BROWSER="/usr/bin/firefox"
export TERMINAL="st"
export DOTS="/home/ed/.config/dotfiles"

export PATH=$PATH:~/Apps:~/.local/bin:

man() {
    LESS_TERMCAP_md=$'\e[01;33m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;30m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;34m' \
    command man "$@"
}

export FZF_DEFAULT_OPTS='--height 40% --color=16'
echo $HOME > /tmp/path
alias install="sudo pacman -S"
alias uninstall="sudo pacman -Rns"
alias update="sudo pacman -Syyu"
alias :q="exit"
alias vi='nvim'
alias vim='nvim'
alias edit='nvim $(fzf)'
alias goto='cd "$(exa -d */**/ | fzf)"'
alias nav='lf -last-dir-path /tmp/lf-path && cd $(cat /tmp/lf-path)'
alias view='zathura'
alias ls='exa'
alias xclip='xclip -selection clipboard'
alias conn='sudo netctl switch-to'
export HERE='Linköping'
alias weather='curl http://v2.wttr.in/$HERE'
alias ocd='openocd -f interface/stlink-v2.cfg -f target/stm32f1x.cfg'
alias unread='echo "$(notmuch search tag:unread | wc -l) unread mails"'
alias plexstart="systemctl start plexmediaserver.service && firefox http://localhost:32400/web/"
alias plexstop="systemctl stop plexmediaserver.service"
alias pull_mail='mbsync -a && notmuch new && notmuch tag +liu to:edvth289@student.liu.se && notmuch tag +lithekod to:kassor@lithekod.se && notmuch tag +personal to:edvard.thornros@gmail.com && unread'
alias countdown="countdown.py"

alias g="git"
alias gs="git status"
alias gc="git commit"
alias gg="git grep"
alias go="git checkout"
alias gb="git branch"

show_git_status() {
    IS_GIT=$( if [[ -d .git ]]; then echo "GIT"; fi )
    GIT=""
    if ! [[ -z $IS_GIT ]]; then
        GIT_BRANCH=$( git branch | grep "*" | cut -c 3- )

        $(git diff --no-ext-diff --quiet)
        if [[ $? -eq 0 ]]; then
            GIT="%f[%B%F{green}$GIT_BRANCH%f%b]"
        else
            GIT="%f[%B%F{red}*$GIT_BRANCH*%f%b]"
        fi
    fi
    echo -n -e "$GIT"
}

show_ssh() {
    if [[ -n $SSH_CONNECTION ]]; then
        echo -n -e "%f%B%F{red}##%f%b"
    fi
    echo -n -e ""
}

bat() {
    cat /sys/class/power_supply/BAT0/capacity
}

setopt PROMPT_SUBST
PROMPT='$(show_ssh)$(show_git_status)%f[%B%F{blue}$(date +"%H:%M")%f%b] %B%F{blue}%2~%f%b%F{green} %B$%b %f'
RPROMPT='%F{blue}$?'

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    exec startx 1>> .tempx
    # Synaptics stuff

    if [ -x synclient ]; then
	    synclient HorizTwoFingerScroll=1 VertTwoFingerScroll=1
	    synclient VertScrollDelta=-112 TapButton1=1 TapButton2=2
    fi

fi


GPG_TTY=$(tty)
export GPG_TTY
export XDG_DATA_HOME=$HOME/.local/share

export PATH=$HOME/.nimble/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$HOME/Apps:$HOME/.local/bin:$HOME/Apps:$HOME/.local/bin:$HOME/.cargo/bin

[[ \$- == *i* ]] && source "/usr/share/fzf/completion.zsh"
source "/usr/share/fzf/key-bindings.zsh"

if ! [ -x "$(type wikipedia.py)" ]; then
    wikipedia.py
fi
