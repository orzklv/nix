{ pkgs ? import <nixpkgs> { } }:
let
  # Import the existing package list from packs.nix
  globals = import ./global.nix { inherit pkgs; };

  # Additional packages to add
  additions = with pkgs; [
    # Add new packages here
    pkgs.pinentry_mac
    pkgs.brewster
  ];
in
# Combine the original package list with the new packages
globals ++ additions
