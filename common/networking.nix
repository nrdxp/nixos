{ usr, ... }:
{
  hostName = usr.devices.current;

  networkmanager = {
    enable = true;
  };
}
