{ lib, ... }:
let
  inherit (builtins) concatStringsSep;
  inherit (lib.strings) removePrefix;
in
plugins:
  concatStringsSep "\n\n" (
    map (
      plugin: let
        name = removePrefix "tmuxplugin-" plugin.name;
      in
        "run-shell ${plugin}/share/tmux-plugins/${name}/${name}.tmux"
    ) plugins
  )
