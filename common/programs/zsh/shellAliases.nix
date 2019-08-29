{ ... }:
{
  # editor shortcut
  v = "$EDITOR";

  # cd shortcuts
  ".." = "cd ..";
  "..." = "cd ../..";
  "...." = "cd ../../..";
  "....." = "cd ../../../..";

  # grep shortcut
  gi = "grep -Ei";

  z = "zathura";

  # use bat instead of cat
  cat = "bat";

  # list all bind mounts -- TODO not foolproof
  bml = "print \"bind mounts:\" \\
             && findmnt | gi \"\\[\"";

  dff = "diff --suppress-common-lines -y";

  # nix shortcuts
  nxr = "nix-store \\
              --verify \\
              --repair \\
              --check-contents";
  ndt = "nix-store -q --tree";
  nyu = "nix-channel --update && nix-env -u";
  ni = "nix-env -f \"<nixpkgs>\" -iA";

  # wireless connections
  wi = "watch -n1 iwconfig";

  # nixos-rebuild alias
  nxsrbd = "sudo nixos-rebuild";

  # echo curret ip address of the system
  myip = "dig +short \\
             myip.opendns.com @208.67.222.222 2>&1";

  # exa aliases
  ls = "exa";
  l = "ls -l --git --group --header --color-scale";
  lx = "l -Gx";
  la = "l --all";
  lax = "la -Gx";
  t = "l -T";
  ta = "la -T";

  # restart zsh
  rz = "exec zsh";

  # tmux alias
  tm = "tmux new-session -s $USER";
  tma = "tmux attach -t $USER";

  # human readable
  df = "df -h";

  # use dust instead of du
  du = "dust";

  # sudo alias to bring in environment
  si = "env sudo -i";
  sudo = "sudo -E ";
  se = "sudoedit";

  # open retroarch in kms mode on vt9
  rkms = "DISPLAY= sudo openvt -swf -c9 -- retroarch";

  # systemd aliases
  ctl = "systemctl";
  stl = "env sudo systemctl";
  utl = "systemctl --user";
  stt = "systemctl status";
  utt = "systemctl --user status";
  ut = "systemctl --user start";
  reut = "systemctl --user restart";
  un = "systemctl --user stop";
  up = "env sudo systemctl start";
  reup = "env sudo systemctl restart";
  dn = "env sudo systemctl stop";
  jctl = "journalctl";
}
