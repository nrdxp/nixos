{ pkgs, ... }:
let
  inherit (pkgs) bash jq sway utillinux;
  pid = "/run/user/\${UID}/swayidle.pid";
in
''
  #!${bash}/bin/bash

  ${sway}/bin/swaymsg fullscreen toggle

  # this loops sends SIGSTOP to swayidle if switching to fullscreen
  if [[ -r "${pid}" ]] && [[ -d /proc/$(<${pid}) ]]; then
    ${sway}/bin/swaymsg -t get_tree \
    | ${jq}/bin/jq '..|.fullscreen_mode?' \
    | while read mode; do
        [[ $mode == 1 ]] \
          && ${utillinux}/bin/kill -STOP $(<${pid}) \
          && exit 0
      done
    # if the loop failed then we are not in fullscreen so continue swayidle
    [[ $? == 0 ]] || ${utillinux}/bin/kill -CONT $(<${pid})
  fi
''
