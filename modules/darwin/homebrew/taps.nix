{
  lib,
  config,
  ...
}: let
  apps = lib.mkIf config.homebrew.enable [
    "shaunsingh/SFMono-Nerd-Font-Ligaturized"
  ];
in {
  # Homebrew Formulae installations
  homebrew.taps = apps;
}
