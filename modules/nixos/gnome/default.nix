{pkgs, ...}: {
  config = {
    # Enable the X11 windowing system.
    services = {
      xserver = {
        enable = true;

        # Configure keymap in X11
        layout = "us";
        xkbVariant = "";
        excludePackages = [pkgs.xterm];

        # Enable the Gnome desktop environment.
        displayManager.gdm.enable = true;
        desktopManager.gnome = {
          enable = true;
          extraGSettingsOverrides = ''
            # Change default background
            [org.gnome.desktop.background]
            picture-uri='file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}'

            # Change deafult theme to dark
            [org.gnome.desktop.interface]
            color-scheme = "prefer-dark";

            # Favorite apps in gnome-shell
            [org.gnome.shell]
            favorite-apps=['org.gnome.Console.desktop', 'org.gnome.Nautilus.desktop']
          '';

          extraGSettingsOverridePackages = [
            pkgs.gsettings-desktop-schemas
            pkgs.gnome.gnome-shell 
          ];
        };
      };
    };

    # Make sure opengl is enabled
    hardware.opengl = {
      enable = true;
      driSupport = true;
    };

    # Exclude some packages from the Gnome desktop environment.
    environment.gnome.excludePackages =
      (with pkgs; [
        xterm
      ])
      ++ (with pkgs.gnome; [
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
        epiphany # web browser
      ]);

    # Setting daemons
    services.udev.packages = with pkgs; [gnome.gnome-settings-daemon];

    # Enable the DConf configuration system.
    programs.dconf.enable = true;

    # Enable the Gnome Tweaks tool.
    environment.systemPackages = with pkgs; [
      gnome.dconf-editor
      gnome.gnome-tweaks
      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-dock
      gnomeExtensions.gsconnect
    ];
  };
}
