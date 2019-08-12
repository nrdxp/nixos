{ fetchFromGitHub, vimUtils, zip, vim }:
vimUtils.buildVimPlugin
{
  name = "delimitMate";
  src = fetchFromGitHub
  {
    owner = "Raimondi";
    repo = "delimitMate";
    rev = "728b57a6564c1d2bdfb9b9e0f2f8c5ba3d7e0c5c";
    sha256 = "0fskm9gz81dk8arcidrm71mv72a7isng1clssqkqn5wnygbiimsn";
  };

  buildInputs = [ zip vim ]
  ;
}
