{ pkgs, ... }: {
  config = {
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the Gnome desktop environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    # Configure keymap in X11
    services.xserver = {
      layout = "us";
      xkbVariant = "";
    };

    # Make sure opengl is enabled
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    # Exclude some packages from the Gnome desktop environment.
    environment.gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
    ]) ++ (with pkgs.gnome; [
      cheese # webcam tool
      gnome-music
      gedit # text editor
      epiphany # web browser
      geary # email reader
      gnome-characters
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
      yelp # Help view
      gnome-contacts
      gnome-initial-setup
    ]);

    # Setting daemons
    services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

    # Enable the DConf configuration system.
    programs.dconf.enable = true;

    # Enable the Gnome Tweaks tool.
    environment.systemPackages = with pkgs; [
      gnome.gnome-tweaks
      gnomeExtensions.appindicator
    ];
  };
}