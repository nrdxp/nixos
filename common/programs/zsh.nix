{ usr, pkgs, ... }:
with usr.zsh;
let
  zshAliases = alias;

  zshrc      = with pkgs; with builtins;
  let
    zshrcStart   = startrc;
    zshrcPlugins = "source ${zsh-plugins}/plugins.sh\n";
    zshrcEnd     = endrc;
    zshrcFzf     = "source ${fzf}/share/fzf/key-bindings.zsh";
  in concatStringsSep "\n\n"
    [ zshrcStart zshrcPlugins zshrcEnd zshrcFzf ];
in
{ enable               = true;
  promptInit           = "";
  shellAliases         = zshAliases;
  interactiveShellInit = zshrc;
}
