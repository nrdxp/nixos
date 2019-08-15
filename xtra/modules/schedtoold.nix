{ config ,lib, pkgs, ... }:
with lib;
let cfg = config.services.schedtoold;
in
{
  options.services.schedtoold =
  { enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to enabled schedtoold daemon.

        Turning this on will start the schedtoold systemd service
        and provide the cpu scheduling policies described in
        /etc/schedtoold.conf.

        By default nothing is defined in this files, use configFile
        option to write your desired configuration to /etc/schedtoold.conf.
      '';
    };

    configFile = mkOption {
      type = types.lines;
      default = "";
      example = ''
        /run/current-system/sw/bin/retroarch -F -p 15
      '';
      description = ''
        the contents of /etc/schedtoold.conf
      '';
    };
  };

  config = mkIf cfg.enable {

    systemd.services."schedtoold" =
    { enable = true;
      description = "schedtoold service";
      serviceConfig =
      { Type = "forking";
        PIDFile = "/var/run/schedtoold.pid";
        User = "root";
        ExecStart =
          "${pkgs.schedtoold}/bin/schedtoold";
        ExecStop = "${pkgs.utillinux}/bin/kill -15 $MAINPID";
      };
      wantedBy = [ "multi-user.target" ];
    };

    environment.etc."schedtoold.conf" =
    { text = cfg.configFile;
    };

    environment.systemPackages = [ pkgs.schedtoold pkgs.schedtool ];
  };
}
