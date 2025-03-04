{
  outputs,
  lib,
  config,
  inputs,
  ...
}: {
  config = {
    # Auto upgrade nix package and the daemon service.
    services.nix-daemon.enable = true;

    nixpkgs = {
      # You can add overlays here
      overlays = [
        # Add overlays your own flake exports (from overlays and pkgs dir):
        outputs.overlays.modifications
        outputs.overlays.unstable-packages

        # Personal repo of packages
        inputs.orzklv-pkgs.overlays.additions

        # You can also add overlays exported from other flakes:
        # neovim-nightly-overlay.overlays.default

        # Or define it inline, for example:
        # (final: prev: {
        #   hi = final.hello.overrideAttrs (oldAttrs: {
        #     patches = [ ./change-hello-to-hi.patch ];
        #   });
        # })
      ];
      # Configure your nixpkgs instance
      config = {
        # Disable if you don't want unfree packages
        allowUnfree = true;
        # Disable if you don't want linux thingies on mac
        allowUnsupportedSystem = true;
        # Workaround for https://github.com/nix-community/home-manager/issues/2942
        allowUnfreePredicate = _: true;
        # Let the system use fucked up programs
        allowBroken = true;
      };
    };

    nix = {
      # This will add each flake input as a registry
      # To make nix3 commands consistent with your flake
      # registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

      # This will additionally add your inputs to the system's legacy channels
      # Making legacy nix commands consistent as well, awesome!
      nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

      # Customized nix packages for rollback purposes
      # package = pkgs.nix;

      # Additional settings
      settings = {
        # Enable flakes and new 'nix' command
        experimental-features = "nix-command flakes";
        # Trusted users for secret-key
        trusted-users = [
          "${config.users.users.sakhib.name}"
        ];
        # Additional servers to fetch binary from
        substituters = [
          "https://cache.xinux.uz/"
        ];
        # Keys that packages to be signed with
        trusted-public-keys = [
          "cache.xinux.uz-1:gX2Z53woXiIoLANfcC/Qp7vPPKVdK1sEa8MSiRhjj/M="
        ];
      };
    };
  };
}
