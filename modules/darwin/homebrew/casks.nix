{
  lib,
  config,
  ...
}: let
  apps = lib.mkIf config.homebrew.enable [
    "arduino-ide"
    "balenaetcher"
    "chatgpt"
    "cleanmymac"
    "codeedit"
    "discord"
    "elmedia-player"
    "folx"
    "font-sf-mono-nerd-font-ligaturized"
    "gitfox"
    "github"
    "iterm2"
    "itermai"
    "jetbrains-toolbox"
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
    "xcodes"
    "zed"
  ];
in {
  # Homebrew Casks installations
  homebrew.casks = apps;
}
