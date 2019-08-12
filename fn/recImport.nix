args@{ lib, ... }:
# takes a path to a directory and gives back a set matching the file heirarchy
# containing every file ending in ".nix" with its contents as its value
# including those in subdirectories
# recImport :: path -> set
with builtins;
let
  recImport = with lib;
  let
    # get list of paths ready to be converted to attrs
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
      # or simply readFile literally if its not a .nix file
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

    # function to apply filter rules
    applyFilter = dir:
    attrsets.filterAttrs
      ( filterRules dir )
      ( readDir dir );

    # filter rules to be applied
    filterRules = dir: n: v:
    !  ( strings.hasPrefix "." n )
    && (
      ( ( v == "directory"
          # check subdirs recursively for same rules
          && ( applyFilter ( dir + "/${n}" ) != {} )
        )
        && n != "unused"
        && ! strings.hasInfix "." n
      )
      || (
        v == "regular"
        && n != "default.nix"
      )
    );
    # if there is both a .nix file and directory of same name merge the two
    ifDuplicate =
    let
      # get list of qualifying files
      list = dir:
      map (strings.removeSuffix ".nix")
        (attrNames ( applyFilter dir) );

      # filter list to include one instance per item that had duplicates in
      # the input and dropping any item that does not have a duplicate
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

      # function to mapped on duplicates list to prepare a final attrs to be
      # merged with the original
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

    # fist pass before checking for duplicates
    firstPass = dir: listToAttrs (
      map prepAttr
      ( map ( toFullPath dir )
          ( attrNames
            ( applyFilter dir )
          )
      )
    );

  in
  dir:
  ifDuplicate ( firstPass dir )  dir;
in
  recImport
