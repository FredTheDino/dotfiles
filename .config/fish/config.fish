if status is-interactive
# Commands to run in interactive sessions can go here
end

bind ctrl-o 'edit_command_buffer'

set --global EDITOR 'nvim'
set --global VISUAL 'nvim'
set -gx PATH /home/ed/Apps/ $PATH

alias cat=bat
alias less=bat
alias more=bat

set -x MANPAGER "bat -plman"
fzf_configure_bindings

function fish_greeting
    echo (set_color red)(echo " ><> ")(set_color green)Swim on(set_color blue)(echo " ><>")(set_color --reset)
end
