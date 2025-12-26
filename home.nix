{
  inputs,
  outputs,
  lib,
  pkgs,
  ...
}: let
  modules = [
    outputs.homeModules.zsh
    outputs.homeModules.git
    outputs.homeModules.ssh
    outputs.homeModules.zed
    outputs.homeModules.helix
    outputs.homeModules.secret
    outputs.homeModules.nixpkgs
    outputs.homeModules.topgrade
    outputs.homeModules.packages
    outputs.homeModules.fastfetch

    # Third party modules
    inputs.zen-browser.homeModules.twilight
  ];
  inherit (pkgs) stdenv;

  home =
    if stdenv.hostPlatform.isDarwin
    then "Users"
    else "home";

  macos = lib.mkIf stdenv.hostPlatform.isDarwin {
    # Leave here configs that should be applied only at macos machines

    # This is to ensure programs are using ~/.config rather than
    # /Users/sakhib/Library/whatever
    xdg.enable = true;
  };

  linux = lib.mkIf stdenv.hostPlatform.isLinux {
    programs.zen-browser = {
      enable = true;

      nativeMessagingHosts = [
        pkgs.firefoxpwa
      ];

      policies = {
        AutofillAddressEnabled = true;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        # DontCheckDefaultBrowser = false;
        NoDefaultBookmarks = true;
        # OfferToSaveLogins = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
      };
    };
  };

  cfg = {
    # This is required information for home-manager to do its job
    home = {
      stateVersion = "25.11";
      username = "sakhib";
      homeDirectory = "/${home}/sakhib";
      enableNixpkgsReleaseCheck = false;
    };

    # Let's enable home-manager
    programs.home-manager.enable = true;
  };
in {
  imports = modules;

  config =
    lib.mkMerge
    [
      cfg
      macos
      linux
    ];
}
