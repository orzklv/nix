{
  lib,
  ...
}:
{
  # Networking DNS & Interfaces
  networking = {
    computerName = "Sokhibjon’s Mac Studio"; # Define your computer name.
    localHostName = "Sokhibjons-Mac-Studio"; # Define your local host name.
  };

  # Select host type for the system
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-darwin";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
