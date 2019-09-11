{ pkgs, ... }:
let
  inherit (builtins) readFile fetchurl;
  inherit (pkgs) kak-lsp kakoune kakoune-unwrapped;
in
{
  imports = [ ./rust.nix ];
  environment.systemPackages =
    [ kakoune kak-lsp kakoune-unwrapped ];

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
    ''
    ;
  };

  nixpkgs.overlays = let
    kak = self: super: {
      kakoune = (
        super.kakoune.override {
          configure.plugins = with super.kakounePlugins; [
            (kak-fzf.override { fzf = super.skim; })
            kak-powerline
            kak-auto-pairs
            kak-vertical-selection
            kak-buffers
          ];
        }
      ).overrideAttrs (
        o: {
          src = super.fetchFromGitHub {
            owner = "nrdxp";
            repo = "kakoune";
            rev = "de6d4722debaca9b39f17a2431227a287cf9927f";
            sha256 = "0bk7cdyqpb67a2a71nh6gff8vqgdr31hsfak2kdf606kp0j5l3br";
          };
        }
      );
    };
  in
    [ kak ];
}
