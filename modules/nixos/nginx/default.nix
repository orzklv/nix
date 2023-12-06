{ config, lib, pkgs, ... }:
{
  # Configure Caddy
  services.caddy = {
    # Enable the Caddy web server
    enable = true;

    # Define a simple virtual host
    virtualHosts = {
      # Specify the root directory for the website
      "localhost" = {
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