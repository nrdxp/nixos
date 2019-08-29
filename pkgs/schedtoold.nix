{ stdenv, fetchFromGitHub }:
stdenv.mkDerivation {
  name = "schedtoold";
  src = fetchFromGitHub {
    owner = "aw1cks";
    repo = "schedtoold";
    rev = "5a8c2a935d389309bff5568fabc4bca224348153";
    sha256 = "0w6rhc4mkr9hq9j0z1dlz65vd39cp2kxwb85r9b8xgy56ymp197h";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp schedtoold $out/bin/.schedtoold-wrapped
    echo -e "#!/bin/sh\nPATH=/run/current-system/sw/bin $out/bin/.schedtoold-wrapped \
    -p /var/run/schedtoold.pid" > $out/bin/schedtoold
    chmod 555 $out/bin/schedtoold
  '';

  # buildInputs = [ pkgconfig alsaLib x11 ];
  hardeningDisable = [ "format" ];
}
