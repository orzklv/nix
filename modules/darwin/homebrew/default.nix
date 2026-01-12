{
  lib,
  config,
  ...
}: {
  imports = [
    # Note:
    # Uncomment for the first time,
    # it keeps installing over and over.
    # ./mas.nix
  ];

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };

    brews = lib.optionals config.homebrew.enable [
      "pkl"
      "mas"
      "git-lfs"
      "rustup"
    ];

    casks = lib.optionals config.homebrew.enable [
      "anki"
      "balenaetcher"
      "cleanmymac"
      "element"
      "elmedia-player"
      "folx"
      "iterm2"
      "gitfox"
      "keka"
      "kekaexternalhelper"
      "little-snitch"
      "logitech-options"
      "macs-fan-control"
      "minecraft"
      "nextcloud"
      "obs"
      "openscad"
      "parallels"
      "prismlauncher"
      "raspberry-pi-imager"
      "rectangle-pro"
      "sf-symbols"
      "sketch"
      "zen"
      "zulip"
    ];
  };
}
