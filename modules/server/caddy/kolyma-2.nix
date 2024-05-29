{
  config,
  lib,
  pkgs,
  ...
}: {
  # Configure Caddy
  services.caddy = {
    # Enable the Caddy web server
    enable = true;

    # Define a simple virtual host
    virtualHosts = {
      "ns2.kolyma.uz" = {
        extraConfig = ''
          redir https://kolyma.uz
        '';
      };
    };
  };

  # Ensure the firewall allows HTTP and HTTPS traffic
  networking.firewall.allowedTCPPorts = [80 443];
}
