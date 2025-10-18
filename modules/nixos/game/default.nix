{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.aagl.nixosModules.default
  ];

  config = {
    programs = {
      # Prepare for the worst
      nix-ld = {
        enable = true;
        libraries = pkgs.steam-run.args.multiPkgs pkgs;
      };

      # Gayming at its finest
      steam = {
        enable = true;
        # Open ports in the firewall for Steam Remote Play
        remotePlay.openFirewall = true;
        # Open ports in the firewall for Source Dedicated Server
        dedicatedServer.openFirewall = true;
        # Open ports in the firewall for Steam Local Network Game Transfers
        localNetworkGameTransfers.openFirewall = true;
      };

      # Xuyovo Labs games launchers!
      anime-game-launcher.enable = true;
      anime-games-launcher.enable = true;
    };

    # Other launchers with configurations.
    environment.systemPackages = with pkgs; [
      cartridges
      prismlauncher
      (lutris.override {
        extraPkgs = _pkgs: [
          # List package dependencies here
        ];
        extraLibraries = _pkgs: [
          # List library dependencies here
        ];
      })
    ];
  };
}
