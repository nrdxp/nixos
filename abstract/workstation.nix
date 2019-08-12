{ ... }:
{ imports =
  let
    mapServDir = map
      ( x: ../extra + "/${x}.nix" );
  in
  mapServDir [ "adblocking" "home" "xorg"
    "linux-rt" "make-linux-fast-again"
  ];
}
