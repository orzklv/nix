{
  pkgs,
  inputs,
  ...
}: {
  config = {
    # Installing zsh for system
    programs.zsh = {
      enable = true;
      vteIntegration = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      enableBashCompletion = true;
      syntaxHighlighting.enable = true;
    };

    # All users default shell must be zsh
    users.defaultUserShell = pkgs.zsh;

    # Automatic flake devShell loading
    programs.direnv = {
      enable = true;
      silent = true;
      loadInNixShell = false;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };

    # Replace commant not found with nix-index
    programs.nix-index = {
      # enable = true;
      # enableBashIntegration = true;
      # enableZshIntegration = true;
    };

    # System configurations
    environment = {
      shells = with pkgs; [zsh];
      pathsToLink = ["/share/zsh"];
      systemPackages = [inputs.home-manager.packages.${pkgs.system}.default];
    };
  };
}
