# Cleans up dev space
# devcc
{ lib
, writeShellApplication
,
}:
(writeShellApplication {
  name = "ghloc";
  runtimeInputs = [ ];
  text = builtins.readFile ./ghloc.sh;
})
  // {
  meta = with lib; {
    licenses = licenses.mit;
    platforms = platforms.all;
  };
}
