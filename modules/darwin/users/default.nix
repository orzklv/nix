# Keep all specific user configs here as a module
{...}: let
  modules =
    builtins.readDir ./.
    |> builtins.attrNames
    |> builtins.filter (i: i != "default.nix")
    |> map (m: ./. + "/${m}");
in {
  imports = modules;
}
