# Add your reusable Darwin modules to this directory, on their own file (https://wiki.nixos.org/ wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
#
# Refer to the link below for more options:
# https://daiderd.com/nix-darwin/manual/index.html
{
  # List your module files here
  zsh = import ./zsh;
  users = import ./users;
  secret = import ./secret;
  homebrew = import ./homebrew;
  nixpkgs = import ./nixpkgs;
}
