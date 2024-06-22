{
  config,
  lib,
  pkgs,
  ...
}: {
  # Enabling docker
  config = {
    virtualisation = {
      docker = {
        enable = true;
        enableOnBoot = true;
        autoPrune.enable = true;
      };
      oci-containers = {
        backend = "docker";
      };
    };

    virtualisation.oci-containers.containers = {
      #  _       __     __         _ __
      # | |     / /__  / /_  _____(_) /____
      # | | /| / / _ \/ __ \/ ___/ / __/ _ \
      # | |/ |/ /  __/ /_/ (__  ) / /_/  __/
      # |__/|__/\___/_.___/____/_/\__/\___/
      website = {
        image = "ghcr.io/orzklv/kolyma:master";
        ports = ["8440:80"];
      };

      khakimovs = {
        image = "ghcr.io/khakimovs/website:main";
        ports = ["8441:3000"];
      };

      #     __  ___                                  ______
      #    /  |/  /___  __  ______  ______________ _/ __/ /_
      #   / /|_/ / __ \/ / / / __ \/ ___/ ___/ __ `/ /_/ __/
      #  / /  / / /_/ / /_/ / / / / /__/ /  / /_/ / __/ /_
      # /_/  /_/\____/\__, /_/ /_/\___/_/   \__,_/_/  \__/
      #              /____/
      # minecraft = {
      #   image = "itzg/minecraft-server:latest";
      #   volumes = [
      #     "/srv/minecraft:/data"
      #   ];
      #   ports = [
      #     "25565:25565"
      #     "25656:25656"
      #   ];
      #   environment = {
      #     TYPE = "PAPER";
      #     EULA = "TRUE";
      #     MEMORY = "12G";
      #   };
      # };

      #    _______ __     ____
      #   / ____(_) /_   / __ \__  ______  ____  ___  _____
      #  / / __/ / __/  / /_/ / / / / __ \/ __ \/ _ \/ ___/
      # / /_/ / / /_   / _, _/ /_/ / / / / / / /  __/ /
      # \____/_/\__/  /_/ |_|\__,_/_/ /_/_/ /_/\___/_/
      #   runner-1 = {
      #     image = "gitlab/gitlab-runner:latest";
      #     volumes = [
      #       "/srv/git/runner-1:/etc/gitlab-runner"
      #       "/var/run/docker.sock:/var/run/docker.sock"
      #     ];
      #   };

      #   runner-2 = {
      #     image = "gitlab/gitlab-runner:latest";
      #     volumes = [
      #       "/srv/git/runner-2:/etc/gitlab-runner"
      #       "/var/run/docker.sock:/var/run/docker.sock"
      #     ];
      #   };
      # };

    # Necessary firewall rules for docker containers
    networking.firewall.allowedUDPPorts = [
      # 25565 # Minecraft
    ];
    networking.firewall.allowedTCPPorts = [
      # 25565 # Minecraft
    ];
  };
}
