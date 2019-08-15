{ ... }:
{ slock.enable = true;

  zsh.loginShellInit =
  ''
  if [[ $TTY == "/dev/tty1" ]]; then

    TRAPINT() {
      exit $(( 128 + $1 ))
    }

    while true; do
      printf "%s\n" \
      "[j] XMonad" \
      "[f] RetroArch" \
      "[s] shell"

      read -sk1 choice

      case "$choice" in
        "j")
          exec startx ;;
        "f")
          exec retroarch ;;
        "s")
          unset TRAPINT
          break
        ;;
        *)
          printf "\n[error]: '%s' %s\n%s\n" \
          $choice \
          "not valid"
        ;;
      esac
    done
  fi
  '';
}
