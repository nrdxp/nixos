args@{ pkgs, usr, ... }:
let recImport = import ./fn/recImport.nix args;
in
{
  documentation.dev.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  sound.enable = true;

  time.timeZone = "America/Denver";
}
//
recImport ./common
