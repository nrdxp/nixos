{ pkgs, ... }:
# always use my vpn configuration with torrent service
{ imports = [ ./vpn.nix ];

  services.transmission =
  { enable   = true;
    settings =
    { download-dir = "/srv/torrents/";
      incomplete-dir-enabled = false;
      rpc-whitelist = "127.0.0.1,192.168.8.*";
      rpc-whitelist-enabled = true;
      peer-port-random-on-start = true;
      port-forwarding-enabled = false;
      # severely hinders speed for some reason
      utp-enabled = false;
    };
  };

  users.users.nrd.extraGroups = [ "transmission" ];
}
