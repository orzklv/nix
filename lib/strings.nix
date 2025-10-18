{lib}: let
  capitalize = str: let
    first = builtins.substring 0 1 str |> lib.toUpper;
    rest = builtins.substring 1 (builtins.stringLength str) str;
  in
    lib.strings.concatStrings [first rest];
in {inherit capitalize;}
