{ lib, ... }:
let
  inherit (builtins) attrValues isAttrs;
  inherit (lib.lists) flatten;

  flattenAttrs = set:
    flatten (
      map (
        arg:
          if isAttrs arg
          then flattenAttrs arg
          else arg
      )
        (attrValues set)
    );
in
flattenAttrs
