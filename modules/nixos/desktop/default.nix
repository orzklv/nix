# =================================
# For further configuration extention, please refer to:
# https://wiki.nixos.org/wiki/GNOME
# =================================
{pkgs, ...}: let
  x86_64-graphics =
    if (!pkgs.stdenv.hostPlatform.isAarch64)
    then {enable32Bit = true;}
    else {};

  all-graphics = {
    enable = true;
  };
in {
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
            picture-uri='file://${pkgs.nixos-artwork.wallpapers.nineish.gnomeFilePath}'

            # Background for dark theme
            [org.gnome.desktop.background]
            picture-uri-dark='file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}'

            # Prefer light theme
            [org.gnome.desktop.interface]
            color-scheme='prefer-dark'

            # Favorite apps in gnome-shell
            [org.gnome.shell]
            favorite-apps=['org.gnome.Nautilus.desktop', 'org.gnome.Epiphany.desktop', 'org.gnome.SystemMonitor.desktop', 'org.gnome.Console.desktop', 'org.gnome.gitg.desktop', 'org.gnome.Builder.desktop', 'org.gnome.Polari.desktop', 'app.drey.PaperPlane.desktop']
            app-picker-layout=[{'org.gnome.Calendar.desktop': <{'position': <0>}>, 'org.gnome.Contacts.desktop': <{'position': <1>}>, 'org.gnome.Snapshot.desktop': <{'position': <2>}>, 'org.gnome.Weather.desktop': <{'position': <3>}>, 'org.gnome.clocks.desktop': <{'position': <4>}>, 'org.gnome.Maps.desktop': <{'position': <5>}>, 'org.gnome.Totem.desktop': <{'position': <6>}>, 'org.gnome.Calculator.desktop': <{'position': <7>}>, 'simple-scan.desktop': <{'position': <8>}>, 'org.gnome.Settings.desktop': <{'position': <9>}>, 'yelp.desktop': <{'position': <10>}>, 'org.gnome.Extensions.desktop': <{'position': <11>}>, 'nixos-manual.desktop': <{'position': <12>}>, 'org.gnome.Tour.desktop': <{'position': <13>}>, 'net.nokyan.Resources.desktop': <{'position': <14>}>, 'org.gnome.TextEditor.desktop': <{'position': <15>}>, 'org.gnome.World.Secrets.desktop': <{'position': <16>}>, 'io.gitlab.news_flash.NewsFlash.desktop': <{'position': <17>}>, 'f72ef462-c527-41e2-ab11-2b387528f4f2': <{'position': <18>}>, '50fbc66e-0ae1-4b79-8e78-fb8becd497b8': <{'position': <19>}>, 'cb5ebe4c-b1d8-4d4b-b00d-80385abdb5c9': <{'position': <20>}>, 'Utilities': <{'position': <21>}>}]

            # Enable user extensions
            [org.gnome.shell]
            disable-user-extensions=false

            # List of enabled extensions
            [org.gnome.shell]
            enabled-extensions=['user-theme@gnome-shell-extensions.gcampax.github.com', 'dash-to-dock@micxgx.gmail.com', 'appindicatorsupport@rgcjonas.gmail.com', 'light-style@gnome-shell-extensions.gcampax.github.com', 'system-monitor@gnome-shell-extensions.gcampax.github.com']

            # Workspace should grow dynamically
            [org.gnome.mutter]
            dynamic-workspaces=true

            # Edge Tiling with mouse
            [org.gnome.mutter]
            edge-tiling=true

            # Set the icon theme
            [org.gnome.desktop.interface]
            icon-theme='Papirus-Dark'

            # Use default color scheme
            [org.gnome.desktop.interface]
            color-scheme='default'

            # Automatic timezone
            [org.gnome.desktop.datetime]
            automatic-timezone=true

            # Never show the notice on tweak
            [org.gnome.tweaks]
            show-extensions-notice=false

            # Show all three button layers
            [org.gnome.desktop.wm.preferences]
            button-layout='appmenu:minimize,maximize,close'

            # Shitty monospace font to JetBrains Mono
            [org.gnome.desktop.interface]
            monospace-font-name='JetBrainsMono Nerd Font 10'

            # Dash to dock for multiple monitors
            [org.gnome.shell.extensions.dash-to-dock]
            multi-monitor=true

            # Custom theme on Dash to dock
            [org.gnome.shell.extensions.dash-to-dock]
            apply-custom-theme=true

            # Don't hibernate on delay
            [org.gnome.settings-daemon.plugins.power]
            sleep-inactive-ac-type='nothing'

            # Don't sleep, don't sleep!
            [org.gnome.desktop.session]
            idle-delay=0
          '';

          extraGSettingsOverridePackages = [
            pkgs.gsettings-desktop-schemas
            pkgs.gnome-shell
          ];
        };
      };
    };

    # Make sure opengl is enabled
    hardware.graphics = all-graphics // x86_64-graphics;

    # Exclude some packages from the Gnome desktop environment.
    environment.gnome.excludePackages =
      (with pkgs; [
        xterm
        firefox
      ])
      ++ (with pkgs; [
        cheese # webcam app
        geary # email client
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
      ]);

    # Setting daemons
    services = {
      # Udev daemon management
      udev.packages = with pkgs; [gnome-settings-daemon];
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
      # Additional Gnome apps
      gitg
      lorem
      emblem
      commit
      mousai
      polari
      amberol
      blanket
      curtail
      elastic
      errands
      dialect
      komikku
      decibels
      citations
      newsflash
      collision
      fragments
      newsflash
      apostrophe
      eyedropper
      impression
      textpieces
      letterpress
      forge-sparks
      gnome-graphs
      share-preview
      authenticator
      gnome-decoder
      gnome-secrets
      gnome-obfuscate
      gnome-resources

      # Developer
      gnome-boxes
      gnome-builder
      d-spy
      devhelp
      sysprof

      # Gnome Modding
      dconf-editor
      gnome-tweaks

      # Gnome Extensions
      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-dock
      gnomeExtensions.gsconnect

      # Gnome Shell Packs
      papirus-icon-theme
    ];
  };
}
