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
    outputs.serverModules.caddy.kolyma-2
    outputs.serverModules.container.kolyma-2
  ];

  # Enable Nameserver hosting
  services.nameserver = {
    enable = true;
    type = "slave";
    zones = [
      "orzklv.uz"
      "kolyma.uz"
      "khakimovs.uz"
      "dumba.uz"
      "katsuki.moe"
      "cxsmxs.space"
    ];
    masters = ["5.9.66.12"];
  };
}
