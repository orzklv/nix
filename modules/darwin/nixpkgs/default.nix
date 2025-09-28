{
  lib,
  config,
  inputs,
  ...
}: {
  imports = [inputs.determinate.darwinModules.default];

  config = rec {
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
      # Don't touch Determinate Nix
      enable = false;

      # This will add each flake input as a registry
      # To make nix3 commands consistent with your flake
      # registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

      # This will additionally add your inputs to the system's legacy channels
      # Making legacy nix commands consistent as well, awesome!
      nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

      # Additional settings
      settings = {
        # Enable flakes and new 'nix' command
        experimental-features = "nix-command flakes pipe-operators repl-flake";

        # Determinate Nix related configurations
        extra-experimental-features = "parallel-eval external-builders";

        # Cores to use to evaluate expressions
        eval-cores = 0;

        # Enable lazy tree feature
        lazy-trees = true;

        # Define external builders
        external-builders = "[{\"systems\":[\"aarch64-linux\",\"x86_64-linux\"],\"program\":\"/usr/local/bin/determinate-nixd\",\"args\":[\"builder\"]}]";

        # Trusted users for secret-key
        trusted-users = [
          "${config.users.users.sakhib.name}"
        ];
      };
    };

    # Custom settings written to /etc/nix/nix.custom.conf
    determinate-nix.customSettings =
      {
        flake-registry = "/etc/nix/flake-registry.json";
      }
      // nix.settings;
  };
}
