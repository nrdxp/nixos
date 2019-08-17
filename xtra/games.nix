{ pkgs, ... }:
{ imports = [ ./xorg.nix ./home.nix ./games ];
  environment.systemPackages = with pkgs;
  [ retroarchBare black_chocobo steam ];

  # fps games on laptop need this
  services.xserver.libinput.disableWhileTyping = false;

  # 32-bit support needed for steam
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  # better for steam proton games
  systemd.extraConfig = "DefaultLimitNOFILE=1048576";

  # improve wine performance
  environment.sessionVariables =
  { WINEDEBUG = "-all";
  };
}
