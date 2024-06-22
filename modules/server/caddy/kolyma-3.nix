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
        "kolyma.uz" = {
          serverAliases = [
            "www.kolyma.uz"
            "ns3.kolyma.uz"
            "http://95.216.248.25"
            "http://2a01:4f9:3070:322c::"
          ];
          extraConfig = ''
            reverse_proxy 127.0.0.1:8440
          '';
        };

        "khakimovs.uz" = {
          serverAliases = [
            "www.khakimovs.uz"
          ];
          extraConfig = ''
            reverse_proxy 127.0.0.1:8441
          '';
        };
      };
    };

    # Ensure the firewall allows HTTP and HTTPS traffic
    networking.firewall.allowedTCPPorts = [80 443];
    networking.firewall.allowedUDPPorts = [80 443];
  };
}
