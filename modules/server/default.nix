# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/ wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  bind = import ./bind;
  data = import ./data;
  caddy = import ./caddy;
  container = import ./container;
}
