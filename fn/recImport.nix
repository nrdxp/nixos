args@{ lib, ... }:
# takes a path to a directory and gives back a set matching the file heirarchy
# containing every file ending in ".nix" with its contents as its value
# including those in subdirectories
# recImport :: path -> set
with builtins;
let
  recImport = with lib;
  let
    prepAttr = fullPath:
    if pathType fullPath == "regular"
    # import contents of ".nix" files
    then
      if strings.hasSuffix ".nix" fullPath
      then
        { name =
          strings.removeSuffix
            ".nix"
            ( baseNameOf fullPath );
          value = import fullPath args;
        }
      else
        { name = ( baseNameOf fullPath );
          value = readFile fullPath;
        }
    # or call itself recursively in case of directory
    else
      { name = baseNameOf fullPath;
        value = recImport fullPath;
      };

    toFullPath = dirname: basename:
    dirname + "/${basename}";

    applyFilter = dir:
    attrsets.filterAttrs
      ( filterRules dir )
      ( readDir dir );

    filterRules = dir: n: v:
    !  ( strings.hasPrefix "." n )
    && (
      ( ( v == "directory"
          && ( filterAttrs ( dir + "/${n}" ) != {} )
        )
        && n != "unused"
        && ! strings.hasInfix "." n
      )
      || (
        v == "regular"
        && n != "default.nix"
        && n != "recImport.nix"
      )
    );
    # if there is both a .nix file and directory of same name merge the two
    ifDuplicate =
    let
      list = dir:
      map (strings.removeSuffix ".nix")
        (attrNames ( applyFilter dir) );

      duplicates = with lists; list:
      if list == [] then
        []
      else
        let
          x = head list;
          xs = duplicates ( drop 1 list );
        in
          if count (y: y == x) list > 1
          then [x] ++ remove x xs
          else xs;

      modifySet = set: dir: attr:
        { name = "${attr}";
          value = set."${attr}"
            // ( import ( dir + "/${attr}.nix" ) args );
        };

    in
    set: dir:
      if duplicates ( list dir ) == []
      then set
      else set
        // listToAttrs ( map ( modifySet set dir )
          ( duplicates ( list dir ) ));
  in
  dir:
  ifDuplicate ( listToAttrs (
    map prepAttr
      ( map ( toFullPath dir )
          ( attrNames
            ( applyFilter dir )
          )
      )
  )) dir;
in
  recImport
