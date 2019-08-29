{ usr, ... }:
let
  inherit (builtins) concatStringsSep attrValues;
  inherit (usr.tmux) conf pluginConf plugins tmuxline;

  tmuxConf = let
    tmux = concatStringsSep "\n\n"
      (attrValues conf);

    plugin = pluginConf plugins;
  in
    concatStringsSep "\n\n"
      [ tmuxline tmux plugin ];
in
{
  enable = true;
  extraTmuxConf = tmuxConf;
}
