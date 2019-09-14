{ options, pkgs, ... }:
let
  inherit (pkgs) qt5 alacritty dzvol wl-clipboard;
  inherit (qt5) qtwayland;
in
{
  programs.sway = {
    enable = true
      ;
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      # needs qt5.qtwayland in systemPackages
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      # Fix for some Java AWT applications (e.g. Android Studio),
      # use this if they aren't displayed properly:
      export _JAVA_AWT_WM_NONREPARENTING=1    
    '';
    extraPackages = options.programs.sway.extraPackages.default
      ++ [
           qtwayland
           alacritty
           dzvol
           wl-clipboard
         ]
      ;
  };

  environment.etc."sway/config".text = import ./sway/config.nix {
    inherit pkgs;
  };
}
