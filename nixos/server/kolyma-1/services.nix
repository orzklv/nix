{
  config,
  lib,
  pkgs,
  outputs,
  ...
}: {
  # Deployed Services
  imports = [
    outputs.serverModules.data
    outputs.serverModules.bind
    outputs.serverModules.caddy.kolyma-1
    outputs.serverModules.container.kolyma-1
  ];

  # Enable Nameserver hosting
  services.nameserver = {
    enable = true;
    type = "master";
    zones = [
      "kolyma.uz"
      "dumba.uz"
      "katsuki.moe"
    ];
  };
}