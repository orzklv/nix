{ pkgs, ... }: {
  # Zpxide path integration
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
