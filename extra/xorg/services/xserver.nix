{ ... }:
{ enable = true;
  layout = "us";
  dpi    = 96;

  libinput =
  { enable             = true;
    disableWhileTyping = true;
    accelSpeed         = "1.0";
  };

  multitouch.enable = true;

  displayManager =
  {
    lightdm =
    { enable = true;
      autoLogin.enable = true;
      autoLogin.user = "nrd";
    };
  };

  windowManager =
  {
    default = "xmonad";

    xmonad =
    { enable                 = true;
      enableContribAndExtras = true;
    };
  };

  desktopManager =
  { xterm.enable   = false;
    default        = "none";
    wallpaper.mode = "fill";
  };
}
