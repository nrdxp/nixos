args@{ lib, ... }:
let
  inherit (builtins) readFile readDir;
  inherit (lib) pathType strings attrsets attrNames lists listToAttrs;
  inherit (strings) hasInfix hasPrefix hasSuffix removeSuffix;
  inherit (lists) head drop count remove;
  inherit (attrsets) filterAttrs;

  /* takes a path to a directory and recursively generates a set matching the
  file heirarchy where { 'file' = 'file contents' }

  recImport :: Path -> AttrSet */
  recImport = let
  # prepAttr :: Path -> (AttrSet => { name : value })
    prepAttr = fullPath:
      if pathType fullPath == "regular"
      then
        if hasSuffix ".nix" fullPath
        then {
          name = removeSuffix ".nix"
            (baseNameOf fullPath);
          value = import fullPath args;
        }
        else {
          name = (baseNameOf fullPath);
          value = readFile fullPath;
        }
      else {
        name = baseNameOf fullPath;
        value = recImport fullPath;
      };

  # applyFilter :: Path -> AttrSet
    applyFilter = dir:
      filterAttrs
        (filterRules dir)
        (readDir dir);

/*  filterRules ::
      Path                 ->
      (String => AttrName) ->
      (Any => AttrValue)   ->
      Bool */
    filterRules = dir: n: v:
      !  (hasPrefix "." n)
      && (
           (
             (
               v == "directory"
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

    /* if there is both a .nix file and directory of same name merge the two

    ifDuplicate :: AttrSet -> Path -> AttrSet */
    ifDuplicate = let
      /* get list of qualifying files using 'applyFilter'

      fileList :: Path -> List */
      fileList = dir:
        map (removeSuffix ".nix")
          (attrNames (applyFilter dir));

      /* list of files that have both a regular file and a directory
      with their duplicate entries removed

      duplicates :: List -> List */
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

      /* tack on the ${file}.nix to the end of the set contructed from the
      directory of the same name

      modifySet :: AttrSet -> Path -> String -> AttrSet */
      modifySet = set: dir: file: {
        name = "${file}";
        value = set."${file}"
          // (import (dir + "/${file}.nix") args)
          ;
      };
    in
      set: dir:
        if duplicates (fileList dir) == []
        then set
        else set
        // listToAttrs (
             map (modifySet set dir)
               (duplicates (fileList dir))
           );

    /* fist pass before checking for duplicates

    firstPass :: Path -> AttrSet */
    firstPass = dir: listToAttrs (
      map prepAttr (
        map (basename: dir + "/${basename}") (
          attrNames (applyFilter dir)
        )
      )
    );

  in
    dir: ifDuplicate (firstPass dir) dir;
in
recImport
