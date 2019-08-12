{ config, ... }:
{
  # shortcut to locally defined lib to be easily passed around
  _module.args.usr = config.lib;

  imports =
    [ ./common.nix
      # need exactly one device specific configuration
      ./devices/sys76-gazelle.nix
      # add anything from services dir that you'd like
      ./extra/torrent.nix
      ./extra/laptop.nix
      ./extra/games.nix
      ./abstract/audio-ws.nix
    ];
}
