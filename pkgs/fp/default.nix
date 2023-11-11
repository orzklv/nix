# Cleans up dev space
# devcc
{ lib
, writeShellApplication
, git
}:
(writeShellApplication {
  name = "fp";
  runtimeInputs = [ git ];
  text = builtins.readFile ./fp.sh;
})
  // {
  meta = with lib; {
    licenses = licenses.mit;
    platforms = platforms.all;
  };
}
