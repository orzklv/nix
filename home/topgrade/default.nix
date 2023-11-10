{pkgs, ...}: {
  programs.topgrade = {
    enable = true;
    settings = {
      misc = {
        assume_yes = true;
        disable = [
          "bun"
          "node"
          "pnpm"
          "home_manager"
        ];
      };
      brew = {
        autoremove = true;
      };
    };
  };
}
