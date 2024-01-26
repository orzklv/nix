{pkgs, ...}: [
  # Downloader
  pkgs.aria

  # Developer Mode
  pkgs.gh
  pkgs.wget
  pkgs.gitui
  pkgs.zellij
  pkgs.direnv
  pkgs.git-lfs
  pkgs.gitoxide
  pkgs.cargo-update

  # Environment
  pkgs.bat
  pkgs.btop
  pkgs.eza
  pkgs.fd
  pkgs.figlet
  pkgs.gping
  pkgs.hyperfine
  pkgs.lolcat
  pkgs.neofetch
  pkgs.onefetch
  pkgs.procs
  pkgs.ripgrep
  pkgs.tealdeer
  pkgs.topgrade

  # Tech
  pkgs.rustup

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
  pkgs.fp
  pkgs.devcc
  pkgs.ghloc
  pkgs.google
]
