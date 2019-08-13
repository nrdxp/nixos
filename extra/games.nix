{ pkgs, ... }:
{ environment.systemPackages = with pkgs;
  [ retroarchBare black_chocobo steam ];

  # fps games on laptop need this
  services.xserver.libinput.disableWhileType = false;

  # 32-bit support needed for steam
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  # better for steam proton games
  systemd.extraConfig = "DefaultLimitNOFILE=1048576";

  # improve wine performance
  environment.sessionVariables =
  { WINEDEBUG = "-all";
  };

  # correct dualshock 4 support
  services.udev =
  { extraRules =
    ''
    # This rule is necessary for gamepad emulation
    KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"

    # DualShock 4 over USB hidraw
    KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="05c4", MODE="0666"

    # DualShock 4 wireless adapter over USB hidraw
    KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0ba0", MODE="0666"

    # DualShock 4 Slim over USB hidraw
    KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="09cc", MODE="0666"

    # DualShock 4 over bluetooth hidraw
    KERNEL=="hidraw*", KERNELS=="*054C:05C4*", MODE="0666"

    # DualShock 4 Slim over bluetooth hidraw
    KERNEL=="hidraw*", KERNELS=="*054C:09CC*", MODE="0666"
    '';
  };
}
