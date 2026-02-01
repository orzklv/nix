{
  lib,
  pkgs,
  ...
}:
(pkgs.writeShellApplication {
  name = "force-push";
  runtimeInputs = with pkgs; [ git ];
  text = builtins.readFile ./force-push.sh;
})
// {
  meta = with lib; {
    licenses = licenses.mit;
    platforms = platforms.all;
  };
}
