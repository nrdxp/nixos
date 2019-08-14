{ pkgs, ... }:
# always use my vpn configuration with torrent service
{ imports = [ ./vpn.nix ./modules/qbittorrent.nix ];


  services.qbittorrent.enable = true;

  systemd.services.qbittorrent.bindsTo = ["openvpn-client" ];
  systemd.services.qbittorrent.after = ["openvpn-client" ];

  users.users.nrd.extraGroups = [ "qbittorrent" ];
}
