{
  config,
  lib,
  pkgs,
  ...
}: {
  config = {
    # Configure Caddy
    services.caddy = {
      # Enable the Caddy web server
      enable = true;

      # Define a simple virtual host
      virtualHosts = {
        "https://5.9.66.12" = {
          extraConfig = ''
            redir https://kolyma.uz
          '';
        };

        "https://2A01:4F8:161:714C::2" = {
          extraConfig = ''
            redir https://kolyma.uz
          '';
        };

        "ns1.kolyma.uz" = {
          extraConfig = ''
            redir https://kolyma.uz
          '';
        };
      };
    };

    # Ensure the firewall allows HTTP and HTTPS traffic
    networking.firewall.allowedTCPPorts = [80 443];
  };
}
