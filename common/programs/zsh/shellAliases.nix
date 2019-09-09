{ config, pkgs, lib, ... }:
let
  inherit (pkgs) bat coreutils diffutils dnsutils du-dust gawk gnugrep lsd nix
    procs tmux systemd utillinux zathura zsh
    ;
  inherit (lib) mkIf;
  ifSudo = string: mkIf config.security.sudo.enable string;
in
{
  # list aliases
  aliases = ''${gawk}/bin/awk -F"[ =]" '/^alias / {print $2":"; $1="";$2=""; print $0}' /etc/zshrc'';
  # editor shortcut
  v = "$EDITOR";

  # cd shortcuts
  ".." = "cd ..";
  "..." = "cd ../..";
  "...." = "cd ../../..";
  "....." = "cd ../../../..";

  # grep shortcut
  gi = "${gnugrep}/bin/grep -Ei";

  z = "${zathura}/bin/zathura";

  # use bat instead of cat
  cat = "${bat}/bin/bat";

  # use procs for ps
  ps = "${procs}/bin/procs";

  # list all bind mounts -- TODO not foolproof
  bml = "print \"bind mounts:\" \\
             && ${utillinux}/bin/findmnt | gi \"\\[\"";

  dff = "${diffutils}/bin/diff --suppress-common-lines -y";

  # nix shortcuts
  nxr = "${nix}/bin/nix-store \\
              --verify \\
              --repair \\
              --check-contents";
  ndt = "${nix}/bin/nix-store -q --tree";
  ni = "${nix}/bin/nix-env -f \"<nixpkgs>\" -iA";

  # nixos-rebuild alias
  nxsrbd = ifSudo "sudo nixos-rebuild";

  # echo curret ip address of the system
  myip = "${dnsutils}/bin/dig +short \\
             myip.opendns.com @208.67.222.222 2>&1";

  # lsd aliases
  ls = "${lsd}/bin/lsd";
  l = "ls -l --total-size";
  la = "l -lA --total-size";

  # restart zsh
  rz = "exec ${zsh}/bin/zsh";

  # tmux alias
  tm = "${tmux}/bin/tmux new-session -s $USER";
  tma = "${tmux}/bin/tmux attach -t $USER";

  # human readable
  df = "${coreutils}/bin/df -h";

  # use dust instead of du
  du = "${du-dust}/bin/dust";

  # sudo alias to bring in environment
  si = ifSudo "env sudo -i";
  sudo = ifSudo "sudo -E ";
  se = ifSudo "sudoedit";

  # systemd aliases
  ctl = "${systemd}/bin/systemctl";
  stl = ifSudo "sudo ${systemd}/bin/systemctl";
  utl = "${systemd}/bin/systemctl --user";
  stt = "${systemd}/bin/systemctl status";
  utt = "${systemd}/bin/systemctl --user status";
  ut = "${systemd}/bin/systemctl --user start";
  reut = "${systemd}/bin/systemctl --user restart";
  un = "${systemd}/bin/systemctl --user stop";
  up = ifSudo "sudo ${systemd}/bin/systemctl start";
  reup = ifSudo "sudo ${systemd}/bin/systemctl restart";
  dn = ifSudo "sudo ${systemd}/bin/systemctl stop";
  jctl = "${systemd}/bin/journalctl";
}
