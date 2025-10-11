{
  lib,
  config,
  ...
}: let
  apps = lib.mkIf config.homebrew.enable [
    "anki"
    "balenaetcher"
    "cleanmymac"
    "discord"
    "element"
    "elmedia-player"
    "folx"
    "font-sf-mono-nerd-font-ligaturized"
    "iterm2"
    "gitfox"
    "keka"
    "kekaexternalhelper"
    "little-snitch"
    "logitech-options"
    "macs-fan-control"
    "minecraft"
    "obs"
    "openscad"
    "parallels"
    "prismlauncher"
    "raspberry-pi-imager"
    "rectangle-pro"
    "sf-symbols"
    "sketch"
    "zen"
  ];
in {
  # Homebrew Casks installations
  homebrew.casks = apps;
}
