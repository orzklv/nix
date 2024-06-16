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
      # Personal Space
      "orzklv.uz"
      "kolyma.uz"
      "katsuki.moe"

      # Not that personal
      "khakimovs.uz"
      "dumba.uz"
      
      # Projects
      "cxsmxs.space"
      "floss.uz"
      "rust-lang.uz"
      "xinux.uz"
    ];
    slaves = ["65.109.61.1"];
  };
}
