{ pkgs, ... }:
{ defaultUserShell = pkgs.zsh;
  mutableUsers     = false;
}
