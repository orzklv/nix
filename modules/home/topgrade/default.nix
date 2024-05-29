{pkgs, ...}: {
  programs.topgrade = {
    enable = true;
    settings = {
      misc = {
        disable = [
          "bun"
          "node"
          "pnpm"
          "yarn"
          "cargo"
          "vscode"
        ];
        no_retry = true;
        assume_yes = true;
        no_self_update = true;   
      };
      commands = {};
      linux = {
        nix_arguments = "--flake github:orzklv/nix";
        home_manager_arguments = ["--flake" "github:orzklv/nix"];
      };
      brew = {
        autoremove = true;
      };
    };
  };
}
