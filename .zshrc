# Use powerline
USE_POWERLINE="false"
# Has weird character width
# Example:
#    is not a diamond
HAS_WIDECHARS="false"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
# if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
#   source /usr/share/zsh/manjaro-zsh-prompt
# fi

if [[ -e /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh 
fi
if [[ -e /usr/share/fzf/completion.zsh ]]; then
  source /usr/share/fzf/completion.zsh  
fi

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

show_git_status() {
    IS_GIT=$( if [[ -d .git ]]; then echo "GIT"; fi )
    GIT=""
    if ! [[ -z $IS_GIT ]]; then
        GIT_BRANCH=$( git rev-parse --abbrev-ref HEAD )

        $(git diff --no-ext-diff --quiet)
        if [[ $? -eq 0 ]]; then
            GIT="%f[%B$GIT_BRANCH%b]"
        else
            GIT="%f<%B%F{red}$GIT_BRANCH%f%b>"
        fi
    fi
    echo -n -e "$GIT"
}

show_ssh() {
    if [[ -n $SSH_CONNECTION ]]; then
        echo -n -e "%f%B%F{red}##%f%b"
    fi
}

prompt() {
    EXIT=$?
    if [[ $EXIT -ne 0 ]]; then
        EXIT="%B%F{red}$EXIT%f%b"
    else
        EXIT=""
    fi
    
    echo -n -e "$(show_ssh)%f $(show_git_status) %B%F{green}%2~%f%b $EXIT%B%F{green}⏺%b%f "
}

export PROMPT="$(prompt)"

GPG_TTY=$(tty)
export GPG_TTY
export XDG_DATA_HOME=$HOME/.local/share

export PATH=~/.local/bin:~/Apps:$PATH:

[ -f "/home/ed/.ghcup/env" ] && source "/home/ed/.ghcup/env" # ghcup-env


