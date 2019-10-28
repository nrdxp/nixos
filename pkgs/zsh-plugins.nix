{ stdenv, antibody, git, cacert, findutils, patchelf }:
stdenv.mkDerivation rec
{
  name = "zsh-plugins-${version}";
  version = "10-27-2019";
  src = ./zsh-plugins;
  buildInputs = [ antibody git cacert findutils patchelf ];

  installPhase = ''
    mkdir -p $out/.cache
    XDG_CACHE_HOME=$out/.cache antibody bundle < ./plugins \
    | sort \
    | sed '/pure.plugin/ { H; d; }; $ { p; x; }' \
    | sed '/zsh-syntax/ { H; d; }; $ { p; x; }' \
    | sed '/zsh-history/ { H; d; }; $ { p; x; }' \
    | sed '/zsh-vim-mode/ { H; d; }; $ { p; x; }' \
    > $out/plugins.sh
  '';
}
