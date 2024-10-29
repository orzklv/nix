{ pkgs, ... }:
{
  config = {
    programs.topgrade = {
      enable = true;
      settings = {
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
          pre_sudo = true;
          no_retry = true;
          assume_yes = true;
          no_self_update = true;
        };
        commands = {
          "Darwin Nix" = "sudo darwin-rebuild switch --flake github:orzklv/nix";
        };
        linux = {
          nix_arguments = "--flake github:orzklv/nix";
          home_manager_arguments = [ "--flake" "github:orzklv/nix" ];
        };
        brew = {
          autoremove = true;
        };
      };
    };
  };
}
