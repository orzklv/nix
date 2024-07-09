# Cleans up dev space
# devcc
{
  lib,
  writeShellApplication,
  curl,
}:
(writeShellApplication {
  name = "org-location";
  runtimeInputs = [curl];
  text = builtins.readFile ./org-location.sh;
})
// {
  meta = with lib; {
    licenses = licenses.mit;
    platforms = platforms.all;
  };
}
