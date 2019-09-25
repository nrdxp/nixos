{ stdenv, patchelf, gcc, glib, nspr, nss, unzip, ... }:
let
  inherit (builtins) fetchurl;
  inherit (stdenv) lib mkDerivation;
  mkrpath = p: "${lib.makeSearchPathOutput "lib" "lib64" p}:${lib.makeLibraryPath p}";
in
mkDerivation rec {
  name = "${pname}-${version}";
  pname = "widevine-cdm";
  version = "4.10.1440.19";

  src = fetchurl {
    url = "https://dl.google.com/widevine-cdm/${version}-linux-x64.zip";
    sha256 = "1rzsjy2bcsn8r3pspapckq31hhidw2k694apd87q8dz1jjgnm9x3";
  };

  unpackCmd = "unzip -d ./src $curSrc";

  nativeBuildInputs = [ unzip ];

  PATCH_RPATH = mkrpath [ gcc.cc glib nspr nss ];

  patchPhase = ''
    patchelf --set-rpath "$PATCH_RPATH" libwidevinecdm.so
  '';

  installPhase = ''
    install -vD libwidevinecdm.so \
      "$out/lib/libwidevinecdm.so"
  '';
}
