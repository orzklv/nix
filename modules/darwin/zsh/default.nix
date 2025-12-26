{...}: {
  config = {
    programs = {
      # Installing zsh for system
      zsh = {
        enable = true;
        enableCompletion = true;
        enableBashCompletion = true;
        enableSyntaxHighlighting = true;
      };

      # Automatic flake devShell loading
      direnv = {
        enable = true;
        silent = true;
        loadInNixShell = false;
        nix-direnv.enable = true;
      };

      # Replace commant not found with nix-index
      nix-index = {
        enable = true;
      };
    };
  };
}
