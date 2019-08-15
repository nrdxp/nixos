{ pkgs, ... }:
{ schedtoold =
  { enable = true;
    configFile = ''
      ${pkgs.retroarchBare}/bin/.retroarch-wrapped -F -p 15
    '';
  };

  das_watchdog.enable = true;
}
