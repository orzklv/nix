# =================================
# For further configuration extention, please refer to:
# https://wiki.nixos.org/wiki/GNOME
# =================================
{pkgs, ...}: {
  config = {
    # Sum additional variables for system-wide use.
    environment.variables = {
      # Disable compositing mode in WebKitGTK
      # https://github.com/NixOS/nixpkgs/issues/32580
      WEBKIT_DISABLE_COMPOSITING_MODE = 1;
    };

    # Enable the X11 windowing system.
    services = {
      xserver = {
        enable = true;

        # Configure keymap in X11
        xkb = {
          variant = "";
          layout = "us";
        };

        # Exclude some defautl packages
        excludePackages = [pkgs.xterm];

        # Enable the GDM display manager.
        displayManager.gdm = {
          enable = true;
          autoSuspend = false;
        };

        # Enable the GNOME Desktop Environment.
        desktopManager.gnome = {
          enable = true;

          extraGSettingsOverrides = ''
            # Change default background
            [org.gnome.desktop.background]
            picture-uri='file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}'

            # Background for dark theme
            [org.gnome.desktop.background]
            picture-uri-dark='file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}'

            # Prefer dark theme
            [org.gnome.desktop.interface]
            color-scheme='prefer-dark'

            # Favorite apps in gnome-shell
            [org.gnome.shell]
            favorite-apps=['org.gnome.Nautilus.desktop', 'org.gnome.Epiphany.desktop', 'org.gnome.SystemMonitor.desktop', 'Alacritty.desktop']

            [org.gnome.shell]
            disable-user-extensions=false

            [org.gnome.shell]
            enabled-extensions=['user-theme@gnome-shell-extensions.gcampax.github.com', 'dash-to-dock@micxgx.gmail.com', 'appindicatorsupport@rgcjonas.gmail.com']
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
      driSupport32Bit = true;
    };

    # Exclude some packages from the Gnome desktop environment.
    environment.gnome.excludePackages =
      (with pkgs; [
        xterm
        firefox
      ])
      ++ (with pkgs.gnome; [
        cheese # webcam app
        geary # email client
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
        gnome-contacts
        gnome-initial-setup
        gnome-terminal
      ]);

    # Setting daemons
    services = {
      # Udev daemon management
      udev.packages = with pkgs; [gnome.gnome-settings-daemon];
    };

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # Enable the DConf configuration system.
    programs.dconf.enable = true;

    # Enabling seahorse keyring
    programs.seahorse = {
      enable = true;
    };

    # Enable the Gnome Tweaks tool.
    environment.systemPackages = with pkgs; [
      # Gnome Modding
      gnome.dconf-editor
      gnome.gnome-tweaks

      # Gnome Extensions
      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-dock
      gnomeExtensions.gsconnect

      # Gnome Shell Packs
      papirus-icon-theme
    ];
  };
}
