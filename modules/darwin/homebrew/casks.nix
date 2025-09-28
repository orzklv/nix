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
    "github"
    "keka"
    "kekaexternalhelper"
    "little-snitch"
    "logitech-options"
    "macs-fan-control"
    "minecraft"
    "obs"
    "openscad"
    "openvpn-connect"
    "parallels"
    "prismlauncher"
    "raspberry-pi-imager"
    "rectangle-pro"
    "sf-symbols"
    "sketch"
    "zen"
    "zoom"
  ];
in {
  # Homebrew Casks installations
  homebrew.casks = apps;
}
