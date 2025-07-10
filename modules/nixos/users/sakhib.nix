{
  pkgs,
  inputs,
  outputs,
  ...
}: let
  inherit (inputs.self) lib;

  # Packages that are not aarch64 compatible
  x86_64-only =
    lib.condition.mkArrIf
    pkgs.stdenv.hostPlatform.isx86_64
    (with pkgs; [
      # Latest discord
      # pkgs.discord
      # To patch discord's krisp
      # pkgs.krisper
    ]);

  packages =
    (with pkgs; [
      # Matrix client
      fractal
      # Mastodon client
      tuba
      # GitHub Desktop
      github-desktop
    ])
    ++ x86_64-only;

  hashedPassword = lib.strings.concatStrings [
    "$y$j9T$dsXOFHW"
    "CyplfRPiwsKu0l"
    "0$7YXPRLohyW8Q"
    "XfyITPP6Sag/l7"
    "XH3i7TO4uGByPK"
    "Bb2"
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

        openssh.authorizedKeys.keys = lib.strings.splitString "\n" (
          builtins.readFile (
            builtins.fetchurl {
              url = "https://github.com/orzklv.keys";
              sha256 = "05rvkkk382jh84prwp4hafnr3bnawxpkb3w6pgqda2igia2a4865";
            }
          )
        );
      };
    };

    home-manager = {
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
