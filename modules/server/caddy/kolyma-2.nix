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
            "ns2.kolyma.uz"
            "http://65.109.61.35"
            "http://2a01:4f9:5a:5110::"
            "cxsmxs.space"
            "www.cxsmxs.space"
          ];
          extraConfig = ''
            reverse_proxy 127.0.0.1:8440
          '';
        };

        "mail.kolyma.uz" = {
          extraConfig = ''
            reverse_proxy 127.0.0.1:8460
          '';
        };

        "git.kolyma.uz" = {
          extraConfig = ''
            reverse_proxy 127.0.0.1:8450
          '';
        };
      };
    };

    # Ensure the firewall allows HTTP and HTTPS traffic
    networking.firewall.allowedTCPPorts = [80 443];
    networking.firewall.allowedUDPPorts = [80 443];
  };
}
