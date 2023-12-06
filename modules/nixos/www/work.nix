{ config, lib, pkgs, ... }:
{
  # Configure Caddy
  services.caddy = {
    # Enable the Caddy web server
    enable = true;

    # Define a simple virtual host
    virtualHosts = {
      "192.168.0.2" = {
        extraConfig = ''
          root * /var/www/localhost
          file_server
        '';
      };

      "172.16.9.179" = {
        extraConfig = ''
          root * /var/www/localhost
          file_server
        '';
      };
    };
  };

  # Ensure the firewall allows HTTP and HTTPS traffic
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}