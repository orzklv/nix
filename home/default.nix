{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  packages,
  system ? (import <nixpkgs/nixos> {}).config,
  ...
}: let
  isMacOS = pkgs.stdenv.hostPlatform.system == "aarch64-darwin" || pkgs.stdenv.hostPlatform.system == "x86_64-darwin";

  desktop = lib.mkIf ((!isMacOS) && system.services.xserver.enable) {
    desktop.enable = true;
  };

  macos = lib.mkIf isMacOS {
    # imports = [];

    home = {
      homeDirectory = "/Users/sakhib";
    };

    # This is to ensure programs are using ~/.config rather than
    # /Users/sakhib/Library/whatever
    xdg.enable = true;
  };

  linux = lib.mkIf (!isMacOS) {
    imports = lib.traceSeqN 2 outputs [
      outputs.homeManagerModules.gtk
      outputs.homeManagerModules.terminal
    ];

    home = {
      homeDirectory = "/home/sakhib";

      # Don't check if home manager is same as nixpkgs
      enableNixpkgsReleaseCheck = false;
    };
  };

  cfg = {
    imports = lib.traceSeqN 2 outputs [
      outputs.homeManagerModules.zsh
      outputs.homeManagerModules.git
      outputs.homeManagerModules.helix
      outputs.homeManagerModules.neovim
      outputs.homeManagerModules.nixpkgs
      outputs.homeManagerModules.topgrade
      outputs.homeManagerModules.packages
    ];

    home = {
      stateVersion = "24.05";
      username = "sakhib";

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
    };

    # Let's enable home-manager
    programs.home-manager.enable = true;
  };
in
  lib.mkMerge [cfg macos linux desktop]
