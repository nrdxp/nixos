{ pkgs, ... }:
let
  inherit (pkgs) gawk gnugrep dnsutils networkmanager systemd zsh;
in
''
  #!${zsh}/bin/zsh

  if ! ${dnsutils}/bin/dig +short +timeout=1 +tries=1 \
      myip.opendns.com @208.67.222.222 2>&1 \
    | ${gnugrep}/bin/grep -E '[0-9]*\.[[0-9]*\.[0-9]*\.[0-9]*' \
    | read ip_address

  then
    printf "✘" # \u2718

  else
    readonly signal_strength=$(${networkmanager}/bin/nmcli device wifi list 2>&1 \
    | ${gawk}/bin/awk '/^\*/ {print $(NF-1)}')

    if [[ -n $signal_strength ]]; then
      if ${systemd}/bin/systemctl is-active --quiet openvpn-client.service; then
        printf "🔑$signal_strength"
      else
        printf "📡$signal_strength"
      fi
    else
      printf "$ip_address"

    fi
  fi
''
