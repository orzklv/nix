# Keep all folder specific configs here as a module
{
  # List your sub modules here
  server = import ./server.nix;
  media = import ./media.nix;
}
