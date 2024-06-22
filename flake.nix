{
  #     _   ___         ______            ____
  #    / | / (_)  __   / ____/___  ____  / __/____
  #   /  |/ / / |/_/  / /   / __ \/ __ \/ /_/ ___/
  #  / /|  / />  <   / /___/ /_/ / / / / __(__  )
  # /_/ |_/_/_/|_|   \____/\____/_/ /_/_/ /____/
  description = "Sokhibjon's dotfiles";

  # inputs are other flakes you use within your own flake, dependencies
  # for your flake, etc.
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/home.nix'.

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flake utils for eachSystem
    flake-utils.url = "github:numtide/flake-utils";

    # Disko for easier partition management
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";

    # Astro Neovim
    # Non-flake repository
    astronvim = {
      url = "github:AstroNvim/AstroNvim/v3.40.3";
      flake = false;
    };

    # Other's Configs
    # Muzaffar (Minecraft Server Moderator)
    muzaffar-cfg = {
      url = "github:Muzaffar-x/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # In this context, outputs are mostly about getting home-manager what it
  # needs since it will be the one using the flake
  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    flake-utils,
    ...
  } @ inputs: let
    inherit (self) outputs;

    # Legacy packages are needed for home-manager
    lib = nixpkgs.lib // home-manager.lib;

    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;

    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});

    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    pkgsFor = lib.genAttrs systems (system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });

    # Define a development shell for each system
    devShellFor = system: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
      pkgs.mkShell {
        NIX_CONFIG = "extra-experimental-features = nix-command flakes repl-flake";
        buildInputs = with pkgs; [
          nix
          nil
          git
          just
        ];

        # Set environment variables, if needed
        shellHook = ''
          # export SOME_VAR=some_value
          echo "Welcome to Sokhibjon's dotfiles!"
        '';
      };
  in {
    inherit lib;

    # Your custom packages
    # Acessible through 'nix build', 'nix shell', etc
    packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});

    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter =
      forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};

    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;

    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home;

    # Reusable server modules you might want to export
    # These are usually stuff you would upstream services to global
    serverModules = import ./modules/server;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      #     ____            __
      #    / __ \___  _  __/ /_____  ____  _____
      #   / / / / _ \| |/_/ __/ __ \/ __ \/ ___/
      #  / /_/ /  __/>  </ /_/ /_/ / /_/ (__  )
      # /_____/\___/_/|_|\__/\____/ .___/____/
      #                          /_/
      "Station" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          # > Our main nixos configuration file <
          ./nixos/desktop/station/configuration.nix
        ];
      };
      "Experimental" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          # > Our main nixos configuration file <
          ./nixos/desktop/experiment/configuration.nix
        ];
      };

      #    _____
      #   / ___/___  ______   _____  __________
      #   \__ \/ _ \/ ___/ | / / _ \/ ___/ ___/
      #  ___/ /  __/ /   | |/ /  __/ /  (__  )
      # /____/\___/_/    |___/\___/_/  /____/
      "Kolyma-1" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          # > Our main nixos configuration file <
          ./nixos/server/kolyma-1/configuration.nix
        ];
      };
      "Kolyma-2" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          # > Our main nixos configuration file <
          ./nixos/server/kolyma-2/configuration.nix
        ];
      };
      "Kolyma-3" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          # > Our main nixos configuration file <
          ./nixos/server/kolyma-3/configuration.nix
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      #     ___                __
      #    /   |  ____  ____  / /__
      #   / /| | / __ \/ __ \/ / _ \
      #  / ___ |/ /_/ / /_/ / /  __/
      # /_/  |_/ .___/ .___/_/\___/
      #       /_/   /_/
      # For all my current OSX machines
      "sakhib@apple" = home-manager.lib.homeManagerConfiguration {
        pkgs =
          nixpkgs-unstable.legacyPackages.aarch64-darwin; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          # > Our main home-manager configuration file <
          ./home/macos.nix
        ];
      };

      # For my good old MacBook Air 2015
      "sakhib@old-apple" = home-manager.lib.homeManagerConfiguration {
        pkgs =
          nixpkgs-unstable.legacyPackages.x86_64-darwin; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          # > Our main home-manager configuration file <
          ./home/macos.nix
        ];
      };

      # Shortcuts for all my OSX machines
      "sakhib@Sokhibjons-iMac.local" = self.homeConfigurations."sakhib@apple"; # Personal iMac
      "sakhib@Sokhibjons-MacBook-Pro.local" = self.homeConfigurations."sakhib@apple"; # Personal MacBook Pro
      "sakhib@Sokhibjons-Virtual-Machine.local" = self.homeConfigurations."sakhib@apple"; # Parallels VIrtual Machine
      "sakhib@Sokhibjons-MacBook-Air.local" = self.homeConfigurations."sakhib@old-apple"; # Old MacBook Air 2015

      #      ___   __            _  _   ___
      #    _/_/ | / /___  ____  | |/ | / (_)  ______  _____
      #   / //  |/ / __ \/ __ \ / /  |/ / / |/_/ __ \/ ___/
      #  / // /|  / /_/ / / / // / /|  / />  </ /_/ (__  )
      # / //_/ |_/\____/_/ /_//_/_/ |_/_/_/|_|\____/____/
      # |_|                 /_/
      # For my unstable non NixOS machines
      "sakhib@unstable" = home-manager.lib.homeManagerConfiguration {
        pkgs =
          nixpkgs-unstable.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          # > Our main home-manager configuration file <
          ./home/linux.nix
        ];
      };

      # For my stable non NixOS machines
      "sakhib@stable" = home-manager.lib.homeManagerConfiguration {
        pkgs =
          nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          # > Our main home-manager configuration file <
          ./home/linux.nix
        ];
      };

      # For topgrade from NixOS instances
      "sakhib" = self.homeConfigurations."sakhib@stable";
    };

    # Development shells
    devShell = lib.mapAttrs (system: _: devShellFor system) (lib.genAttrs systems {});
    # devShells = lib.mapAttrs (system: _: devShellFor system) (lib.genAttrs systems {});
  };
}
