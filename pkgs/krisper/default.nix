# Cleans up dev space
# devcc
{
  lib,
  fetchurl,
  python3Packages,
  writeShellApplication,
  writers,
  findutils,
  xdg-utils,
}: let
  krisp-patcher =
    writers.writePython3Bin "krisp-patcher"
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
      builtins.readFile (
        fetchurl {
          url = "https://raw.githubusercontent.com/sersorrel/sys/afc85e6b249e5cd86a7bcf001b544019091b928c/hm/discord/krisp-patcher.py";
          sha256 = "sha256-h8Jjd9ZQBjtO3xbnYuxUsDctGEMFUB5hzR/QOQ71j/E=";
        }
      )
    );
in
  (writeShellApplication {
    name = "google";
    runtimeInputs = [xdg-utils krisp-patcher findutils];
    text = builtins.readFile ./krisper.sh;
  })
  // {
    meta = with lib; {
      licenses = licenses.mit;
      platforms = platforms.linux;
    };
  }
