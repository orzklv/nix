{pkgs, ...}:
with pkgs; [
  # Downloader
  aria2

  # Developer Mode
  gh
  jq
  wget
  netcat
  direnv
  git-lfs
  cargo-update

  # Environment
  figlet
  onefetch
  tealdeer

  # For Prismlauncher
  jdk17

  # Media encode & decode
  ffmpeg
  libheif

  # GPG Signing
  gnupg
]
