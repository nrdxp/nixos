{ lib, withWM ? ../xorg.nix, ... }:

assert lib.asserts.assertOneOf "withWM" withWM [
  ../xorg.nix
  ../sway.nix
];

{
  imports = [
    ../adblocking.nix
    ../make-linux-fast-again.nix
    ../stubby.nix
    ../libvirtd.nix
    ../webdev.nix
    ../pulseaudio.nix
    withWM
  ];
}
