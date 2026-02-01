{ lib, ... }:
{
  if_let = v: p: if lib.attrsets.matchAttrs p v then v else null;

  match =
    v: l:
    builtins.elemAt (lib.lists.findFirst (
      x: (lib.orzklv.if_let v (builtins.elemAt x 0)) != null
    ) null l) 1;
}
