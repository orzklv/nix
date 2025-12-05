{
  pkgs,
  inputs,
  outputs,
  ...
}: let
  inherit (inputs.self) lib;

  # Packages that are not aarch64 compatible
  x86_64-only =
    lib.optionals
    pkgs.stdenv.hostPlatform.isx86_64
    (with pkgs; [
      # Zoom conference
      zoom-us
    ]);

  packages =
    (with pkgs; [
      # Matrix client
      fractal
      # Telegram desktop
      telegram-desktop
    ])
    ++ x86_64-only;

  hashedPassword = lib.strings.concatStrings [
    "$y$j9T$dsXOFHWCyplfRPiwsKu0l"
    "0$7YXPRLohyW8QXfyITPP6Sag/l7"
    "XH3i7TO4uGByPKBb2"
  ];
in {
  config = {
    users.users = {
      sakhib = {
        inherit packages hashedPassword;
        isNormalUser = true;
        description = "Sokhibjon Orzikulov";

        extraGroups = [
          "networkmanager"
          "wheel"
          "docker"
          "vboxusers"
          "media"
          "admins"
          "libvirtd"
        ];

        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDfHY4rNOm6DHH8XcmtU6CegX0/d99agN/x7MuPD5WJR sakhib@orzklv.uz"
        ];
      };
    };

    home-manager = {
      backupFileExtension = "hbak";
      extraSpecialArgs = {
        inherit inputs outputs;
      };
      users = {
        # Import your home-manager configuration
        sakhib = import ../../../home.nix;
      };
    };
  };
}
