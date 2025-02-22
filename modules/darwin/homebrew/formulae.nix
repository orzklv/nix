{
  lib,
  config,
  ...
}: let
  apps = lib.mkIf config.homebrew.enable [
    "pkl"
    "mas"
  ];
in {
  # Homebrew Formulae installations
  homebrew.brews = apps;
}
