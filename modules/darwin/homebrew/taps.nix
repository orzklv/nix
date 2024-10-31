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
    "shaunsingh/sfmono-nerd-font-ligaturized/font-sf-mono-nerd-font-ligaturized"
  ];
in
{
  # Homebrew Formulae installations
  homebrew.taps = apps;
}
