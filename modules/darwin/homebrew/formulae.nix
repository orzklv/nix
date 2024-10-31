{ pkgs
, inputs
, outputs
, lib
, config
, packages
, ...
}:
let
  apps = lib.mkIf config.homebrew.enable [
    "pkl"
    "vapor"
    "rustup"
  ];
in
{
  # Homebrew Formulae installations
  homebrew.brews = apps;
}
