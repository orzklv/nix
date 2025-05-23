{pkgs, ...}: [
  # Downloader
  pkgs.aria

  # Developer Mode
  pkgs.gh
  pkgs.jq
  pkgs.wget
  pkgs.gitui
  pkgs.netcat
  pkgs.direnv
  pkgs.git-lfs
  pkgs.cargo-update
  # pkgs.nixvim

  # Environment
  pkgs.fd
  pkgs.bat
  pkgs.btop
  pkgs.eza
  pkgs.figlet
  pkgs.gping
  pkgs.hyperfine
  pkgs.onefetch
  pkgs.procs
  pkgs.ripgrep
  pkgs.tealdeer
  pkgs.topgrade

  # For Prismlauncher
  pkgs.jdk17

  # Media encode & decode
  pkgs.ffmpeg
  pkgs.libheif

  # GPG Signing
  pkgs.gnupg
]
