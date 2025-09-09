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
          value = {
            inherit user port;
            hostname = "ns${toString n}.${domain}";
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
          efael-1 = {
            port = 48596;
            user = "sakhib";
            hostname = "93.188.85.94";
          };

          efael-2 = {
            port = 22;
            user = "sakhib";
            hostname = "ns2.efael.uz";
          };

          efael-3 = {
            port = 22;
            user = "sakhib";
            hostname = "ns3.efael.uz";
          };

          laboratory-1 = {
            port = 22;
            user = "sakhib";
            hostname = "10.10.0.2";
          };

          # Local Hub Kolyma
          local-1 = {
            port = 6666;
            user = "sakhib";
            hostname = "uz1.kolyma.uz";
          };
        }
        # Global Kolymas
        // (repetition {amount = 2;});
    };
  };
}
