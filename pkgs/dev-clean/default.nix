# Cleans up dev space
# devcc
{ lib, writeShellApplication }:
(writeShellApplication {
  name = "dev-clean";
  runtimeInputs = [ ];
  text = builtins.readFile ./dev-clean.sh;
})
// {
  meta = with lib; {
    licenses = licenses.mit;
    platforms = platforms.all;
  };
}
