{
  inputs,
  outputs,
  ...
}: let
  username = "sakhib";
in {
  config = {
    system.primaryUser = username;

    # Available users in the machine
    users.users = {
      ${username} = {
        home = "/Users/${username}";

        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDfHY4rNOm6DHH8XcmtU6CegX0/d99agN/x7MuPD5WJR sakhib@orzklv.uz"
        ];
      };
    };

    # Home manager configuration for users
    home-manager = {
      extraSpecialArgs = {
        inherit inputs outputs;
      };
      users = {
        # Import your home-manager configuration
        ${username} = import ../../../home.nix;
      };
    };
  };
}
