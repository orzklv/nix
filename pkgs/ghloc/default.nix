# Cleans up dev space
# devcc
{
  lib,
  writeShellApplication,
  curl,
}:
(writeShellApplication {
  name = "ghloc";
  runtimeInputs = [curl];
  text = builtins.readFile ./ghloc.sh;
})
// {
  meta = with lib; {
    licenses = licenses.mit;
    platforms = platforms.all;
  };
}
