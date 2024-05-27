{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" ];
  boot.initrd.kernelModules = [ "nvme" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.swraid.enable = true;
  boot.loader.grub = {
    enable = true;
    mirroredBoots = [
      {
        devices = [ "/dev/nvme0n1" "/dev/nvme1n1" ]; # List all drives in the RAID array
        path = "/boot"; # Path where GRUB should be installed
      }
    ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/484dd5fe-7269-4f51-b40a-12615fdc2dc8";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/5979-8294";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/e41e140f-53f3-4663-b6e4-db64dc02c2f2"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking = {
    useDHCP = false;

    interfaces = {
      eth0 = {
        useDHCP = true;

        ipv4.addresses = [ {
          address = "5.9.66.12";
          prefixLength = 24;
        } ];

        ipv6.addresses = [ {
          address = "2a01:4f8:161:714c::";
          prefixLength = 64;
        } ];
      };
    };

    # If you want to configure the default gateway
    defaultGateway = {
      address = "5.9.66.1"; # Replace with your actual gateway for IPv4
      interface = "eth0"; # Replace with your actual interface
    };

    defaultGateway6 = {
      address = "fe80::1"; # Replace with your actual gateway for IPv6
      interface = "eth0"; # Replace with your actual interface
    };

    # Optional DNS configuration
    nameservers = [ "8.8.8.8" "8.8.4.4" ]; # Replace with your desired DNS servers
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}