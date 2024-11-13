{ pkgs, lib, ... }:
let
  is-darwin =
    pkgs.stdenv.hostPlatform.system == "aarch64-darwin"
    || pkgs.stdenv.hostPlatform.system == "x86_64-darwin";

  darwin = lib.mkIf is-darwin {
    commands."Darwin Nix" = "darwin-rebuild switch --flake github:orzklv/nix";
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
        "home_manager"
      ];
      no_retry = true;
      assume_yes = true;
      no_self_update = true;
    };

    pre_commands = {
      "Clean Nix Store" = "nix store gc";
    };

    linux = {
      nix_arguments = "--flake github:orzklv/nix";
      home_manager_arguments = [ "--flake" "github:orzklv/nix" ];
    };

    brew = {
      autoremove = true;
    };
  };
in
{
  config = {
    programs.topgrade = {
      enable = true;
      settings = lib.mkMerge [ cfg darwin ];
    };
  };
}
