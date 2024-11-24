{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  # You can import other Darwin modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    outputs.darwinModules.nixpkgs
    outputs.darwinModules.homebrew
    outputs.darwinModules.users.sakhib

    # Home Manager Darwin Module
    inputs.home-manager.darwinModules.home-manager
  ];

  # Networking DNS & Interfaces
  networking = {
    computerName = "Sokhibjon’s Mac Studio"; # Define your computer name.
    localHostName = "Sokhibjons-Mac-Studio"; # Define your local host name.
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # environment.systemPackages =
  #   [
  #     pkgs.neovim
  #   ];

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina

  # Select host type for the system
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-darwin";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
