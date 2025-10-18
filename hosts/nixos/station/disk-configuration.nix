{
  disks ? [
    # 1TB NVME
    "/dev/nvme0n1"

    # 2 TB HDD
    "/dev/sda"

    # 500GB SATA
    "/dev/sdb"
  ],
  ...
}: {
  disko.devices = {
    disk = {
      main = {
        device = builtins.elemAt disks 0;
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            BOOT = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };
            SWAP = {
              size = "35G";
              content = {
                type = "swap";
                discardPolicy = "both";
                resumeDevice = true;
              };
            };
            ROOT = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };

      media = {
        device = builtins.elemAt disks 1;
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            MEDIA = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/media";
              };
            };
          };
        };
      };

      server = {
        device = builtins.elemAt disks 2;
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            SERVER = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/srv";
              };
            };
          };
        };
      };
    };
  };
}
