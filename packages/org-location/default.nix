{
  lib,
  pkgs,
  ...
}:
(pkgs.writeShellApplication {
  name = "org-location";
  runtimeInputs = with pkgs; [ curl ];
  text = builtins.readFile ./org-location.sh;
})
// {
  meta = with lib; {
    licenses = licenses.mit;
    platforms = platforms.all;
  };
}
