{ 
  config, 
  pkgs, 
  lib,
  ...
}: {
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
        slave = true;
        file = "/var/dns/dumba.uz.zone";
        masters = [ "5.9.66.12" ]; # IP address of the master server ns1.kolyma.uz
      };
    };
  };

  # system.activationScripts.copyZones = lib.mkForce {
  #   text = ''
  #     mkdir -p /var/dns
  #     for zoneFile in ${../../../configs/zones}/*.zone; do
  #       cp -f "$zoneFile" /var/dns/
  #     done
  #   '';
  #   deps = [];
  # };

  # DNS standard port for connections + that require more than 512 bytes
  networking.firewall.allowedUDPPorts = [ 53 ];
  networking.firewall.allowedTCPPorts = [ 53 ]; 
}