{ config, options, pkgs, ... }:
let
  inherit (pkgs) alacritty dzvol qt5 waybar wl-clipboard;
  inherit (qt5) qtwayland;
  inherit (config.hardware) pulseaudio;
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
           (waybar.override { pulseSupport = pulseaudio.enable; })
         ]
      ;
  };

  environment.etc = {
    "sway/config".text = import ./sway/config.nix {
      inherit pkgs;
    };
    "xdg/waybar".source = ./sway/waybar;
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
    overlay = self: super: {
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
      wl-clipboard = super.wl-clipboard.overrideAttrs (
        o: {
          src = super.fetchFromGitHub {
            owner = "bugaevc";
            repo = "wl-clipboard";
            rev = "c010972e6b0d2eb3002c49a6a1b5620ff5f7c910";
            sha256 = "020l3jy9gsj6gablwdfzp1wfa8yblay3axdjc56i9q8pbhz7g12j";
          };
        }
      );
    };
  in
    [ overlay ];
}
