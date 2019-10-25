args@{ config
, usr ? config.lib
, dirs ? import ./lib/directories.nix
, ...
}:
{
  imports = [
    # bare minimum
    ./common.nix

    # need exactly one device specific configuration
    ./devices/sys76-gazelle.nix

    # 'abstract' combines multiple ad hoc configurations from xtra
    (
      import ./xtra/abstract/workstation.nix (
        args
        // { withWM = ./xtra/sway.nix; }
      )
    )

    # add ad hoc configurations from 'xtra'
    ./xtra/torrent.nix
    ./xtra/laptop.nix
    ./xtra/games.nix
    ./xtra/java.nix
  ];
}
