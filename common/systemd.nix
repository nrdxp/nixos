{ pkgs, ... }:
let
  inherit (pkgs) bash iputils systemd writeScript;
  pingScript = ''
    #!${bash}/bin/sh

    isactive=$(${systemd}/bin/systemctl is-active network-online.target)

    echo $isactive
    if [[ $isactive == "inactive" ]] && ${iputils}/bin/ping -c1 nrdxp.dev &>/dev/null; then
      ${systemd}/bin/systemctl start network-online.target
    elif [[ $isactive == "active" ]] && ! ${iputils}/bin/ping -c1 nrdxp.dev &>/dev/null; then
      ${systemd}/bin/systemctl stop network-online.target
    fi
  '';
in
{
  # stop network-online target if not really online
  services.network-ping = {
    enable = true;
    description = "ping for live network access";
    serviceConfig = {
      ExecStart = "${writeScript "ping-network.sh" pingScript}";
    };
  };

  timers.network-ping = {
    enable = true;
    description = "ping for live network access every 12 seconds";
    timerConfig = {
      OnCalendar = "*:*:0/12";
    };
    wantedBy = [ "timers.target" ];
    after = [ "network-online.target" ];
  };
}
