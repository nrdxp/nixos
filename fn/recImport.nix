args@{ lib, ... }:
# takes a path to a directory and gives back a set matching the file heirarchy
# containing every file ending in ".nix" with its contents as its value
# including those in subdirectories
# recImport :: path -> set
let
  inherit (builtins) readFile readDir;
  inherit (lib) pathType strings attrsets attrNames lists listToAttrs;
  inherit (strings) hasInfix hasPrefix hasSuffix removeSuffix;
  inherit (lists) head drop count remove;
  inherit (attrsets) filterAttrs;

  recImport = let
    # get list of paths ready to be converted to attrs
    prepAttr = fullPath:
      if pathType fullPath == "regular"
        # import contents of ".nix" files
      then
        if hasSuffix ".nix" fullPath
        then {
          name = removeSuffix ".nix"
            (baseNameOf fullPath);
          value = import fullPath args;
        }
          # or simply readFile literally if its not a .nix file
        else {
          name = (baseNameOf fullPath);
          value = readFile fullPath;
        }
        # or call itself recursively in case of directory
      else {
        name = baseNameOf fullPath;
        value = recImport fullPath;
      };

    toFullPath = dirname: basename:
      dirname + "/${basename}";

    # function to apply filter rules
    applyFilter = dir:
      filterAttrs
        (filterRules dir)
        (readDir dir);

    # filter rules to be applied
    filterRules = dir: n: v:
      !  (hasPrefix "." n)
      && (
           (
             (
               v == "directory"
               # check subdirs recursively for same rules
               && (applyFilter (dir + "/${n}") != {})
             )
             && n != "unused"
             && ! hasInfix "." n
           )
           || (
                v == "regular"
                && n != "default.nix"
              )
         );
    # if there is both a .nix file and directory of same name merge the two
    ifDuplicate = let
      # get list of qualifying files
      list = dir:
        map (removeSuffix ".nix")
          (attrNames (applyFilter dir));

      # filter list to include one instance per item that had duplicates in
      # the input and dropping any item that does not have a duplicate
      duplicates = list:
        if list == [] then
          []
        else let
          x = head list;
          xs = duplicates (drop 1 list);
        in
          if count (y: y == x) list > 1
          then [ x ] ++ remove x xs
          else xs;

      # function to mapped on duplicates list to prepare a final attrs to be
      # merged with the original
      modifySet = set: dir: attr: {
        name = "${attr}";
        value = set."${attr}"
          // (import (dir + "/${attr}.nix") args)
          ;
      };

    in
      set: dir:
        if duplicates (list dir) == []
        then set
        else set
        // listToAttrs (
             map (modifySet set dir)
               (duplicates (list dir))
           );

    # fist pass before checking for duplicates
    firstPass = dir: listToAttrs (
      map prepAttr (
        map (toFullPath dir) (
          attrNames (applyFilter dir)
        )
      )
    );

  in
    dir: ifDuplicate (firstPass dir) dir;
in
recImport
