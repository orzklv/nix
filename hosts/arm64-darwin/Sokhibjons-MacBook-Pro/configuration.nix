{
  inputs,
  outputs,
  lib,
  ...
}:
{
  # You can import other Darwin modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    outputs.darwinModules.zsh
    outputs.darwinModules.brew
    outputs.darwinModules.users
    outputs.darwinModules.fonts
    outputs.darwinModules.secret
    outputs.darwinModules.nixpkgs
    outputs.darwinModules.security

    # Home Manager Darwin Module
    inputs.home-manager.darwinModules.home-manager
  ];

  # Networking DNS & Interfaces
  networking = {
    computerName = "Sokhibjon’s MacBook Pro"; # Define your computer name.
    localHostName = "Sokhibjons-MacBook-Pro"; # Define your local host name.
  };

  # Select host type for the system
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-darwin";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
