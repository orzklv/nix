{...}: {
  # Prettier terminal prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      battery.disabled = true;
    };
  };

  # Zpxide path integration
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
