{
  pkgs,
  inputs,
  ...
}: {
  config = {
    programs = {
      # Installing zsh for system
      zsh = {
        enable = true;
        vteIntegration = true;
        enableCompletion = true;
        autosuggestions.enable = true;
        enableBashCompletion = true;
        syntaxHighlighting.enable = true;
      };

      # Automatic flake devShell loading
      direnv = {
        enable = true;
        silent = true;
        loadInNixShell = false;
        nix-direnv.enable = true;
        enableZshIntegration = true;
      };

      # Replace commant not found with nix-index
      nix-index = {
        # enable = true;
        # enableBashIntegration = true;
        # enableZshIntegration = true;
      };
    };

    # All users default shell must be zsh
    users.defaultUserShell = pkgs.zsh;

    # System configurations
    environment = {
      shells = with pkgs; [zsh];
      pathsToLink = ["/share/zsh"];
      systemPackages = [inputs.home-manager.packages.${pkgs.system}.default];
    };
  };
}
