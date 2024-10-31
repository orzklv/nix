# Add your reusable Darwin modules to this directory, on their own file (https://wiki.nixos.org/ wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  users = import ./users;
  homebrew = import ./homebrew;
}
