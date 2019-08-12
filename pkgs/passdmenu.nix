{ stdenv, glib, fetchFromGitHub, pass, python3Packages
, gobject-introspection }:
let inherit (python3Packages) python pygobject3;
in stdenv.mkDerivation rec {
  name = "passdmenu-${version}";
  version = "1.2.0";

  src = fetchFromGitHub {
    owner = "klaasb";
    repo = "passdmenu";
    rev = "v${version}";
    sha256 = "0n1k4n1h1dq26a6cz14hf7jgnkd056kkh82d2sgmh50r6mymspns";
  };

  buildInputs = [ glib python pygobject3 gobject-introspection pass python3Packages.wrapPython ];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp passdmenu.py $out/bin/passdmenu
  '';

  postFixup = ''
    makeWrapperArgs="\
      --prefix GI_TYPELIB_PATH : $GI_TYPELIB_PATH \
      --prefix PYTHONPATH : \"$(toPythonPath $out):$(toPythonPath ${pygobject3})\""
    wrapPythonPrograms
  '';


  meta = with stdenv.lib; {
    description  = "Small script to manage 'Pass' passwords with dmenu";
    homepage     = https://github.com/klaasb/passdmenu;
    license      = stdenv.lib.licenses.mit;
    platforms    = stdenv.lib.platforms.all;
  };
}
