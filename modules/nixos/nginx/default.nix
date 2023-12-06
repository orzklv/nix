{ config, lib, pkgs, ... }:

{
  # Configure Nginx
  services.nginx = {
    # Enable the Nginx web server
    enable = true;

    # Define a simple virtual host
    virtualHosts = {
      "localhost" = {
        # Specify the root directory for the website
        root = "/var/www/localhost";

        # Basic configuration for serving static files
        locations."/" = {
          extraConfig = ''
            index index.html;
          '';
        };
      };
    };
  };

  # Ensure the firewall allows HTTP and HTTPS traffic
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  # The following line is optional and only necessary if you are using Let's Encrypt
  # for SSL certificates
  # services.nginx.recommendedGzipSettings = true;

  # Additional system-wide settings can go here
}