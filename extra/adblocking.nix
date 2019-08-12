{ ... }:
let url = https://raw.githubusercontent.com/StevenBlack/hosts/master;
in
{
  networking.extraHosts = with builtins;
      readFile
      ( fetchurl ( url + "/alternates/fakenews-gambling-porn-social/hosts" )
      );

}
