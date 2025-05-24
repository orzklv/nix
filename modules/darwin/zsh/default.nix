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

    # Automatic flake devShell loading
    programs.direnv = {
      enable = true;
      silent = true;
      loadInNixShell = false;
      nix-direnv.enable = true;
    };

    # Replace commant not found with nix-index
    programs.nix-index = {
      enable = true;
    };
  };
}
