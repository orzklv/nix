{
  pkgs,
  lib,
  ...
}: let
  makeHost = port: hostname: {
    user = "sakhib";
    inherit port hostname;
    addKeysToAgent = "yes";
    serverAliveCountMax = 3;
    serverAliveInterval = 30;
    identityFile = "~/.ssh/id_ed25519";
    extraOptions = lib.mkIf pkgs.stdenv.isDarwin {
      UseKeychain = "yes";
    };
  };

  repetition = {
    amount,
    prefix ? "kolyma-",
    user ? "sakhib",
    port ? 22,
    domain ? "kolyma.uz",
  }:
    builtins.listToAttrs (
      builtins.genList (
        i: let
          n = i + 1;
        in {
          name = "${prefix}${toString n}";
          value = makeHost 22 "ns${toString n}.${domain}";
        }
      )
      amount
    );
in {
  config = {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      matchBlocks =
        {
          # Did they turn it off?
          efael-1 = makeHost 48596 "93.188.85.94";

          # Did they turn it off?
          efael-2 = makeHost 22 "ns2.efael.uz";

          # Did they turn it off?
          efael-3 = makeHost 22 "ns3.efael.uz";
        }
        # Global Kolymas
        // (repetition {amount = 4;});
    };
  };
}
