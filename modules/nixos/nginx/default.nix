{ config, lib, pkgs, ... }:
{
  # Configure Caddy
  services.caddy = {
    # Enable the Caddy web server
    enable = true;

    # Define a simple virtual host
    virtualHosts = {
        # # Specify the root directory for the website
      "localhost" = {
        extraConfig = ''
          encode gzip
          file_server
          root * /var/www/localhost
        '';

        serverAlias = [ 
          "172.16.9.179"
          "192.168.0.2"
        ];
      };
    };
  };

  # Ensure the firewall allows HTTP and HTTPS traffic
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}