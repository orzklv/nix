{
  pkgs,
  inputs,
  ...
}: {
  config = {
    # Installing zsh for system
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableBashCompletion = true;
      enableSyntaxHighlighting = true;
    };

    programs.direnv = {
      enable = true;
      silent = true;
      loadInNixShell = false;
      nix-direnv.enable = true;
      direnvrcExtra = ''
        echo "Direnv has been loaded!"
      '';
    };

    # System configurations
    # environment = {
    #   shells = with pkgs; [zsh];
    #   pathsToLink = ["/share/zsh"];
    #   systemPackages = [inputs.home-manager.packages.${pkgs.system}.default];
    # };
  };
}
