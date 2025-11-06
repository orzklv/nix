{pkgs, ...}: [
  # Downloader
  pkgs.aria2

  # Developer Mode
  pkgs.gh
  pkgs.jq
  pkgs.wget
  pkgs.netcat
  pkgs.direnv
  pkgs.git-lfs
  pkgs.cargo-update

  # Environment
  pkgs.figlet
  pkgs.onefetch
  pkgs.tealdeer

  # For Prismlauncher
  pkgs.jdk17

  # Media encode & decode
  pkgs.ffmpeg
  pkgs.libheif

  # GPG Signing
  pkgs.gnupg
]
