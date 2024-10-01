# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    outputs.nixosModules.ssh
    outputs.nixosModules.zsh
    outputs.nixosModules.fonts
    outputs.nixosModules.sound
    outputs.nixosModules.nixpkgs
    outputs.nixosModules.boot.grub
    outputs.nixosModules.users.sakhib
    outputs.nixosModules.desktop.gnome

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

  networking.hostName = "Experimental"; # Define your hostname.
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
  services.xserver.videoDrivers = [ "nvidia" ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Don't ask for password
  security.sudo.wheelNeedsPassword = false;

  # Enabling virtualization
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  # GPU for docker containers
  hardware.nvidia-container-toolkit.enable = true;

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

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05"; # Did you read the comment?
}
