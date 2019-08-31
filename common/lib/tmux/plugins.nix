{ pkgs, ... }:
with pkgs.tmuxPlugins;
[
  copycat
  open
  resurrect
  yank
  vim-tmux-navigator
]
