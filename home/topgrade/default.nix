{ pkgs, ... }: {
  programs.topgrade = {
    enable = true;
    settings = {
      misc = {
        assume_yes = true;
        disable = [
          "bun"
          "node"
          "pnpm"
        ];
      };
      git = {
        max_concurrency = 5;
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