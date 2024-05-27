{ modulesPath, ... }:
let
  external-mac = "00:11:22:33:44:55";
  ext-if = "et0";
  external-ip = "144.x.x.x";
  external-gw = "144.x.x.255";
  external-ip6 = "2a01:XXXX:XXXX::1";
  external-gw6 = "fe80::1";
  external-netmask = 27;
  external-netmask6 = 64;
in
{
  imports = [ 
    (modulesPath + "/profiles/qemu-guest.nix") 
  ];

  boot.tmp.cleanOnBoot = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "xen_blkfront" "vmw_pvscsi" ];
  boot.initrd.kernelModules = [ "nvme" ];
  
  fileSystems."/" = 
    { 
      device = "/dev/nvme0n1p3"; fsType = "ext4"; 
    };
  
  swapDevices = [ 
    { device = "/dev/nvme0n1p1"; } 
  ];

  # enp41s0
  networking.usePredictableInterfaceNames = false;
  systemd.network = {
    enable = true;
    networks."enp41s0".extraConfig = ''
      [Match]
      Name = enp41s0
      [Network]
      # Add your own assigned ipv6 subnet here here!
      Address = 2a01:4f8:161:714c::/64
      Gateway = fe80::1
      # optionally you can do the same for ipv4 and disable DHCP (networking.dhcpcd.enable = false;)
      # Address =  144.x.x.x/26
      # Gateway = 144.x.x.1
    '';
  };

}