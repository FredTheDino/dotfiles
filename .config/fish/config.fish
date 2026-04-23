if status is-interactive
# Commands to run in interactive sessions can go here
end

set -x MANPAGER "bat -plman"
fzf_configure_bindings
