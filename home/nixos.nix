{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  packages,
  ...
}: {
  imports = [
    ./zsh
    ./helix
    ./topgrade
    # ./git
    # ./git/linux-agent.nix
    outputs.homeManagerModules.git
    outputs.homeManagerModules.neovim
    outputs.homeManagerModules.packages
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];

    # Configure your nixpkgs instance
    config = {
      # Wallahi, forgive me RMS...
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
      # Let the system use fucked up programs
      allowBroken = true;
    };
  };

  # This is required information for home-manager to do its job
  home = {
    stateVersion = "23.11";
    username = "sakhib";
    homeDirectory = "/home/sakhib";

    # Tell it to map everything in the `config` directory in this
    # repository to the `.config` in my home-manager directory
    file.".config" = {
      source = ../config;
      recursive = true;
    };

    # Media folder to symlink /media
    file."Media" = {
      source = config.lib.file.mkOutOfStoreSymlink "/media";
    };
  };

  # Install linux related package base
  packages.isMacOS = false;

  # Use Linux configured git configs
  git.isMacOS = false;

  # Let's enable home-manager
  programs.home-manager.enable = true;
}
