{pkgs, ...}: {
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    # Configure keymap in X11
    layout = "us";
    xkbVariant = "";

    # Enable the KDE Plasma Desktop Environment.
    displayManager = {
      sddm.enable = true;
      # autoLogin = {
      #   enable = true;
      #   user = "sakhib";
      # };
    };

    desktopManager = {
      plasma5.enable = true;
    };
  };

  # Make sure opengl is enabled
  hardware.opengl = {
    enable = true;
    driSupport = true;
  };
}
