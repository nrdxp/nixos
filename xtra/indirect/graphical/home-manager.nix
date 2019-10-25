{ pkgs, ... }:
{
  users.nrd.home.file = {
    ".local/share/qutebrowser/userscripts".source =
      ./lib/qutebrowser/scripts;

    ".config/qutebrowser/config.py" = {
      text = "";

      # install spellchecker
      onChange = ''
        ${pkgs.qutebrowser}/share/qutebrowser/scripts/dictcli.py install en-US
        rm $HOME/.config/qutebrowser/config.py
      '';
    };
  };
}
