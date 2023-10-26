{ pkgs, ... }: {
  programs.topgrade = {
    enable = true;
    settings = {
      assume_yes = true;
      disable = [
        "bun"
        "node"
        "pnpm"
      ];
      git = {
        max_concurrent = 5;
        repos = [
          "~./keys"
        ];
      };
      commands = {
        "Volta" = "volta install node@lts pnpm prettier rome";
      };
      brew = {
        autoremove = true;
      };
    };
  };
}