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
        master = false;
        file = "/var/dns/dumba.uz.zone";
        masters = ["5.9.66.12"]; # IP address of the master server ns1.kolyma.uz
      };
    };
  };

  # DNS standard port for connections + that require more than 512 bytes
  networking.firewall.allowedUDPPorts = [53];
  networking.firewall.allowedTCPPorts = [53];
}
