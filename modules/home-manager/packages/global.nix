{pkgs, ...}: [
  # Downloader
  pkgs.aria

  # Linguistics
  pkgs.aspell
  pkgs.hunspell
  pkgs.ispell

  # Developer Mode
  pkgs.cargo-update
  pkgs.gh
  pkgs.git-lfs
  pkgs.gitoxide
  pkgs.gitui
  pkgs.libheif
  pkgs.just
  pkgs.gnumake
  pkgs.mdbook
  pkgs.shfmt
  pkgs.wget
  pkgs.zellij
  pkgs.direnv

  # Environment
  pkgs.bat
  pkgs.btop
  pkgs.cowsay
  pkgs.eza
  pkgs.fd
  pkgs.figlet
  pkgs.gping
  pkgs.hyperfine
  pkgs.lolcat
  pkgs.neofetch
  pkgs.onefetch
  pkgs.pfetch
  pkgs.procs
  pkgs.ripgrep
  pkgs.tealdeer
  pkgs.tmux
  pkgs.topgrade

  # Tech
  pkgs.deno
  pkgs.rustup
  pkgs.volta
  pkgs.zig
  pkgs.jdk17

  # Media encode & decode
  pkgs.ffmpeg

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
