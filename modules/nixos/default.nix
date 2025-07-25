# Add your reusable NixOS modules to this directory, on their own file (https://wiki.nixos.org/ wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
#
# Refer to the link below for more options:
# https://search.nixos.org/options
{
  # List your module files here
  ssh = import ./ssh;
  zsh = import ./zsh;
  boot = import ./boot;
  game = import ./game;
  vpn = import ./vpn;
  sound = import ./sound;
  data = import ./data;
  fonts = import ./fonts;
  users = import ./users;
  secret = import ./secret;
  desktop = import ./desktop;
  nixpkgs = import ./nixpkgs;
}
