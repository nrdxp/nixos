{ pkgs, usr, ... }:
let
  inherit (pkgs) widevine writeScript mpv;
  inherit (builtins) readFile;
  inherit (usr.device) screen;
  max = "height<=${toString screen}";
  mpvBin =
    ''${mpv}/bin/mpv --ytdl-format="bestvideo[${max}]+bestaudo/best[${max}]"'';
in
''
  ${readFile ./_config.py}

  c.qt.args.append('widevine-path=${widevine}/lib/libwidevinecdm.so')

  c.editor.command = [
  '${ writeScript "quteditor"
    ( readFile ./scripts/quteditor ) }', '{file}', '{line}G{column0}l'
  ]

  config.bind(',p', 'spawn --userscript qute-pass')
  config.bind(',m', 'hint links spawn ${mpvBin} {hint-url}')
  config.bind(',v', 'spawn -d ${mpvBin} {url}')
''
