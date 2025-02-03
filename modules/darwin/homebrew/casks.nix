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
    "discord"
    "elmedia-player"
    "folx"
    "font-sf-mono-nerd-font-ligaturized"
    "gitfox"
    "github"
    "iterm2"
    "itermai"
    "keka"
    "kekaexternalhelper"
    "little-snitch"
    "logitech-options"
    "minecraft"
    "obs"
    "openscad"
    "parallels"
    "prismlauncher"
    "raspberry-pi-imager"
    "rectangle-pro"
    "sf-symbols"
    "sketch"
    "slack"
    "steam"
    "xcodes"
    "docker"
  ];
in {
  # Homebrew Casks installations
  homebrew.casks = apps;
}
