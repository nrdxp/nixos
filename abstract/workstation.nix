{ lib, withWM ? ../xtra/xorg.nix, ... }:

assert lib.asserts.assertOneOf "withWM" withWM [
  ../xtra/xorg.nix
  ../xtra/sway.nix
];

{
  imports = [
    ../xtra/adblocking.nix
    ../xtra/make-linux-fast-again.nix
    ../xtra/stubby.nix
    ../xtra/libvirtd.nix
    ../xtra/webdev.nix
    ../xtra/pulseaudio.nix
    withWM
  ];
}
