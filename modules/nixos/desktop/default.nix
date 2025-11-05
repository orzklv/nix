# =================================
# For further configuration extention, please refer to:
# https://wiki.nixos.org/wiki/GNOME
# =================================
{
  inputs,
  pkgs,
  ...
}: {
  config = {
    # Enable the X11 windowing system.
    services = {
      xserver = {
        # Configure keymap in X11
        xkb = {
          variant = "";
          layout = "us";
        };

        # Exclude some defautl packages
        excludePackages = [pkgs.xterm];
      };

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

          # Prefer dark theme
          [org.gnome.desktop.interface]
          color-scheme='prefer-dark'

          # Favorite apps in gnome-shell
          [org.gnome.shell]
          favorite-apps=['org.gnome.Nautilus.desktop', 'zen-twilight.desktop', 'org.gnome.SystemMonitor.desktop', 'org.gnome.Console.desktop', 'org.gnome.gitg.desktop', 'org.gnome.Builder.desktop', 'org.gnome.Polari.desktop']

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

    # Add all necessary fonts
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      nerd-fonts.jetbrains-mono
      sf-mono-liga
    ];

    # Make sure opengl is enabled
    hardware.graphics = {
      enable = true;
      enable32Bit = !pkgs.stdenv.hostPlatform.isAarch64;
    };

    # Setting daemons
    services = {
      # Udev daemon management
      udev.packages = with pkgs; [gnome-settings-daemon];
    };

    programs = {
      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
      # Enable the DConf configuration system.
      dconf.enable = true;

      # Enabling seahorse keyring
      seahorse = {
        enable = true;
      };
    };

    environment = {
      # Sum additional variables for system-wide use.
      variables = {
        # Disable compositing mode in WebKitGTK
        # https://github.com/NixOS/nixpkgs/issues/32580
        WEBKIT_DISABLE_COMPOSITING_MODE = 1;
        ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      };

      # Exclude some packages from the Gnome desktop environment.
      gnome.excludePackages =
        (with pkgs; [
          xterm
          firefox
          epiphany
        ])
        ++ (with pkgs; [
          tali # poker game
          iagno # go game
          hitori # sudoku game
          atomix # puzzle game
        ]);

      # Enable the Gnome Tweaks tool.
      systemPackages = with pkgs; [
        # Additional Gnome apps
        gitg
        lorem
        emblem
        commit
        mousai
        polari
        ghostty
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
        resources

        # Developer
        gnome-boxes
        gnome-builder
        d-spy
        devhelp
        sysprof
        # blackbox-terminal # very laggy & buggy

        # Gnome Modding
        dconf-editor
        gnome-tweaks

        # Gnome Extensions
        gnomeExtensions.appindicator
        gnomeExtensions.dash-to-dock
        gnomeExtensions.gsconnect

        # Gnome Shell Packs
        papirus-icon-theme

        # Normal fucking browser
        inputs.zen-browser.packages."${pkgs.system}".twilight

        # Some office stuff
        libreoffice-fresh
      ];
    };
  };
}
