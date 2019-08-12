{ ... }:
self: super:
{ htop = super.htop.overrideAttrs
  ( oldAttrs:
    {
      patches = ./pkgs/patches/htop-vim-keybindings.patch;
    }
  );
}
