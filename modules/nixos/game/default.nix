{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.aagl.nixosModules.default
  ];

  config = {
    # Prepare for the worst
    programs.nix-ld = {
      enable = true;
      libraries =
        (with pkgs; [
          alsa-lib
          at-spi2-atk
          at-spi2-core
          atk
          cairo
          glibc
        ])
        ++ (pkgs.steam-run.fhsenv.args.multiPkgs pkgs);
    };

    # Gayming at its finest
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };

    # Xuyovo Labs games launchers!
    programs.anime-game-launcher.enable = true;
    programs.anime-games-launcher.enable = true;

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
