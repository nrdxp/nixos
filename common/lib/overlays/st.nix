{ ... }:
self: super:
{ st = super.st.override
  {
    patches = ./pkgs/patches/st-config.patch;
  };
}
