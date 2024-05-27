# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/ wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  www = import ./www;
  zsh = import ./zsh;
  game = import ./game;
  sound = import ./sound;
  fonts = import ./fonts;
  gnome = import ./gnome;
  users = import ./users;
  media = import ./media;
  bootloader = import ./bootloader;
}
