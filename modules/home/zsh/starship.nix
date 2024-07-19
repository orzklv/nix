{ pkgs, ... }: {
  # Prettier terminal prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      battery.disabled = true;
    };
  };
}
