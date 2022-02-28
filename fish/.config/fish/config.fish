if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
    alias v="nvim"
    alias vrc="nvim ~/.config/nvim/init.lua"
    export EDITOR=/usr/bin/nvim
    export SUDO_EDITOR=/usr/bin/nvim
end
# THEME PURE #
set fish_function_path /home/eli/.config/fish/functions/theme-pure/functions/ $fish_function_path
source /home/eli/.config/fish/functions/theme-pure/conf.d/pure.fish
