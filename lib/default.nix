{ lib }:
{
  # Helpful functions & generators

  # Generate instance configurations
  config = import ./config.nix { inherit lib; };

  # Rust like match syntax for nix
  rmatch = import ./rmatch.nix { inherit lib; };

  # Strings addition for nix
  ostrings = import ./strings.nix { inherit lib; };

  # Host configuration
  omodules = import ./module.nix { inherit lib; };
}
