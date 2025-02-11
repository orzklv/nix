# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  inputs,
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    # Disko generated partitions
    inputs.disko.nixosModules.disko
    ./disk-configuration.nix

    # Not detected hardware modules
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];
  boot.initrd.kernelModules = ["nvme"];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];
  boot.binfmt.emulatedSystems = [
    "i686-linux"
    "aarch64-linux"
  ];

  # Emulation + Cross compilation
  nix.settings.extra-platforms = config.boot.binfmt.emulatedSystems;

  # Adjust GRUB loader screen
  boot.loader.grub.gfxmodeEfi = "1920x1080";

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno2.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  # List packages system hardware configuration
  hardware = {
    # CPU (AMD)
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    # GPU (Nvidia)
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  # Select host type for the system
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
