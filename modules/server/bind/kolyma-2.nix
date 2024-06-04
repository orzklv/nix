{
  config,
  pkgs,
  lib,
  ...
}: let
  # Generate a slave zone object
  slaveZoneGenerator = zone: {
    master = false;
    file = "/var/dns/${zone}.zone";
    masters = ["5.9.66.12"]; # IP address of the master server ns1.kolyma.uz
  };

  # Map through given array of zones and generate zone object list
  slaveZonesMap = zones: lib.listToAttrs (map (zone: zone -> zone -> slaveZoneGenerator zone) zones);
in {
  config = {
    services.bind = {
      enable = true;
      directory = "/var/bind";

      zones = slaveZonesMap [
        "kolyma.uz"
        "katsuki.moe"
        "dumba.uz"
      ];

      # zones = {
      #   "kolyma.uz" = {
      #     master = false;
      #     file = "/var/dns/kolyma.uz.zone";
      #     masters = ["5.9.66.12"]; # IP address of the master server ns1.kolyma.uz
      #   };

      #   "dumba.uz" = {
      #     master = false;
      #     file = "/var/dns/dumba.uz.zone";
      #     masters = ["5.9.66.12"]; # IP address of the master server ns1.kolyma.uz
      #   };
      # };
    };

    # DNS standard port for connections + that require more than 512 bytes
    networking.firewall.allowedUDPPorts = [53];
    networking.firewall.allowedTCPPorts = [53];
  };
}
