# Cleans up dev space
# devcc
{ lib
, writeShellApplication
, xdg-utils
,
}:
(writeShellApplication {
  name = "google";
  runtimeInputs = [ xdg-utils ];
  text = builtins.readFile ./google.sh;
})
  // {
  meta = with lib; {
    licenses = licenses.mit;
    platforms = platforms.all;
  };
}
