{
  inputs,
  config,
  lib,
  ...
}:
{
  config = rec {
    sops.secrets.builder-key = {
      format = "binary";
      sopsFile = ../../../secrets/builder.hell;
    };

    nix = {
      enable = true;

      # This will add each flake input as a registry
      # To make nix3 commands consistent with your flake
      registry = lib.mkForce (lib.mapAttrs (_: value: { flake = value; }) inputs);

      # This will additionally add your inputs to the system's legacy channels
      # Making legacy nix commands consistent as well, awesome!
      nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

      # Enable building on remote builders
      distributedBuilds = true;

      # Distributed builds for cross-platform builds
      buildMachines = [
        {
          hostName = "ns3.kolyma.uz";
          sshUser = "builder";
          sshKey = config.sops.secrets.builder-key.path;
          system = "x86_64-linux";
          protocol = "ssh-ng";
          maxJobs = 3;
          speedFactor = 2;
          supportedFeatures = [
            "nixos-test"
            "benchmark"
            "big-parallel"
            "kvm"
          ];
        }
      ];

      # Additional settings
      settings = {
        # Trusted users for secret-key
        trusted-users = [
          "${config.users.users.sakhib.name}"
        ];

        # Enable flakes and new 'nix' command
        experimental-features = "nix-command flakes pipe-operators";

        # Enable IDF for the love of god
        # allow-import-from-derivation = true;
      };
    };
  };
}
