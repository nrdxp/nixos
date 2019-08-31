{ config, lib, ... }:
let
  inherit (config.services.qbittorrent) port;
  inherit (lib) mkAfter;
in
{
  imports = [ ./vpn.nix ./modules/qbittorrent.nix ];
  services.qbittorrent.enable = true;
  users.users.nrd.extraGroups = [ "qbittorrent" ];


  environment.etc."qutebrowser/config.py".text = mkAfter ''
    c.url.searchengines['to'] = 'https://torrentz2.eu/search?f={}'

    config.bind(',t', """hint all spawn curl -X POST\
      -F "urls={hint-url}"\
      -F "sequentialDownload=true"\
      http://localhost:${toString port}/api/v2/torrents/add"""
    )
  '';
}
