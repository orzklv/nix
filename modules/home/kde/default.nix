{ config
, pkgs
, lib
, ...
}:
let
  isMacOS = pkgs.stdenv.hostPlatform.system == "aarch64-darwin" || pkgs.stdenv.hostPlatform.system == "x86_64-darwin";
in
{
  config = { };
}
