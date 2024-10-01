{ pkgs
, inputs
, outputs
, lib
, config
, packages
, ...
}:
let
  # If unstable packages are needed, add to pkgs list
  # ++ (with pkgs.unstable; [ ])

  # Packages that aren't available on aarch64
  arm-incs =
    if (pkgs.stdenv.hostPlatform.isAarch64)
    then [ ]
    else
      (with pkgs;[
        discord
      ]);

  # General packages
  any-pkgs = (with pkgs;[
    telegram-desktop
    github-desktop
    spotify
  ]) ++ (with pkgs.unstable; [
    zed-editor
  ]);
in
{
  config = {
    users.users = {
      sakhib = {
        isNormalUser = true;
        description = "Sokhibjon Orzikulov";
        initialPassword = "F1st1ng15300Buck$!?";
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDAGqU+JleLM0T44P2quirtLPrhFExOi6EOe0GYXkTFcTSjhw9LqiuX1/FbqNdKTaP9k6CdV3xc/8Z5wxbNOhpcPi9XLoupv9oNyIew7QYl+ZoAck6/qPsM7uptGYCwo0/ErzPNLd3ERD3KT1axCqrI6rWJ+JFOMAPtGeAZZxIedksViZ5SuNhpzXCIzS2PACqDTxFj7JwXK/pQ200h9ZS0MSh7iLKggXQfRVDndJxRnVY69NmbRa4MqkjgyxqWSDbqrDAXuTHpqKJ5kpXJ6p2a82EIHcCwXXpEmLwKxatxWJWJb9nurm3aS74BYmT3pRVVSPC6n5a2LWN9GxzvVh3AXXZtWGvjXSqBxHdSyUoDPuZnDneycdRC5vs6I1jSGTyDFdc4Etq1M5uUYb6SqCjJIBvTNqVnOf8nzFwl/ENvc8sbIVtILgAbBdwDiiQSu8xppqWMZfkQJy+uI5Ok7TZ8o5rGIblzfKyTiljCQb7RO7Klg3TwysetREn8ZEykBx0= This world soon will cherish into my darkness of my madness"
        ];
        extraGroups = [ "networkmanager" "wheel" "docker" "vboxusers" "admins" ];
        packages = any-pkgs ++ arm-incs;
      };
    };

    home-manager = {
      extraSpecialArgs = { inherit inputs outputs; };
      users = {
        # Import your home-manager configuration
        sakhib = import ../../../home.nix;
      };
    };
  };
}
