{
  lib,
  config,
  ...
}: let
  apps = lib.mkIf config.homebrew.enable [
    "anki"
    "balenaetcher"
    "chatgpt"
    "cleanmymac"
    "element"
    "elmedia-player"
    "folx"
    "font-sf-mono-nerd-font-ligaturized"
    "github"
    "iterm2"
    "keka"
    "kekaexternalhelper"
    "little-snitch"
    "logitech-options"
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
    "xcodes"
    "periphery"
  ];
in {
  # Homebrew Casks installations
  homebrew.casks = apps;
}
