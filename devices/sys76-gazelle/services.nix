{ ... }:
{
  # enable tearfree
  xserver.extraConfig = ''
    Section "OutputClass"
      Identifier "Intel Graphics"
      MatchDriver "i915"
      Driver "intel"
      Option "TearFree" "true"
    EndSection
  '';

  xserver.videoDrivers = [ "intel" "modesetting" ];
}
