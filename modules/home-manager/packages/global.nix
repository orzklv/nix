{pkgs, ...}: [
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
  pkgs.fastfetch
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
  pkgs.neofetch
  pkgs.onefetch
  pkgs.procs
  pkgs.ripgrep
  pkgs.tealdeer
  pkgs.topgrade
  pkgs.lint-staged

  # Tech
  pkgs.bun
  pkgs.zig
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
