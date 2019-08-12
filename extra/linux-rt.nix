# If included in configuration.nix this will build the linux kernel patched
# with the realtime linux patchset. Also native compiler optimizations will be
# used and only modules defined in /etc/nix/devices/<your-device>-lsmod.tar.gz
# will be built to save time.
args@{ pkgs, usr, ... }:
let recImport = import ../fn/recImport.nix args;
in
{ imports = [ ./modules/schedtoold.nix ];

  hardware.pulseaudio.daemon.config =
    { realtime-scheduling = "yes"; };
} // recImport ./linux-rt
