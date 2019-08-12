{ usr, ... }:
with usr.tmux;
let
  tmuxConf = with builtins;
  let
    tmuxlineConf = tmuxline;

    tmuxConf     = with conf;
      concatStringsSep "\n\n"
      [ navigator tmux yank-override ];

    pluginConf   = usr.tmux.pluginConf plugins;
  in concatStringsSep "\n\n"
    [ tmuxlineConf tmuxConf pluginConf ];
in
{ enable        = true;
  extraTmuxConf = tmuxConf;
}
