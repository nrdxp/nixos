{ usr, ... }:
with usr;
{ uid            = 1000;
  description    = "Timothy DeHerrera";
  isNormalUser   = true;
  hashedPassword = pwHash.nrd;
  extraGroups    =
    [ "wheel"
      "input"
      "networkmanager"
      "adbusers"
    ];
}
