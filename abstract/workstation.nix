{ ... }:
{ imports =
  let
    mapServDir = map
      ( x: ../xtra + "/${x}.nix" );
  in
  mapServDir [ "adblocking" "home" "xorg"
    "linux-rt" "make-linux-fast-again"
  ];
}
