{ pkgs, ... }:
let
  resolution = "3440x1440";
  theme-package = pkgs.callPackage ./theme.nix { };
in
{
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
          devices = [ "nodev" ];
          efiSupport = true;
          useOSProber = true;
          gfxmodeEfi = "${resolution},auto";
          gfxmodeBios = "${resolution},auto";
          theme = theme-package;
          splashImage = "${theme-package}/background.png";
        };
      };
      plymouth = {
        enable = true;
        theme = "breeze";
      };
    };
  };
}
