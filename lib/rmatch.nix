{ lib }:
let
  if_let = v: p: if lib.attrsets.matchAttrs p v then v else null;

  match =
    v: l: builtins.elemAt (lib.lists.findFirst (x: (if_let v (builtins.elemAt x 0)) != null) null l) 1;
in
{
  inherit if_let match;
}
