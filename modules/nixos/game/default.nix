{pkgs, ...}: {
  config = {
    # Gayming at its finest
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };

    # Enable the Gnome Tweaks tool.
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
