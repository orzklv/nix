# Cleans up dev space
# devcc
{
  lib,
  writeShellApplication,
  git,
}:
(writeShellApplication {
  name = "force-push";
  runtimeInputs = [git];
  text = builtins.readFile ./force-push.sh;
})
// {
  meta = with lib; {
    licenses = licenses.mit;
    platforms = platforms.all;
  };
}
