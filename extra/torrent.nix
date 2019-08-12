{ pkgs, ... }:
# always use my vpn configuration with torrent service
{ imports = [ ./vpn.nix ];

  services.deluge =
  { enable = true;
    declarative = true;
    config =
    { download_location = "/srv/torrents/";
      random_outgoing_ports = true;
      random_port = true;
      # currently requires placing plugin into the plugin folder manually
      enabled_plugins = [ "SequentialDownload" ];
    };
    authFile =
      "${pkgs.writeText "deluge-auth"
        "localclient:f9dcc103edd64d5c649b70ee46b6d9543dda8b5d:10"
      }";
  };
}
