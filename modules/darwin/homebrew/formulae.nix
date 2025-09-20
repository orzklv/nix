{
  lib,
  config,
  ...
}: let
  apps = lib.mkIf config.homebrew.enable [
    "pkl"
    "mas"
    "git-lfs"
  ];
in {
  # Homebrew Formulae installations
  homebrew.brews = apps;
}
