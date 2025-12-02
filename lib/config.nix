{lib}: let
  # Relative import functions
  rmatch = import ./rmatch.nix {inherit lib;};
  strings = import ./strings.nix {inherit lib;};

  listHosts = path: arch: let
    dir = path + "/${arch}";
  in
    builtins.readDir dir
    |> builtins.attrNames
    |> map (host: {
      inherit arch;
      name = strings.capitalize host;
      path = path + "/${arch}/${host}/configuration.nix";
    });

  mapSystem = {
    inputs,
    outputs,
    opath ? ../hosts,
  }: let
    hosts =
      builtins.readDir opath
      |> builtins.attrNames
      |> builtins.map (arch: (listHosts opath arch))
      |> lib.flatten;

    system = host: {
      inherit (host) name;
      value = makeSystem {
        inherit inputs outputs;
        inherit (host) path arch;
      };
    };

    map = lib.map system hosts;
  in
    lib.listToAttrs map;

  makeSystem = {
    arch,
    path,
    inputs,
    outputs,
  }: let
    out = rmatch.match {inherit arch;} [
      [
        {arch = "x86_64";}
        {
          specialArgs = {inherit inputs outputs;};
          fn = inputs.nixpkgs.lib.nixosSystem;
        }
      ]
      [
        {arch = "arm64";}
        {
          specialArgs = inputs;
          fn = inputs.nixos-raspberrypi.lib.nixosSystemFull;
        }
      ]
    ];

    attr = {
      modules = [path];
      inherit (out) specialArgs;
    };
  in
    out.fn attr;
in {
  inherit listHosts mapSystem makeSystem;
}
