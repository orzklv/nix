{
  pkgs,
  lib,
  ...
}:
let
  makeHost = port: hostname: {
    inherit port hostname;
  };

  repetition =
    {
      amount,
      prefix ? "kolyma-",
      port ? 22,
      domain ? "kolyma.uz",
    }:
    builtins.listToAttrs (
      builtins.genList (
        i:
        let
          n = i + 1;
        in
        {
          name = "${prefix}${toString n}";
          value = makeHost port "ns${toString n}.${domain}";
        }
      ) amount
    );
in
{
  config = {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      matchBlocks = {
        # Anything (a.k.a defaults)
        "*" = {
          user = "sakhib";
          addKeysToAgent = "yes";
          serverAliveCountMax = 3;
          serverAliveInterval = 30;
          identityFile = "~/.ssh/id_ed25519";
          extraOptions = lib.mkIf pkgs.stdenv.isDarwin {
            UseKeychain = "yes";
          };
        };
      }
      # Global Kolymas
      // (repetition {
        amount = 4;
        prefix = "kolyma-";
        domain = "kolyma.uz";
      })
      // (repetition {
        amount = 1;
        prefix = "uchar-";
        domain = "uchar.uz";
      })
      // (repetition {
        amount = 3;
        prefix = "berk-";
        domain = "uzberk.uz";
      });
    };
  };
}
