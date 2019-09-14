{ usr, ... }:
let
  inherit (builtins) concatStringsSep attrValues;
  inherit (usr.tmux) pluginConf plugins tmuxline;

  tmuxConf = let
    tmux = usr.tmux."tmux.conf";

    plugin = pluginConf plugins;
  in
    concatStringsSep "\n\n"
      [ tmuxline tmux plugin ];
in
tmuxConf
