{
  self,
  inputs,
  outputs,
  lib,
  pkgs,
  config,
  packages,
  ...
}:
let
  modules = [
    outputs.homeModules.zsh
    outputs.homeModules.git
    outputs.homeModules.nixpkgs
    outputs.homeModules.topgrade
    outputs.homeModules.packages
  ];

  osx = builtins.elem pkgs.system [
    "aarch64-darwin"
    "x86_64-darwin"
  ];

  home = if osx then "Users" else "home";

  macos = lib.mkIf osx {
    # Leave here configs that should be applied only at macos machines

    # This is to ensure programs are using ~/.config rather than
    # /Users/sakhib/Library/whatever
    xdg.enable = true;
  };

  linux = lib.mkIf (!osx) {
    # Leave here configs that should be applied only at linux machines
  };

  cfg = {
    # This is required information for home-manager to do its job
    home = {
      stateVersion = "24.11";
      username = "sakhib";
      homeDirectory = "/${home}/sakhib";
      enableNixpkgsReleaseCheck = false;

      # Tell it to map everything in the `config` directory in this
      # repository to the `.config` in my home-manager directory
      file.".config" = {
        source = ./configs/config;
        recursive = true;
      };

      file.".local/share" = {
        source = ./configs/share;
        recursive = true;
      };
    };

    # Let's enable home-manager
    programs.home-manager.enable = true;
  };
in
{
  imports = modules;

  config = lib.mkMerge [
    cfg
    macos
    linux
  ];
}
