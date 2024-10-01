{ inputs
, lib
, pkgs
, config
, outputs
, packages
, self
, ...
}:
let
  modules = [
    outputs.homeManagerModules.zsh
    outputs.homeManagerModules.git
    outputs.homeManagerModules.helix
    outputs.homeManagerModules.nixpkgs
    outputs.homeManagerModules.topgrade
    outputs.homeManagerModules.packages
  ];

  osx =
    builtins.elem pkgs.system [
      "aarch64-darwin"
      "x86_64-darwin"
    ];

  home =
    if osx
    then "Users"
    else "home";

  macos = lib.mkIf osx {
    # This is to ensure programs are using ~/.config rather than
    # /Users/sakhib/Library/whatever
    xdg.enable = true;
  };

  linux = lib.mkIf (!osx) {
    # This is required information for home-manager to do its job
    home = {
      # Don't check if home manager is same as nixpkgs
      enableNixpkgsReleaseCheck = false;
    };
  };

  cfg = {
    # This is required information for home-manager to do its job
    home = {
      stateVersion = "24.05";
      username = "sakhib";
      homeDirectory = "/${home}/sakhib";

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
