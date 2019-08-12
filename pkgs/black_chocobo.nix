{ stdenv, cmake, qtbase, qttools, fetchFromGitHub }:

with stdenv.lib;

stdenv.mkDerivation rec {
  name = "black-chocobo-${version}";
  version = "1.9.91";
  src = fetchFromGitHub {
    repo = "blackchocobo";
    owner = "sithlord48";
    rev = "v${version}";
    sha256 = "0rzk90hpsr9njq6dw2kc969w4rgnwggifck5dikalwn1il0giaxd";
  };
  buildInputs = [ cmake qtbase qttools ];

  meta = {
    description = "Final Fantasy VII Save Editor";
    license = licenses.publicDomain;
    platforms = platforms.unix;
  };
}
