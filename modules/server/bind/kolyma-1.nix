{
  config,
  pkgs,
  lib,
  ...
}: {
  services.bind = {
    enable = true;
    directory = "/var/bind";

    zones = {
      "dumba.uz" = {
        master = true;
        name = "dumba.uz";
        file = "/var/dns/dumba.uz.zone";
        slaves = ["65.109.61.35"];
      };
    };
  };

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
}
