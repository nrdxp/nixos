{ ... }:
{
  slock.enable = true;

  zsh.loginShellInit = ''
    if [[ $TTY == "/dev/tty1" ]]; then
      if [[ -x ~/.x ]]; then
        exec ~/.x
      else
        exec startx -- -logfile ~/.local/share/xorg/X.0.log vt01
      fi
    fi
  '';

  zsh.shellAliases = {
    feh = "feh --conversion-timeout 0";
  };
}
