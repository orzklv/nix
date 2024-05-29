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
        allow-transfer { 65.109.61.35; }; # IP address of the slave server ns2.kolyma.uz
      };
    '';

    zones = {
      "dumba.uz" = {
        master = true;
        name = "dumba.uz";
        file = "/var/dns/dumba.uz.zone";
      };
    };
  };

  system.activationScripts.copyZones = lib.mkForce {
    text = ''
      mkdir -p /var/dns
      for zoneFile in ${../../../configs/zones}/*.zone; do
        cp -f "$zoneFile" /var/dns/
      done
    '';
    deps = [];
  };

  # DNS standard port for connections + that require more than 512 bytes
  networking.firewall.allowedUDPPorts = [53];
  networking.firewall.allowedTCPPorts = [53];
}
