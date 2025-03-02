{
  pkgs,
  inputs,
  outputs,
  config,
  packages,
  ...
}: let
  inherit (inputs.self) lib;

  # Packages that are not aarch64 compatible
  x86_64-only =
    lib.condition.mkArrIf
    pkgs.stdenv.hostPlatform.isx86_64
    (with pkgs; [
      # Latest discord
      pkgs.discord
      # To patch discord's krisp
      pkgs.krisper
    ]);

  packages =
    (with pkgs; [
      telegram-desktop
      github-desktop
    ])
    ++ x86_64-only;

  password =
    builtins.replaceStrings
    ["\n"] [""] (builtins.readFile ./password);
in {
  config = {
    users.users = {
      sakhib = {
        inherit packages;
        isNormalUser = true;
        description = "Sokhibjon Orzikulov";
        hashedPassword = password;
        openssh.authorizedKeys.keys = [(builtins.readFile ./id_rsa.pub)];
        extraGroups = [
          "networkmanager"
          "wheel"
          "docker"
          "vboxusers"
          "admins"
          "libvirtd"
        ];
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
