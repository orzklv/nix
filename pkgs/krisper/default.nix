{
  lib,
  krisp-patcher,
  writeShellApplication,
  findutils,
  xdg-utils,
}:
(writeShellApplication {
  name = "krisper";
  runtimeInputs = [xdg-utils krisp-patcher findutils];
  text = builtins.readFile ./krisper.sh;
})
// {
  meta = with lib; {
    licenses = licenses.mit;
    platforms = platforms.all;
  };
}
