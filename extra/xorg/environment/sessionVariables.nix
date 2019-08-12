{ pkgs, ... }:
with pkgs;
{
  # default browser
  BROWSER                     = "qutebrowser";
  # Theme settings
  QT_QPA_PLATFORMTHEME        = "gtk2";
  XDG_CONFIG_DIRS             = "/etc/xdg";
  GDK_PIXBUF_MODULE_FILE      =
    "$(echo ${librsvg.out}/lib/gdk-pixbuf-2.0/*/loaders.cache)";
  GTK2_RC_FILES               =
    let
      gtk =
      ''
      gtk-icon-theme-name="Papirus-Adapta"
      gtk-cursor-theme-name="Adwaita"
      '';
    in
    [ ( ''${ writeText "iconrc" "${gtk}" }''
      )
      "${adapta-gtk-theme}/share/themes/Adapta/gtk-2.0/gtkrc"
      "${gnome3.gnome-themes-extra}/share/themes/Adwaita/gtk-2.0/gtkrc"
    ]
  ;
}
