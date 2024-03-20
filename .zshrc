# Use powerline
USE_POWERLINE="false"
# Has weird character width
# Example:
#    is not a diamond
HAS_WIDECHARS="false"

## Options section
setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.
setopt inc_append_history                                       # save commands are added to the history immediately, otherwise only when shell exits.
setopt histignorespace                                          # Don't save commands that start with space
setopt HIST_SAVE_NO_DUPS

autoload -U compinit; compinit
fpath=(/usr/share/zsh/site-functions/ $fpath)
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
zstyle ':completion:*' menu select                              # Highlight menu selection
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word


# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-R

zmodload zsh/terminfo

if [[ -e /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh 
fi
if [[ -e /usr/share/fzf/completion.zsh ]]; then
  source /usr/share/fzf/completion.zsh  
fi

export LS_OPTIONS='--color=auto'
eval "$(dircolors -b)"
alias ls='ls $LS_OPTIONS'

# Custom config
export BROWSER=$(which firefox)
export EDITOR=$(which nvim)
export VISUAL=$EDITOR
export WEZTERM_CONFIG_FILE="~/.config/wezterm/config.lua"

# Alias
alias reboot="sudo systemctl reboot"
alias poweroff="sudo systemctl poweroff"
alias hibernate="echo 'Going to bed' && sudo systemctl hibernate"
alias suspend="echo 'Going to bed' && sudo systemctl suspend"

alias :q="exit"
alias vi='nvim'
alias vim='nvim'
alias edit='nvim $(fzf)'
alias view='zathura'
alias pomac='pamac'
alias capslock='xdotool key Caps_Lock'
alias keys='setxkbmap se -option caps:escape nodeadkeys'

# Just throw in the keyconfig here

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "^o" edit-command-line

# Prompt

show_ssh() {
    if [[ -n $SSH_CONNECTION ]]; then
        echo -n -e "%f%B%F{red}##%f%b"
    fi
}

source /home/ed/Code/zsh-git-prompt/zshrc.sh

show_exit_code() {
    EXIT=$?
    if [[ $EXIT -ne 255 ]]; then
        EXIT="%B%F{red}$EXIT%f%b "
    else
        EXIT=""
    fi
    echo -n -e $EXIT
}

PROMPT='$(show_ssh)%f$(git_super_status) %B%F{green}%2~%f%b %(?..%B%F{red}%?%f %b)%B%F{green}⬤%b%f '

GPG_TTY=$(tty)
export GPG_TTY
export XDG_DATA_HOME=$HOME/.local/share

export PATH=~/.local/bin:~/Apps:$PATH:

[ -f "/home/ed/.ghcup/env" ] && source "/home/ed/.ghcup/env" # ghcup-env


