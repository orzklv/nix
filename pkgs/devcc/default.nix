# Cleans up dev space
# devcc
{
  lib,
  writeShellApplication,
}:
(writeShellApplication {
  name = "devcc";
  runtimeInputs = [];
  text = builtins.readFile ./devcc.sh;
})
// {
  meta = with lib; {
    licenses = licenses.mit;
    platforms = platforms.all;
  };
}
