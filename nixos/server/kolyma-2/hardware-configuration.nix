{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [ 
    (modulesPath + "/profiles/qemu-guest.nix") 
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "xen_blkfront" "vmw_pvscsi" "xhci_pci" "ahci" "nvme" ];
  boot.initrd.kernelModules = [ "nvme" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.tmp.cleanOnBoot = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/34b56be9-51ae-4c8b-aa09-1b89bb892c51";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/c26d1ace-c209-45f7-abfa-a67af5c74bbb"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking = {
    interfaces = {
      enp41s0 = {
        useDHCP = true;

        ipv4.addresses = [ {
          address = "65.109.61.35";
          prefixLength = 24;
        } ];

        ipv6.addresses = [ {
          address = "2a01:4f9:5a:5110::";
          prefixLength = 64;
        } ];
      };
    };

    # If you want to configure the default gateway
    defaultGateway = {
      address = "65.109.61.1"; # Replace with your actual gateway for IPv4
      address6 = "fe80::1"; # Replace with your actual gateway for IPv6
    };

    # Optional DNS configuration
    # nameservers = [ "8.8.8.8" "8.8.4.4" ]; # Replace with your desired DNS servers
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}