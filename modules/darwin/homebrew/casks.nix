{
  lib,
  config,
  ...
}: let
  apps = lib.mkIf config.homebrew.enable [
    "anki"
    "anydesk"
    "balenaetcher"
    "chatgpt"
    "cleanmymac"
    "discord"
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
    "periphery"
    "prismlauncher"
    "raspberry-pi-imager"
    "rectangle-pro"
    "sf-symbols"
    "sketch"
    "xcodes"
    "zen"
    "zoom"
  ];
in {
  # Homebrew Casks installations
  homebrew.casks = apps;
}
