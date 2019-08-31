{ pkgs, ... }:
''
  # put yank command here to override tmux yank command
  bind -T copy-mode-vi 'y' send-keys -X copy-pipe '${pkgs.xsel}/bin/xsel -ib' \; send -X clear-selection
''
