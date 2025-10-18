{
  # =================================================================
  #    .oooooo.                       oooo        oooo
  #   d8P'  `Y8b                      `888        `888
  #  888      888 oooo d8b   oooooooo  888  oooo   888  oooo    ooo
  #  888      888 `888""8P  d'""7d8P   888 .8P'    888   `88.  .8'
  #  888      888  888        .d8P'    888888.     888    `88..8'
  #  `88b    d88'  888      .d8P'  .P  888 `88b.   888     `888'
  #   `Y8bood8P'  d888b    d8888888P  o888o o888o o888o     `8'
  # =================================================================
  description = "Sokhibjon's dotfiles managed via Nix configuration";
  # =================================================================

  # Extra nix configurations to inject to flake scheme
  # => use if something doesn't work out of box or when despaired...
  # nixConfig = {
  #   experimental-features = ["nix-command" "flakes" "pipe-operators"];
  # };

  # inputs are other flakes you use within your own flake, dependencies
  # for your flake, etc.
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:

    # Nixpkgs for darwin
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-25.05-darwin";

    # Unstable Nixpkgs
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/home.nix'.

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix-darwin for macOS systems management
    nix-darwin = {
      url = "github:xinux-org/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

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

    # An anime game(s) launcher (Genshin Impact)
    # aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    # Or, if you follow Nixkgs release 25.05:
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Goofy ahh browser from brainrot generation
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Good old Apple's Ligaturized SF Mono font
    sf-mono-liga = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
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
    ...
  } @ inputs: let
    # Self instance pointer
    inherit (self) outputs;

    # Personal library instance
    inherit (outputs) lib;

    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "x86_64-linux"
      "aarch64-darwin"
    ];

    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Nixpkgs, Home-Manager and personal helpful functions
    lib =
      nixpkgs.lib
      // home-manager.lib
      // import ./lib {inherit (nixpkgs) lib;};

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};

    # Development shells
    devShells = forAllSystems (system: {
      default = import ./shell.nix {
        pkgs = nixpkgs.legacyPackages.${system};
      };
    });

    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = lib.omodules.mod-parse ./modules/nixos;

    # Reusable darwin modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    darwinModules = lib.omodules.mod-parse ./modules/darwin;

    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeModules = lib.omodules.mod-parse ./modules/home;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    # Stored at/as root/nixos/<hostname lower case>/*.nix
    nixosConfigurations = lib.config.mapSystem {
      inherit inputs outputs;
      list =
        builtins.readDir ./nixos
        |> builtins.attrNames
        |> map (h: self.lib.ostrings.capitalize h);
    };

    # Darwin configuration entrypoint
    # Available through 'darwin-rebuild build --flake .#your-hostname'
    # Stored at/as root/darwin/<alias name for machine>/*.nix
    darwinConfigurations = lib.config.mapSystem {
      inherit inputs outputs;
      type = "darwin";
      list =
        builtins.readDir ./darwin
        |> builtins.attrNames;
    };
  };
}
