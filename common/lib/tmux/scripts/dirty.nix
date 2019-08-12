{ pkgs, ... }:
''
  #!${pkgs.gawk}/bin/awk -f

  /Dirty/ {if ($2 > 1024) { $2 = int($2 / 1024); print $2"mB"} else {print $2$3}}
''
