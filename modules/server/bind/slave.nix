{ config, pkgs, ... }:

{
  services.bind = {
    enable = true;
    extraConfig = ''
      options {
        directory "/var/bind";
        allow-query { any; };
      };
    '';

    zones = {
      "dumba.uz" = {
        file = "slave/dumba.uz";
        masters = [ "5.9.66.12" ]; # IP address of the master server ns1.kolyma.uz
      };
    };
  };

  # DNS standard port for connections + that require more than 512 bytes
  networking.firewall.allowedUDPPorts = [ 53 ];
  networking.firewall.allowedTCPPorts = [ 53 ]; 
}