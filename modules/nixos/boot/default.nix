{pkgs, ...}: {
  config = {
    # Bootloader.
    boot = {
      consoleLogLevel = 0;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "splash"
        # "rd.systemd.show_status=false"
        # "rd.udev.log_level=3"
        # "udev.log_priority=3"
      ];
      loader = {
        efi.canTouchEfiVariables = true;
        grub = {
          enable = true;
          devices = ["nodev"];
          efiSupport = true;
          useOSProber = true;
          theme = pkgs.callPackage ./theme.nix {};
        };
      };
      plymouth = {
        enable = true;
        theme = "breeze";
      };
    };
  };
}
