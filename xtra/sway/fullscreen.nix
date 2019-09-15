{ pkgs, ... }:
let
  inherit (pkgs) bash jq sway utillinux;
  pid = "/run/user/\${UID}/swayidle.pid";
  fsWindows = "\${#fs_windows[@]}";
in
''
  #!${bash}/bin/bash

  ${sway}/bin/swaymsg fullscreen toggle

  if [[ -r "${pid}" ]] && [[ -d "/proc/$(<${pid})" ]]; then
    fs_windows=(
      $(${sway}/bin/swaymsg -t get_tree \
      | ${jq}/bin/jq '..| select(.fullscreen_mode==1?) | .name')
    )

    if [[ "${fsWindows}" != 0 ]]; then
      ${utillinux}/bin/kill -STOP $(<${pid})
    else
      ${utillinux}/bin/kill -CONT $(<${pid})
    fi
  fi
''
