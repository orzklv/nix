{
  lib,
  xdg-utils,
  findutils,
  callPackage,
  writeShellApplication,
}: let
  kripach = callPackage ../kripach {};
in
  (writeShellApplication {
    name = "krisper";
    runtimeInputs = [xdg-utils kripach findutils];
    text = builtins.readFile ./krisper.sh;
  })
  // {
    meta = with lib; {
      licenses = licenses.mit;
      platforms = platforms.all;
    };
  }
