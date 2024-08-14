{ pkgs, ... }: [
  # Downloader
  pkgs.aria

  # Developer Mode
  pkgs.gh
  pkgs.jq
  pkgs.wget
  pkgs.zola
  pkgs.gitui
  pkgs.zellij
  pkgs.netcat
  pkgs.direnv
  pkgs.git-lfs
  pkgs.gitoxide
  pkgs.cargo-update

  # Environment
  pkgs.fd
  pkgs.bat
  pkgs.btop
  pkgs.eza
  pkgs.figlet
  pkgs.gping
  pkgs.hyperfine
  pkgs.lolcat
  pkgs.fastfetch
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

  # Anime
  pkgs.crunchy-cli

  # GPG Signing
  pkgs.gnupg

  # Selfmade programs
  pkgs.force-push
  pkgs.dev-clean
  pkgs.org-location
  pkgs.google
]
