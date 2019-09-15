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

  services.redshift = {
    enable = true;
    brightness.night = "0.7";
    temperature.night = 3200;
  };

  location = {
    latitude = 38.833881;
    longitude = -104.821365;
  };

  nixpkgs.overlays = let
    redshift_ = self: super: {
      redshift = super.redshift.overrideAttrs (
        o: {
          src = super.fetchFromGitHub {
            owner = "CameronNemo";
            repo = "redshift";
            rev = "39c162ca487a59857c2eac231318f4b28855798b";
            sha256 = "1in27draskwwi097wiam26bx2szcf58297am3gkyng1ms3rz6i58";
          };
        }
      );
    };
  in
    [ redshift_ ];
}
