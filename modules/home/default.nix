# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  git = import ./git;
  zsh = import ./zsh;
  helix = import ./helix;
  nixpkgs = import ./nixpkgs;
  terminal = import ./terminal;
  topgrade = import ./topgrade;
  packages = import ./packages;
}
