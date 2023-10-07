{ pkgs, nodePackages, ... }: {
  # This is required information for home-manager to do its job
  home = {
    stateVersion = "23.11";
    username = "sakhib";
    homeDirectory = "/Users/sakhib";
    packages = [
        # Downloader
        pkgs.aria

        # Linguistics
        pkgs.aspell
        pkgs.hunspell
        pkgs.ispell

        # Developer Mode
        pkgs.automake
        pkgs.clang-tools
        pkgs.cmake
        pkgs.cocoapods
        pkgs.gh
        pkgs.git-lfs
        pkgs.gitoxide
        pkgs.gitui
        pkgs.helix
        pkgs.libgccjit
        pkgs.libheif
        pkgs.llvm
        pkgs.just
        pkgs.gnumake
        pkgs.mdbook
        pkgs.pcre
        pkgs.shfmt
        nodePackages.vercel
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
        pkgs.starship
        pkgs.tealdeer
        pkgs.tmux
        pkgs.topgrade

        # Tech
        pkgs.deno
        pkgs.go
        pkgs.jdk
        pkgs.bun
        pkgs.poetry
        pkgs.rustup
        pkgs.volta
        pkgs.zig

        # Media encode & decode
        pkgs.ffmpeg

        # GPG Signing
        pkgs.gnupg
        pkgs.pinentry_mac
        pkgs.pinentry_mac

    ];
  };
  programs.home-manager.enable = true;
  # I use fish, but bash and zsh work just as well here. This will setup
  # the shell to use home-manager properly on startup, neat!
  programs.fish.enable = true;
}