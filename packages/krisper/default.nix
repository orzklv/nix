{
  lib,
  pkgs,
  ...
}:
let
  kripach = pkgs.callPackage ../kripach { };
in
(pkgs.writeShellApplication {
  name = "krisper";
  runtimeInputs = [
    kripach
    pkgs.xdg-utils
    pkgs.findutils
  ];
  text = builtins.readFile ./krisper.sh;
})
// {
  meta = with lib; {
    licenses = licenses.mit;
    platforms = platforms.all;
  };
}
