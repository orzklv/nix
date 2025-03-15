# Fallback validation point of all modules
{...}: {
  # List all modules here to be included on config
  imports = [
    # Demo Actix + Diesel server
    ./demo-server.nix
  ];
}
