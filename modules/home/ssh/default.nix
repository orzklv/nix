{
  config,
  pkgs,
  lib,
  ...
}: let
  extraConfig =
    ''
      IdentityFile ~/.ssh/id_rsa
    ''
    ++ (lib.optionalString pkgs.stdenv.isDarwin
      ''
        UseKeychain yes
      '');

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
      addKeysToAgent = true;

      # Server keep alive
      serverAliveInterval = 30;
      serverAliveCountMax = 3;

      matchBlocks =
        {
          local-1 = {
            port = 22;
            user = "sakhib";
            hostname = "192.168.0.2";
          };
        }
        // (kolymas {amount = 4;});
    };
  };
}
