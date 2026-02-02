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
  nixConfig = {
    experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];
    extra-substituters = [ "https://cache.xinux.uz/" ];
    extra-trusted-public-keys = [ "cache.xinux.uz:BXCrtqejFjWzWEB9YuGB7X2MV4ttBur1N8BkwQRdH+0=" ];
  };

  # inputs are other flakes you use within your own flake, dependencies
  # for your flake, etc.
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    # Nixpkgs Unstable for latest packages
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix-darwin for macOS systems management
    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Xinux library
    xinux-lib = {
      url = "github:xinux-org/lib/main";
      inputs.nixpkgs.follows = "nixpkgs";
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

    # Pre commit hooks for git
    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Goofy ahh browser from brainrot generation
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Good old Apple's Ligaturized SF Mono font
    sf-mono-liga = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };

    # Ready to go hardware related configurations
    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs =
    inputs:
    # Let the xinux-lib/mkFlake handle literally EVERYTHING
    inputs.xinux-lib.mkFlake {
      # Pass the vibe check
      inherit inputs;

      # Indicate root of the project
      # for library functions (nix issue)
      src = ./.;

      # Extra nix flags to set
      outputs-builder = channels: {
        formatter = channels.nixpkgs.nixfmt-tree;
      };

      # Globally applied nixpkgs settings
      channels-config = {
        # Disable if you don't want unfree packages
        allowUnfree = true;
        # Disable if you don't want linux thingies on mac
        allowUnsupportedSystem = true;
        # Workaround for https://github.com/nix-community/home-manager/issues/2942
        allowUnfreePredicate = _: true;
        # Let the system use fucked up programs
        allowBroken = true;
        # Allow NVIDIA's prop. software
        nvidia.acceptLicense = true;
      };

      # Default imported modules for all nixos targets
      systems.modules.nixos = with inputs; [
        self.nixosModules.ssh
        self.nixosModules.zsh
        self.nixosModules.vpn
        self.nixosModules.data
        self.nixosModules.boot
        self.nixosModules.sound
        self.nixosModules.users
        self.nixosModules.secret
        self.nixosModules.oxidize
        self.nixosModules.desktop
        self.nixosModules.nixpkgs
        disko.nixosModules.disko
      ];

      # Default imported modules for all darwin targets
      systems.modules.darwin = with inputs; [
        self.darwinModules.zsh
        self.darwinModules.brew
        self.darwinModules.users
        self.darwinModules.fonts
        self.darwinModules.secret
        self.darwinModules.nixpkgs
        self.darwinModules.security
      ];

      # Default imported modules for all home-managers
      homes.modules = with inputs; [
        self.homeModules.zsh
        self.homeModules.git
        self.homeModules.ssh
        self.homeModules.zed
        self.homeModules.zen
        self.homeModules.xdg
        self.homeModules.helix
        self.homeModules.secret
        self.homeModules.topgrade
        self.homeModules.packages
        self.homeModules.fastfetch
        zen-browser.homeModules.twilight
      ];

      # Extra project metadata
      xinux = {
        # Namespace for overlay, lib, packages
        namespace = "orzklv";

        # For data extraction
        meta = {
          name = "orzklv-nix";
          title = "Orzklv's Personal Flake Configuration";
        };
      };
    };
}
