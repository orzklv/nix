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

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix-darwin for macOS systems management
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    # Flake utils for eachSystem
    flake-utils.url = "github:numtide/flake-utils";

    # Secrets management
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Disko for easier partition management
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Personal repository of lib, overlays and packages
    orzklv = {
      url = "github:orzklv/pkgs";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-unstable.follows = "nixpkgs-unstable";
      };
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
    home-manager,
    flake-utils,
    orzklv,
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
          # Development shells
          devShells.default = import ./shell.nix {inherit pkgs;};
        }
    )
    # and ...
    //
    # Attribute from static evaluation
    {
      # Formatter for your nix files, available through 'nix fmt'
      # Other options beside 'alejandra' include 'nixpkgs-fmt'
      inherit (orzklv) formatter;

      # Nixpkgs, Home-Manager and personal helpful functions
      lib = nixpkgs.lib // home-manager.lib // orzklv.lib;

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
      nixosConfigurations = orzklv.lib.config.mapSystem {
        inherit inputs outputs;
        opath = ./.;
        list = [
          "Parallels"
        ];
      };

      # Darwin configuration entrypoint
      # Available through 'darwin-rebuild build --flake .#your-hostname'
      # Stored at/as root/darwin/<alias name for machine>/*.nix
      darwinConfigurations = orzklv.lib.config.attrSystem {
        inherit inputs outputs;
        opath = ./.;
        type = "darwin";
        list = [
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
