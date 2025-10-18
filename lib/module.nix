{lib}: let
  mod-parse = path:
    builtins.readDir path
    |> builtins.attrNames
    |> map (x: {
      name = x;
      value = import (path + "/${x}");
    })
    |> builtins.listToAttrs;
in {
  inherit mod-parse;
}
