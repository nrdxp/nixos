{ ... }:
self: super: {
  lrzip = super.lrzip.overrideAttrs (
    oldAttrs: rec {
      NIX_CFLAGS_COMPILE = "-march=native -fomit-frame-pointer";
      NIX_CXXFLAGS_COMPILE = "-march=native -fomit-frame-pointer";
    }
  );
}
