{ pkgs, lib, usr, ... }:
let
  inherit (pkgs) kmod;
  inherit (lib) const;
  inherit (usr.devices) device;
  # be sure to set this to the proper device configuration before using
  rel = /etc/nixos/devices;
  devicePath = "${rel}/${device}-lsmod.tar.gz";
in
{
  overlays = let
    localmodconfig = kernel: (
      kernel.overrideAttrs (
        oldAttrs: {
          preBuild = ''LSMOD=../../lsmod make localmodconfig'';
          srcs = [ devicePath oldAttrs.src ];
          sourceRoot = oldAttrs.name;
          buildInputs = [ kmod ];

          # needed or derivation will fail assertions
          passthru = kernel.passthru;
        }
      )
    );

    linux_rt = self: super: {
      linuxPackages_latest = super.linuxPackages_latest.extend (
        const (
          ksuper: let
            kernel = localmodconfig ksuper.kernel;
          in
            {
              kernel = kernel.override {
                modDirVersionArg = ksuper.kernel.version + "-rt5";
                stdenv = self.ccacheStdenv;
                # neccessary or linux-config will stop the build
                ignoreConfigErrors = true;
              };
            }
        )
      );
    };

    ccacheWrapper = self: super: {
      ccacheWrapper = super.ccacheWrapper.override {
        extraConfig = ''
          export CCACHE_DIR=/nix/var/ccache
          export CCACHE_UMASK=007
        '';
      };
    };

    schedtoold = self: super: {
      schedtoold = super.callPackage ../../pkgs/schedtoold.nix {};
    };
  in
    [ linux_rt schedtoold ccacheWrapper ];
}
