{ pkgs, ... }: {
  programs.topgrade = {
    enable = true;
    settings = {
      misc = {
        assume_yes = true;
        disable = [
          "nix"
          "bun"
          "node"
          "pnpm"
          "yarn"
          "home_manager"
        ];
      };
      commands = {
        "Nix" = "nix-channel --update && nix-env -u '*'";
        "Home Manager" = "home-manager switch --flake github:orzklv/nix";
      };
      brew = {
        autoremove = true;
      };
    };
  };
}
