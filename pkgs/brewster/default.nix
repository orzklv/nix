# Cleans up dev space
# devcc
{ lib
, writeShellApplication
,
}:
(writeShellApplication {
  name = "brewster";
  runtimeInputs = [ ];
  text = builtins.readFile ./brewster.sh;
})
  // {
  meta = with lib; {
    licenses = licenses.mit;
    platforms = platforms.aarch64-darwin;
  };
}
