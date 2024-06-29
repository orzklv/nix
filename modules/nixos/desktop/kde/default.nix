# =================================
# For further configuration extention, please refer to:
# https://wiki.nixos.org/wiki/KDE
# =================================
{pkgs, ...}: {
  config = {
    # Exclude default packages
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration
      kate
      khelpcenter
      print-manager
    ];

    services = {
      # Enable the X11 windowing system.
      # You can disable this if you're only using the Wayland session.
      xserver = {
        enable = true;

        # Configure keymap in X11
        xkb = {
          variant = "";
          layout = "us";
        };
      };

      # Enable the KDE Plasma Desktop Environment.
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
      desktopManager.plasma6.enable = true;
    };
  };
}
