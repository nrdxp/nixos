args@{ config, ... }:
{
  # shortcut to locally defined lib to be easily passed around
  _module.args.usr = config.lib;

  imports = [
    # bare minimum
    ./common.nix

    # need exactly one device specific configuration
    ./devices/sys76-gazelle.nix

    # 'abstract' combines multiple 'ad hoc' configurations from xtra
    (
      import ./abstract/workstation.nix (
        args
        // { withWM = ./xtra/sway.nix; }
      )
    )

    # add ad hoc configuration from 'xtra'
    ./xtra/torrent.nix
    ./xtra/laptop.nix
    ./xtra/games.nix
    ./xtra/java.nix
  ];
}
