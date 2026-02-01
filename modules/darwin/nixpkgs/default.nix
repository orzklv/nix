{
  inputs,
  config,
  lib,
  ...
}:
{
  config = rec {
    nix = {
      enable = true;

      # This will add each flake input as a registry
      # To make nix3 commands consistent with your flake
      registry = lib.mkForce (lib.mapAttrs (_: value: { flake = value; }) inputs);

      # This will additionally add your inputs to the system's legacy channels
      # Making legacy nix commands consistent as well, awesome!
      nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

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
