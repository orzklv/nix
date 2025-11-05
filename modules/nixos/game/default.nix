{
  inputs,
  pkgs,
  ...
}: {
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
    };

    # Other launchers with configurations.
    environment.systemPackages = with pkgs; [
      cartridges
      prismlauncher
    ];
  };
}
