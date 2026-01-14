{ pkgs, ... }:
{
  # Add all necessary fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    sf-mono-liga
  ];
}
