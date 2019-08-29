{ ... }:
{
  polkit.extraConfig = ''
    polkit.addRule(function(a, s) {
      if (a.id = 'xf86-video-intel-backlight-helper' && s.isInGroup('users'))
        return polkit.Result.YES;
    });
  '';
}
