{ ... }:
{ zsh.loginShellInit =
  ''


  if [[ $TTY == "/dev/tty1" ]]; then

    TRAPINT() {
      exit $(( 128 + $1 ))
    }

    while true; do
      printf "%s\n" \
      "[1] XMonad" \
      "[2] RetroArch" \
      "[3] shell"

      read -s choice

      case "$choice" in
        1)
          exec startx ;;
        2)
          exec retroarch ;;
        3)
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
