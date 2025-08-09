#! /bin/bash

# backup copy of nvim config
cp $HOME/.config/nvim $HOME/.config/nvim.bak
# remove and clean current config, plugins and runtime files
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
