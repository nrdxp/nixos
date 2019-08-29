{ ... }:
{
  users.nrd.home.file = {
    ".x" = {
      text = ''
        #!/usr/bin/env zsh

        TRAPINT() {
          exit $(( 128 + $1 ))
        }

        while true; do
          printf "%s\n" \
          "[j] XMonad" \
          "[f] RetroArch" \
          "[s] shell"

          read -sk choice

          case "$choice" in
            "j")
              exec startx -- -logfile ~/.local/share/xorg/X.0.log vt01 ;;
            "f")
              exec retroarch ;;
            "s")
              unset TRAPINT
              exec zsh
            ;;
            *)
              printf "\n[error]: '%s' %s\n%s\n" \
              $choice \
              "not valid"
            ;;
          esac
        done
      '';
      executable = true;
    };
  };
}
