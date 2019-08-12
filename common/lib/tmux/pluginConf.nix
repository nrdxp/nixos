{ ... }:
with builtins;
plugins:
concatStringsSep "\n\n"
( map
  (
    plugin:
      let
        name = replaceStrings ["tmuxplugin-"] [""] plugin.name;
      in
        "run-shell ${plugin}/share/tmux-plugins/${name}/${name}.tmux"
  ) plugins
)
