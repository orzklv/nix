{ config, pkgs, ... }:

{
  services.bind = {
    enable = true;
    extraConfig = ''
      options {
        directory "/var/bind";
        allow-query { any; };
        allow-transfer { 65.109.61.35; }; # IP address of the slave server ns2.kolyma.uz
      };
    '';

    zones = {
      "dumba.uz" = {
        file = "master/dumba.uz";
        master = true;
      };
    };

    zonesFiles."master/dumba.uz" = ''
      $TTL 86400
      @     IN  SOA  ns1.kolyma.uz. admin.dumba.uz. (
                2024010101 ; serial
                3600       ; refresh (1 hour)
                900        ; retry (15 minutes)
                604800     ; expire (1 week)
                86400      ; minimum (1 day)
              )
      @     IN  NS   ns1.kolyma.uz.
      @     IN  NS   ns2.kolyma.uz.
      @     IN  A    76.76.21.21
    '';
  };

  # DNS standard port for connections + that require more than 512 bytes
  networking.firewall.allowedUDPPorts = [ 53 ];
  networking.firewall.allowedTCPPorts = [ 53 ]; 
}