{
  lib,
  config,
  ...
}: let
  apps = lib.mkIf config.homebrew.enable [
    "pkl"
    "vapor"
    "mas"
    "rustup"
  ];
in {
  # Homebrew Formulae installations
  homebrew.brews = apps;
}
