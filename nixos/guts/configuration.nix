# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    outputs.nixosModules.bootloader
    outputs.nixosModules.gnome

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix

    # Home Manager NixOS Module
    inputs.home-manager.nixosModules.home-manager
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

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
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  networking.hostName = "Guts"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Set your time zone.
  time.timeZone = "Asia/Tashkent";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # NVIDIA driver support
  services.xserver.videoDrivers = ["nvidia"];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Installing zsh for system
  programs.zsh.enable = true;

  # All users default shell must be zsh
  users.defaultUserShell = pkgs.zsh;

  # System configurations
  environment = {
    shells = with pkgs; [zsh];
    pathsToLink = ["/share/zsh"];
    systemPackages = with pkgs; [
      inputs.home-manager.packages.${pkgs.system}.default
    ];
  };

  users.users = {
    sakhib = {
      isNormalUser = true;
      description = "Sokhibjon Orzikulov";
      initialPassword = "F1st1ng15300Buck$!?";
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDAGqU+JleLM0T44P2quirtLPrhFExOi6EOe0GYXkTFcTSjhw9LqiuX1/FbqNdKTaP9k6CdV3xc/8Z5wxbNOhpcPi9XLoupv9oNyIew7QYl+ZoAck6/qPsM7uptGYCwo0/ErzPNLd3ERD3KT1axCqrI6rWJ+JFOMAPtGeAZZxIedksViZ5SuNhpzXCIzS2PACqDTxFj7JwXK/pQ200h9ZS0MSh7iLKggXQfRVDndJxRnVY69NmbRa4MqkjgyxqWSDbqrDAXuTHpqKJ5kpXJ6p2a82EIHcCwXXpEmLwKxatxWJWJb9nurm3aS74BYmT3pRVVSPC6n5a2LWN9GxzvVh3AXXZtWGvjXSqBxHdSyUoDPuZnDneycdRC5vs6I1jSGTyDFdc4Etq1M5uUYb6SqCjJIBvTNqVnOf8nzFwl/ENvc8sbIVtILgAbBdwDiiQSu8xppqWMZfkQJy+uI5Ok7TZ8o5rGIblzfKyTiljCQb7RO7Klg3TwysetREn8ZEykBx0= This world soon will cherish into my darkness of my madness"
      ];
      extraGroups = ["networkmanager" "wheel" "docker" "vboxusers"];
      packages =
        (with pkgs; [
          firefox
          telegram-desktop
          discord
          github-desktop
          spotify
        ])
        ++ (with pkgs.unstable; [
          vscode
          jetbrains-toolbox
        ]);
    };
  };

  # Don't ask for password
  security.sudo.wheelNeedsPassword = false;

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    users = {
      # Import your home-manager configuration
      sakhib = import ../../home/nixos.nix;
    };
  };

  # Enabling docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    enableNvidia = true;
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      # Forbid root login through SSH.
      PermitRootLogin = "no";
      # Use keys only. Remove if you want to SSH using password (not recommended)
      PasswordAuthentication = false;
    };
    ports = [2222];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
