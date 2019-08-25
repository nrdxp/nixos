{ ... }:
let url = https://raw.githubusercontent.com/StevenBlack/hosts/master;
in
{
  networking.extraHosts = with builtins;
      readFile
      ( fetchurl ( url + "/hosts" )
      );

}
