{
  config,
  inputs,
  ...
}: let
  key = "${config.users.users.sakhib.home}/.config/sops/age/keys.txt";
in {
  imports = [inputs.sops-nix.darwinModules.sops];

  sops = {
    # Path to key file for unlocking secrets
    age.keyFile = key;
    # Default file that contains list of secrets
    defaultSopsFile = ../../../secrets/secrets.yaml;
    # The format of the secret file
    defaultSopsFormat = "yaml";
  };
}
