{ ... }:
let
  inherit (builtins) readFile fetchurl;
  url = https://raw.githubusercontent.com/StevenBlack/hosts/master;
in
{
  networking.extraHosts = readFile (
    fetchurl (url + "/hosts")
  );
}
