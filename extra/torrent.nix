{ pkgs, ... }:
# always use my vpn configuration with torrent service
{ imports = [ ./vpn.nix ./modules/qbittorrent.nix ];


  services.qbittorrent.enable = true;

  users.users.nrd.extraGroups = [ "qbittorrent" ];
}
