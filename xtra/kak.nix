{ pkgs, ... }:
let
  inherit (builtins) readFile fetchurl;
  inherit (pkgs) kak-lsp kakoune kakounePlugins kakoune-unwrapped;
in
{
  imports = [ ./rust.nix ];
  environment.systemPackages = let
    kak = kakoune.override {
      configure.plugins = with kakounePlugins; [
        (kak-fzf.override { fzf = pkgs.skim; })
        kak-powerline
        kak-auto-pairs
        kak-vertical-selection
        kak-buffers
      ];
    };
  in
    [ kak kak-lsp kakoune-unwrapped ];

  programs.zsh.shellAliases = {
    k = "kak -u /etc/xdg/kak";
  };
  environment.etc = {
    "xdg/kak/kakrc".source = ./kak/kakrc;
    "xdg/kak/autoload/plugins".source = ./kak/plugins;
    "xdg/kak/autoload/default".source = "${kakoune-unwrapped}/share/kak/rc";
    "xdg/kak/autoload/move-line.kak".text = readFile (
      fetchurl
        https://raw.githubusercontent.com/alexherbo2/move-line.kak/master/rc/move-line.kak
    )
    + ''
      map global normal "'" ': move-line-below %val{count}<ret>'
      map global normal "<a-'>" ': move-line-above %val{count}<ret>'
    ''
    ;
    "xdg/kak/autoload/kakboard.kak".text = readFile (
      fetchurl
        https://raw.githubusercontent.com/lePerdu/kakboard/master/kakboard.kak
    )
    + ''
      hook global WinCreate .* %{ kakboard-enable }
    '';
  };
}
