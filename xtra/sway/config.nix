{ pkgs, ... }:
let
  inherit (pkgs) adapta-backgrounds bash writeScript;
  inherit (builtins) readFile;
  swayidle = ''
    ${writeScript "swayidle.sh"
    ''
      #!${bash}/bin/bash
      ${readFile ./swayidle.sh}
    ''}
  '';
  fullscreen = ''
    ${writeScript "fullscreen.sh"
    (import ./fullscreen.nix { inherit pkgs; })
  }
  '';
in
''
  ${readFile ./config}

  # set background
  output * bg ${adapta-backgrounds}/share/backgrounds/adapta/tri-fadeno.jpg fill

  ### Idle configuration
  
  exec ${swayidle}
  # this script writes pid to a file so we can send STOP and CONT signals to it
  # when entering fullscreen mode so as not to interrupt mpv and the like
  #
  #

  # Make the current focus fullscreen
  bindsym $mod+f exec ${fullscreen}
''
