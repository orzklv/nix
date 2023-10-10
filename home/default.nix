{ pkgs, ... }: {
  # Modules
  imports = [
      ./zsh
      ./git
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
}