{ ... }:
{
  # correct dualshock 4 support
  udev.extraRules =
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
}
