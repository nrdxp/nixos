{ usr, ... }:
{
  uid = 1000;
  description = "Timothy DeHerrera";
  isNormalUser = true;
  hashedPassword = usr.pwHash.nrd;
  extraGroups = [
    "wheel"
    "input"
    "networkmanager"
    "adbusers"
  ];
}
