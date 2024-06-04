{
  config,
  pkgs,
  lib,
  ...
}: let
  # Generate a slave zone object
  masterZoneGenerator = zone: {
    master = true;
    file = "/var/dns/${zone}.zone";
    slaves = ["65.109.61.35"]; # IP address of the slave server ns2.kolyma.uz
  };

  # Map through given array of zones and generate zone object list
  masterZonesMap = zones: lib.listToAttrs (map (zone: { name = zone; value = masterZoneGenerator zone; }) zones);
in {
  config = {
    services.bind = {
      enable = true;
      directory = "/var/bind";

      zones = masterZonesMap [
        "kolyma.uz"
        "katsuki.moe"
        "dumba.uz"
      ];

    #   zones = {
    #     "kolyma.uz" = {
    #       master = true;
    #       file = "/var/dns/kolyma.uz.zone";
    #       slaves = ["65.109.61.35"];
    #     };

    #     "katsuki.moe" = {
    #       master = true;
    #       file = "/var/dns/katsuki.moe.zone";
    #       slaves = ["65.109.61.35"];
    #     };

    #     "dumba.uz" = {
    #       master = true;
    #       file = "/var/dns/dumba.uz.zone";
    #       slaves = ["65.109.61.35"];
    #     };
    #   };
    # };

    # Copy all zone files to /var/dns
    system.activationScripts.copyZones = lib.mkForce {
      text = ''
        mkdir -p /var/dns
        for zoneFile in ${./zones}/*.zone; do
          cp -f "$zoneFile" /var/dns/
        done
      '';
      deps = [];
    };

    # DNS standard port for connections + that require more than 512 bytes
    networking.firewall.allowedUDPPorts = [53];
    networking.firewall.allowedTCPPorts = [53];
  };
}
