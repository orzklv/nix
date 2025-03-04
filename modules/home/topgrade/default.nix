{
  pkgs,
  lib,
  ...
}: let
  darwin = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    commands."Darwin Nix" = "darwin-rebuild switch --flake github:orzklv/nix --option tarball-ttl 0";
  };

  cfg = {
    misc = {
      disable = [
        "bun"
        "nix"
        "node"
        "pnpm"
        "yarn"
        "cargo"
        "vscode"
        "brew_cask"
        "containers"
        "brew_formula"
        "home_manager"
      ];
      no_retry = true;
      assume_yes = true;
      no_self_update = true;
    };

    linux = {
      nix_arguments = "--flake github:orzklv/nix --option tarball-ttl 0";
    };

    brew = {
      autoremove = true;
    };
  };
in {
  config = {
    programs.topgrade = {
      enable = true;
      settings = lib.mkMerge [
        cfg
        darwin
      ];
    };
  };
}
