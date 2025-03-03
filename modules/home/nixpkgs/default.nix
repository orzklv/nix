{
  pkgs,
  config,
  inputs,
  outputs,
  ...
}: {
  config = {
    # Leave here configs that should be applied only at linux machines
    sops.secrets = {
      "nix-serve/private" = {};
      "nix-serve/public" = {};
    };

    # Copy generated copy of fastfetch to here
    home.file.".config/nix/nix.conf" = {
      source = pkgs.writeTextFile {
        name = "nix.conf";
        text = ''
          secret-key-files = ${config.sops.secrets."nix-serve/private".path}
        '';
      };
    };

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
        # Wallahi, forgive me RMS...
        allowUnfree = true;
        # Workaround for https://github.com/nix-community/home-manager/issues/2942
        allowUnfreePredicate = _: true;
        # Let the system use fucked up programs
        allowBroken = true;
      };
    };
  };
}
