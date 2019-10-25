{ dirs, ... }:
self: super:
{
  htop = super.htop.overrideAttrs (
    oldAttrs: {
      patches = "${dirs.pkgs}/patches/htop-vim-keybindings.patch";
    }
  );
}
