{ dirs, ... }:
self: super: {
  st = super.st.override
    {
      patches = "${dirs.pkgs}/patches/st-config.patch";
    };
}
