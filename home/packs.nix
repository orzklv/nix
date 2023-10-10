{ pkgs, ... }: [
      # Downloader
      pkgs.aria

      # Linguistics
      pkgs.aspell
      pkgs.hunspell
      pkgs.ispell

      # Developer Mode
      pkgs.automake
      pkgs.autoconf
      pkgs.cargo-update
      pkgs.clang-tools
      pkgs.cmake
      pkgs.cocoapods
      pkgs.gcc
      pkgs.gh
      pkgs.git-lfs
      pkgs.gitoxide
      pkgs.gitui
      pkgs.libgccjit
      pkgs.libheif
      pkgs.llvm
      pkgs.just
      pkgs.gnumake
      pkgs.mdbook
      pkgs.pcre
      pkgs.shfmt
      pkgs.wget

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
      pkgs.go
      pkgs.jdk
      pkgs.bun
      pkgs.poetry
      pkgs.python3
      pkgs.rustup
      pkgs.volta
      pkgs.zig

      # Media encode & decode
      pkgs.ffmpeg

      # GPG Signing
      pkgs.gnupg
      pkgs.pinentry_mac
]