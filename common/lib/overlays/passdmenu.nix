{ dirs, ... }:
self: super: {
  passdmenu = super.callPackage "${dirs.pkgs}/passdmenu.nix" {};
}
