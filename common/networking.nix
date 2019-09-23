{ usr, ... }:
{
  hostName = usr.device.name;

  networkmanager = {
    enable = true;
  };
}
