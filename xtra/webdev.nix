{ pkgs, ... }:
{ programs.npm.enable = true;
  environment.systemPackages = with pkgs;
  [ yarn nodejs_latest ];
}
