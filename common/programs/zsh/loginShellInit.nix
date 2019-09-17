{ config, lib, pkgs, ... }:
let
  inherit (builtins) elem;
  inherit (config) programs services environment;
  inherit (programs) sway;
  inherit (services) xserver;
  inherit (lib.strings) optionalString;
  inherit (pkgs) retroarchBare writeScript zsh;

  fString = optionalString (elem retroarchBare environment.systemPackages);
  fOpt = fString ''"[f] RetroArch"'';
  fExec = fString ''
    "f")
      exec retroarch ;;
  '';

  jString = optionalString xserver.enable;
  jOpt = jString ''"[j] XMonad"'';
  jExec = jString ''
    "j")
      XINITRC=${writeScript "xinitrc" "exec xmonad"} exec startx ;;
  '';

  sString = optionalString sway.enable;
  sOpt = sString ''"[s] Sway"'';
  sExec = sString ''
    "s")
      exec sway ;;
  '';
in
optionalString (
  ! (
    (fOpt == "")
    && (jOpt == "")
    && (sOpt == "")
  )
) ''
  TRAPINT() {
    exit $(( 128 + $1 ))
  }

  while true; do
    printf "%s\n" \
    ${jOpt} \
    ${fOpt} \
    ${sOpt} \
    "[q] drop to shell"

    read -sk choice

    case "$choice" in
      ${jExec}
      ${fExec}
      ${sExec}
      "q")
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
''
