{ pkgs, ... }: {
  # Modules
  imports = [
      ./zsh
      ./helix
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
    packages = import ./packs.nix { pkgs = pkgs; };
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