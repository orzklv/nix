{
  lib,
  inputs,
  outputs,
  ...
}: {
  config = {
    # Available users in the machine
    users.users = {
      sakhib = {
        home = "/Users/sakhib";
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

    # Home manager configuration for users
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
