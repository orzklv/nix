{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid"];
  boot.initrd.kernelModules = ["nvme"];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];
  boot.swraid = {
    enable = true;
    mdadmConf = ''
      MAILADDR sakhib@orzklv.uz
    '';
  };
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
    mirroredBoots = [
      {
        devices = ["/dev/nvme0n1" "/dev/nvme1n1"]; # List all drives in the RAID array
        path = "/boot"; # Path where GRUB should be installed
      }
    ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/cfa68e38-a4dd-401f-9794-224a4e1dfd08";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/1B12-CEDF";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/1e7187bf-7374-41d6-bf0d-4c38a51e02bd";}
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

        ipv4.addresses = [
          {
            address = "95.216.248.25";
            prefixLength = 24;
          }
        ];

        ipv6.addresses = [
          {
            address = "2a01:4f9:3070:322c::";
            prefixLength = 64;
          }
        ];
      };
    };

    # If you want to configure the default gateway
    defaultGateway = {
      address = "95.216.248.1"; # Replace with your actual gateway for IPv4
      interface = "eth0"; # Replace with your actual interface
    };

    defaultGateway6 = {
      address = "fe80::1"; # Replace with your actual gateway for IPv6
      interface = "eth0"; # Replace with your actual interface
    };

    # Optional DNS configuration
    nameservers = ["8.8.8.8" "8.8.4.4"]; # Replace with your desired DNS servers
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
