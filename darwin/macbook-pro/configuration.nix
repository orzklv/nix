{
  inputs,
  outputs,
  lib,
  ...
}: {
  # You can import other Darwin modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    outputs.darwinModules.zsh
    outputs.darwinModules.secret
    outputs.darwinModules.nixpkgs
    outputs.darwinModules.homebrew
    outputs.darwinModules.users.sakhib

    # Home Manager Darwin Module
    inputs.home-manager.darwinModules.home-manager
  ];

  # Networking DNS & Interfaces
  networking = {
    computerName = "Sokhibjon’s MacBook Pro"; # Define your computer name.
    localHostName = "Sokhibjons-MacBook-Pro"; # Define your local host name.
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # environment.systemPackages =
  #   [
  #     pkgs.neovim
  #   ];

  # Fingerprint sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina

  # Select host type for the system
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-darwin";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
