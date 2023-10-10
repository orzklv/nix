{ pkgs, ... }: {
  # Modules
  imports = [
      ./zsh
  ];

  # This is required information for home-manager to do its job
  home = {
    stateVersion = "23.11";
    username = "sakhib";
    homeDirectory = "/Users/sakhib";

    # Tell it to map everything in the `config` directory in this
    # repository to the `.config` in my home directory
    file.".config" = { source = ../config; recursive = true; };

    # Packages to be installed on my machine
    packages = [
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
    ];
  };

  # This is to ensure programs are using ~/.config rather than
  # /Users/sakhib/Library/whatever
  xdg.enable = true;

  # Let's enable home-manager
  programs.home-manager.enable = true;


  # Zpxide path integration
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # Setup pinentry for mac
  home.file.".gnupg/gpg-agent.conf".text = ''
    pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
  '';

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.helix = {
    enable = true;

    settings = {
      theme = "autumn_night";

      editor = {
        line-number = "relative";

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };


        file-picker = {
          hidden = false;
        };

        statusline = {
          left = [ "mode" "spinner" ];

          center = [ "file-name" ];

          right = [
            "diagnostics"
            "selections"
            "position"
            "file-encoding"
            "file-line-ending"
            "file-type"
          ];

          separator = "│";

          mode = {
            normal = "SLAVE";
            insert = "MASTER";
            select = "DUNGEON";
          };
        };

      };

      keys.normal = {
        # Easy window movement
        "C-left" = "jump_view_left";
        "C-right" = "jump_view_right";
        "C-up" = "jump_view_up";
        "C-down" = "jump_view_down";

        "C-h" = "jump_view_left";
        "C-j" = "jump_view_down";
        "C-k" = "jump_view_up";
        "C-l" = "jump_view_right";

        "C-r" = ":reload";
      };
    };
  };

  programs.git = {
    enable = true;
    lfs.enable = true;

    # User credentials
    userName = "Sokhibjon Orzikulov";
    userEmail = "sakhib@orzklv.uz";

    extraConfig = {
      http.sslVerify = false;
    };

    # GPG Signing
    signing = {
      signByDefault = true;
      key = "00D27BC687070683FBB9137C3C35D3AF0DA1D6A8";
    };

    # Aliases
    aliases = {
      ch = "checkout";
    };

    # Git ignores
    ignores = [
      ".idea"
      ".DS_Store"
    ];
  };
}