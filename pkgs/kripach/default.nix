{
  lib,
  writers,
  python3Packages,
}:
writers.writePython3Bin "kripach"
{
  libraries = with python3Packages; [
    capstone
    pyelftools
  ];
  flakeIgnore = [
    "E501" # line too long (82 > 79 characters)
    "F403" # 'from module import *' used; unable to detect undefined names
    "F405" # name may be undefined, or defined from star imports: module
  ];
}
(
  builtins.readFile ./kripach.py
)
// {
  meta = with lib; {
    licenses = licenses.mit;
    platforms = platforms.all;
  };
}
