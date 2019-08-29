{ usr, pkgs, ... }:
let
  inherit (usr.zsh) alias startrc endrc;
  inherit (pkgs) zsh-plugins fzf;
  inherit (builtins) concatStringsSep;

  zshrc = let
    zshrcPlugins = "source ${zsh-plugins}/plugins.sh\n";
    zshrcFzf = "source ${fzf}/share/fzf/key-bindings.zsh";
  in
    concatStringsSep "\n\n"
      [ startrc zshrcPlugins endrc zshrcFzf ];
in
{
  enable = true;
  promptInit = "";
  shellAliases = alias;
  interactiveShellInit = zshrc;
}
