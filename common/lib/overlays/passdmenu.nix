{ ... }:
self: super: {
  passdmenu = super.callPackage ./pkgs/passdmenu.nix {};
}
