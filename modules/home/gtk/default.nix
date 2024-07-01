{
  config,
  pkgs,
  lib,
  ...
}: {
  config = {
    # GNOME Gtk settings
    gtk = {
      enable = true;

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-nord;
      };

      theme = {
        name = "Nordic-darker";
        package = pkgs.nordic;
      };

      cursorTheme = {
        name = "Nordzy-cursors-white";
        package = pkgs.nordzy-cursor-theme;
      };

      gtk3.extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
      };

      gtk4.extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
      };
    };

    # Use `dconf watch /` to track stateful changes you are doing, then set them here.
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };

      "org/gnome/desktop/background" = {
        picture-uri = "file://${pkgs.nixos-artwork.wallpapers.dracula.gnomeFilePath}";
        picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.dracula.gnomeFilePath}";
      };

      # GNOME Extensions
      "org/gnome/shell" = {
        favorite-apps = [
          "org.gnome.Nautilus.desktop"
          "org.gnome.Epiphany.desktop"
          "org.gnome.SystemMonitor.desktop"
          "Alacritty.desktop"
        ];

        disable-user-extensions = false;

        # `gnome-extensions list` for a list
        enabled-extensions = [
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "dash-to-dock@micxgx.gmail.com"
          "appindicatorsupport@rgcjonas.gmail.com"
        ];
      };
    };

    home.sessionVariables.GTK_THEME = "Nordic";
  };
}
