{
  config,
  pkgs,
  lib,
  ...
}: let
  extraConfig = ''
    IdentityFile ~/.ssh/id_rsa
    ${(lib.optionalString pkgs.stdenv.isDarwin
      ''
        UseKeychain yes
      '')}
  '';

  kolymas = {
    amount,
    prefix ? "kolyma-",
    user ? "sakhib",
    port ? 22,
  }:
    builtins.listToAttrs (
      builtins.genList (
        i: let
          n = i + 1;
        in {
          name = "${prefix}${toString n}";
          value = {
            inherit user port;
            hostname = "ns${toString n}.kolyma.uz";
          };
        }
      )
      amount
    );
in {
  config = {
    programs.ssh = {
      enable = true;
      inherit extraConfig;
      addKeysToAgent = "yes";

      # Server keep alive
      serverAliveInterval = 30;
      serverAliveCountMax = 3;

      matchBlocks =
        {
          # Uzinfocom
          uzinfocom-efael = {
            port = 48596;
            user = "sakhib";
            hostname = "93.188.85.94";
          };

          # Local Hub Kolyma
          local-1 = {
            port = 6666;
            user = "sakhib";
            hostname = "uz1.kolyma.uz";
          };
        }
        # Global Kolymas
        // (kolymas {amount = 3;});
    };
  };
}
