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
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:

    # Nixpkgs for darwin
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";

    # Unstable Nixpkgs
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/home.nix'.

    # Nix-darwin for macOS systems management
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flake utils for eachSystem
    flake-utils.url = "github:numtide/flake-utils";

    # Disko for easier partition management
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Personal repo of packages
    orzklv-pkgs = {
      url = "github:orzklv/pkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  # In this context, outputs are mostly about getting home-manager what it
  # needs since it will be the one using the flake
  outputs = {
    self,
    nixpkgs,
    nixpkgs-darwin,
    nixpkgs-unstable,
    nix-darwin,
    home-manager,
    flake-utils,
    disko,
    orzklv-pkgs,
    ...
  } @ inputs: let
    # Self instance pointer
    outputs = self;
  in
    # Attributes for each system
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        # Nixpkgs packages for the current system
        {
          # Formatter for your nix files, available through 'nix fmt'
          # Other options beside 'alejandra' include 'nixpkgs-fmt'
          formatter = pkgs.alejandra;

          # Development shells
          devShells.default = import ./shell.nix {inherit pkgs;};
        }
    )
    # and ...
    //
    # Attribute from static evaluation
    {
      # Nixpkgs, Home-Manager and personal helpful functions
      lib = nixpkgs.lib // home-manager.lib // (import ./lib/extend.nix nixpkgs.lib).orzklv;

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays {inherit inputs;};

      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      nixosModules = import ./modules/nixos;

      # Reusable darwin modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      darwinModules = import ./modules/darwin;

      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      homeModules = import ./modules/home;

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      # Stored at/as root/nixos/<hostname lower case>/*.nix
      nixosConfigurations = self.lib.config.mapSystem {
        inherit inputs outputs;
        list = [
          "Station"
          "Parallels"
        ];
      };

      # Darwin configuration entrypoint
      # Available through 'darwin-rebuild build --flake .#your-hostname'
      # Stored at/as root/darwin/<alias name for machine>/*.nix
      darwinConfigurations = self.lib.config.attrSystem {
        inherit inputs outputs;
        type = "darwin";
        list = [
          {
            name = "Sokhibjons-MacBook-Air";
            alias = "macbook-air";
          }
          {
            name = "Sokhibjons-MacBook-Pro";
            alias = "macbook-pro";
          }
          {
            name = "Sokhibjons-Mac-Studio";
            alias = "mac-studio";
          }
        ];
      };
    };
}
