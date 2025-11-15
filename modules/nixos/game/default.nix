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
        # Resolution stretching
        gamescopeSession.enable = true;
        # Things to include within steam
        extraPackages = with pkgs; [
          bumblebee
          jdk
          gamescope
        ];
      };

      # Appimage games
      appimage = {
        enable = true;
        binfmt = true;
      };

      # For steam
      java.enable = true;
    };

    # Other launchers with configurations.
    environment.systemPackages = with pkgs; [
      cartridges
      prismlauncher
      pango
      harfbuzz
      fontconfig
      pkgsi686Linux.pango
      pkgsi686Linux.harfbuzz
      pkgsi686Linux.fontconfig
    ];
  };
}
