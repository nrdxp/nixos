{ stdenv }:
stdenv.mkDerivation {
  name = "default-cursor";
  src = ./cursor.tar.gz;

  installPhase = ''
    mkdir -p $out/share/icons/default
    mv ./index.theme $out/share/icons/default
  '';
}
