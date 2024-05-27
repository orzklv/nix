{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    git = {
      isMacOS = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Install MacOS specific agent.";
      };
    };
  };

  config = {
    # Git Configurations
    programs.git = {
      enable = true;
      lfs.enable = true;

      # User credentials
      userName = "Sokhibjon Orzikulov";
      userEmail = "sakhib@orzklv.uz";

      extraConfig = {
        http.sslVerify = false;
      };

      # GPG Signing
      signing = {
        signByDefault = true;
        key = "00D27BC687070683FBB9137C3C35D3AF0DA1D6A8";
      };

      # Aliases
      aliases = {
        ch = "checkout";
      };

      # Git ignores
      ignores = [
        ".idea"
        ".DS_Store"
      ];
    };

    home.file.".gnupg/gpg-agent.conf".text =
      if config.git.isMacOS
      then ''
        pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
      ''
      else ''
        pinentry-program ${pkgs.kwalletcli}/bin/pinentry-kwallet
      '';

    home.file.".gnupg/gpg.conf".text =
      if config.git.isMacOS
      then ''
        no-tty
        use-agent
      ''
      else ''
      '';
  };
}
