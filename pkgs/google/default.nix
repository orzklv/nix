# Cleans up dev space
# devcc
{ lib
, writeShellApplication
,
}:
(writeShellApplication {
  name = "google";
  runtimeInputs = [ ];
  text = builtins.readFile ./google.sh;
})
  // {
  meta = with lib; {
    licenses = licenses.mit;
    platforms = platforms.all;
  };
}
