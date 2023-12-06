{ config, lib, pkgs, ... }:
{
  # SSL Certification Configs
  security.acme = {
    acceptTerms = true;
    defaults.email = "cctld@uzinfocom.uz";
  };

  security.acme.certs."localhost" = {
    webroot = "/var/lib/acme/.challenges";
    email = "cctld@uzinfocom.uz";
    # Ensure that the web server you use can read the generated certs
    # Take a look at the group option for the web server you choose.
    group = "nginx";
    # Since we have a wildcard vhost to handle port 80,
    # we can generate certs for anything!
    # Just make sure your DNS resolves them.
    extraDomainNames = [ "mail.localhost" ];
  };

  users.users.nginx.extraGroups = [ "acme" ];

  # Configure Nginx
  services.nginx = {
    # Enable the Nginx web server
    enable = true;

    # Define a simple virtual host
    virtualHosts = {
      "localhost" = {
        # Enable and force SSL
        enableACME = true;
        forceSSL = true;

        serverAliases = [ 
          "172.16.9.179"
          "192.168.0.2"
        ];

        # Specify the root directory for the website
        root = "/var/www/localhost";

        # Basic configuration for serving static files
        locations."/" = {
          extraConfig = ''
            index index.html;
          '';
        };
      };

      "acmechallenge.localhost" = {
        # Catchall vhost, will redirect users to HTTPS for all vhosts
        locations."/.well-known/acme-challenge" = {
          root = "/var/lib/acme/.challenges";
        };
        locations."/" = {
          return = "301 https://$host$request_uri";
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