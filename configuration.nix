{ config, ... }:
{
  # shortcut to locally defined lib to be easily passed around
  _module.args.usr = config.lib;

  imports = [
    ./common.nix
    # need exactly one device specific configuration
    ./devices/sys76-gazelle.nix
    # add anything from services dir that you'd like
    ./xtra/torrent.nix
    ./xtra/laptop.nix
    ./xtra/games.nix
    ./xtra/stubby.nix
    ./abstract/audio-ws.nix
    ./xtra/libvirtd.nix
    ./xtra/webdev.nix
    ./xtra/pulseaudio.nix
  ];
}
