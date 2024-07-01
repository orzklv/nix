{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  packages,
  ...
}: let
  isMacOS = false;
in {
  imports = lib.traceSeqN 2 outputs [
    outputs.homeManagerModules.zsh
    outputs.homeManagerModules.git
    outputs.homeManagerModules.gtk
    outputs.homeManagerModules.helix
    outputs.homeManagerModules.neovim
    outputs.homeManagerModules.topgrade
    outputs.homeManagerModules.terminal
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
    stateVersion = "24.05";
    username = "sakhib";
    homeDirectory = "/home/sakhib";

    # Tell it to map everything in the `config` directory in this
    # repository to the `.config` in my home-manager directory
    file.".config" = {
      source = ../configs/config;
      recursive = true;
    };

    file.".local/share" = {
      source = ../configs/share;
      recursive = true;
    };

    # Don't check if home manager is same as nixpkgs
    enableNixpkgsReleaseCheck = false;
  };

  # Let's enable home-manager
  programs.home-manager.enable = true;
}
