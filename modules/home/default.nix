# Add your reusable home-manager modules to this directory, on their own file (https://wiki.nixos.org/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
#
# Refer to the link below for more options:
# https://nix-community.github.io/home-manager/options.xhtml
{
  # List your module files here
  git = import ./git;
  zsh = import ./zsh;
  ssh = import ./ssh;
  zed = import ./zed;
  helix = import ./helix;
  secret = import ./secret;
  nixpkgs = import ./nixpkgs;
  topgrade = import ./topgrade;
  packages = import ./packages;
  fastfetch = import ./fastfetch;
}
