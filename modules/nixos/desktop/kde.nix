# =================================
# For further configuration extention, please refer to:
# https://wiki.nixos.org/wiki/KDE
# =================================
{ pkgs, ... }:
let
  x86_64-opengl =
    if (!pkgs.stdenv.hostPlatform.isAarch64)
    then {
      driSupport32Bit = true;
    } else { };

  all-opengl = {
    enable = true;
    driSupport = true;
  };
in
{
  config = {
    # Enable the X11 windowing system.
    services = {
      # Enable the GDM display manager.
      displayManager.sddm = {
        enable = true;
        # wayland.enable = true;
      };

      # Enable the KDE Desktop Environment.
      desktopManager.plasma6 = {
        enable = true;
      };

      xserver = {
        enable = true;

        # Configure keymap in X11
        xkb = {
          variant = "";
          layout = "us";
        };

        # Exclude some defautl packages
        excludePackages = [ pkgs.xterm ];
      };
    };

    qt = {
      enable = true;
      platformTheme = "kde";
      style = "breeze";
    };

    # Make sure opengl is enabled
    hardware.opengl = all-opengl // x86_64-opengl;

    # Exclude some packages from the KDE desktop environment.
    environment.plasma6.excludePackages =
      with pkgs.kdePackages; [
        kate # that editor
        plasma-browser-integration # browser integration
      ];

    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # Enable the DConf configuration system.
    programs.dconf.enable = true;

    # Additional packs for customization.
    environment.systemPackages = with pkgs; [
      # Papirus Icon Pack
      papirus-icon-theme
    ];
  };
}
