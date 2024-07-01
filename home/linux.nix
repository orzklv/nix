{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  packages,
  ...
}: {
  imports = lib.traceSeqN 2 outputs [
    outputs.homeManagerModules.zsh
    outputs.homeManagerModules.git
    outputs.homeManagerModules.helix
    outputs.homeManagerModules.neovim
    outputs.homeManagerModules.nixpkgs
    outputs.homeManagerModules.topgrade
    outputs.homeManagerModules.terminal
    outputs.homeManagerModules.packages
  ];

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
