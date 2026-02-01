{
  lib,
  pkgs,
  ...
}:
(pkgs.writeShellApplication {
  name = "google";
  runtimeInputs = with pkgs; [ xdg-utils ];
  text = builtins.readFile ./google.sh;
})
// {
  meta = with lib; {
    licenses = licenses.mit;
    platforms = platforms.all;
  };
}
