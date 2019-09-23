{ config, pkgs, ... }:
let
  inherit (pkgs) writeScript mpv;
  inherit (builtins) readFile;
  max = "height<=1080";
  mpvBin =
    ''${mpv}/bin/mpv --ytdl-format="bestvideo[${max}]+bestaudo/best[${max}]"'';
in
''
  ${readFile ./_config.py}

  # Editor (and arguments) to use for the `open-editor` command. The
  # following placeholders are defined: * `{file}`: Filename of the file
  # to be edited. * `{line}`: Line in which the caret is found in the
  # text. * `{column}`: Column in which the caret is found in the text. *
  # `{line0}`: Same as `{line}`, but starting from index 0. * `{column0}`:
  # Same as `{column}`, but starting from index 0.
  # Type: ShellCommand
  c.editor.command = [
  '${ writeScript "quteditor"
    ( readFile ./scripts/quteditor ) }', '{file}', '{line}G{column0}l'
  ]

  config.bind(',p', 'spawn --userscript qute-pass')
  config.bind(',m', 'hint links spawn ${mpvBin} {hint-url}')
  config.bind(',v', 'spawn -d ${mpvBin} {url}')
''
