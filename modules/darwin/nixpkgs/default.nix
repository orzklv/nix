{
  lib,
  config,
  inputs,
  ...
}: {
  config = {
    nixpkgs = {
      # You can add overlays here
      overlays = [
        # Add overlays your own flake exports (from overlays and pkgs dir):
        inputs.orzklv-pkgs.overlays.unstable
        inputs.orzklv-pkgs.overlays.additions
        inputs.orzklv-pkgs.overlays.modifications

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
      enable = true;

      # This will add each flake input as a registry
      # To make nix3 commands consistent with your flake
      # registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

      # This will additionally add your inputs to the system's legacy channels
      # Making legacy nix commands consistent as well, awesome!
      nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

      # Customized nix packages for rollback purposes
      # package = pkgs.nix;

      # Linux builder for Linux projects
      linux-builder = {
        enable = true;
        ephemeral = true;
      };

      # Additional settings
      settings = {
        # Enable flakes and new 'nix' command
        experimental-features = "nix-command flakes";
        # Trusted users for secret-key
        trusted-users = [
          "${config.users.users.sakhib.name}"
        ];
      };
    };
  };
}
