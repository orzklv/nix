{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  packages,
  ...
}: {
  # Modules
  imports = [
    ./zsh
    ./git
    ./helix
    ./topgrade
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
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
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

    # Packages to be installed on my machine
    packages = import ./packs/linux.nix {inherit pkgs;};

    # Set the default shell to the one you have enabled
    sessionVariables.SHELL = pkgs.zsh;
  };

  # Let's enable home-manager
  programs.home-manager.enable = true;
}