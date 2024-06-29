# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/ wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  zsh = import ./zsh;
  boot = import ./boot;
  game = import ./game;
  sound = import ./sound;
  media = import ./media;
  fonts = import ./fonts;
  users = import ./users;
  desktop = import ./desktop;
}
