# In case if something goes wrong, go with these
# {
#   # List your nameservers here
#   kolyma-1 = import ./kolyma-1.nix;
#   kolyma-2 = import ./kolyma-2.nix;
# }
{
  config,
  pkgs,
  lib,
  ...
}: let
  # Statically defined list of zones
  zones = ["kolyma.uz"];

  generateZone = zone: type: let
    master = type == "master";
    file = "/var/dns/${zone}.zone";
  in
    if master then {
      inherit master file;
      slaves = config.services.nameserver.slaves;
    } else {
      inherit master file;
      masters = config.services.nameserver.masters;
    };

  # Map through given array of zones and generate zone object list
  zonesMap = zones: type:
    lib.listToAttrs (map (zone: {
        name = zone;
        value = generateZone zone type;
      })
      zones);

  # If type is master, activate system.activationScripts.copyZones
  zoneFiles = lib.mkIf (config.services.nameserver.enable && config.services.nameserver.type == "master") {
    system.activationScripts.copyZones = lib.mkForce {
      text = ''
        mkdir -p /var/dns
        for zoneFile in ${./zones}/*.zone; do
          cp -f "$zoneFile" /var/dns/
        done
      '';
      deps = [];
    };
  };

  cfg = lib.mkIf config.services.nameserver.enable {
    services.bind = {
      enable = config.services.nameserver.enable;
      directory = "/var/bind";
      zones = zonesMap config.services.nameserver.zones config.services.nameserver.type;
      cacheNetworks = [
        "127.0.0.0/24"
        "::1/128"
        "5.9.66.12" 
        "2a01:4f8:161:714c::" 
        "65.109.61.35" 
        "2a01:4f9:5a:5110::"
      ];
      extraOptions = ''
        allow-query-cache { cachenetworks; };
      '';
    };

    # DNS standard port for connections + that require more than 512 bytes
    networking.firewall.allowedUDPPorts = [53];
    networking.firewall.allowedTCPPorts = [53];
  };
in {
  options = {
    services.nameserver = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable the nameserver service";
      };

      type = lib.mkOption {
        type = lib.types.enum ["master" "slave"];
        default = "master";
        description = "The type of the bind zone, either 'master' or 'slave'.";
      };

      masters = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = ["5.9.66.12"];
        description = "IP address of the master server.";
      };

      slaves = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = ["65.109.61.35"];
        description = "List of slave servers.";
      };

      zones = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = zones;
        description = "List of zones to be served.";
      };
    };
  };

  config = lib.mkMerge [
    cfg
    zoneFiles
  ];
}
