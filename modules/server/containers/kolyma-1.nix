{
  config,
  lib,
  pkgs,
  ...
}: {
  config.virtualisation.oci-containers.containers = {
    minecraft = {
      image = "itzg/minecraft-server:latest";
      volumes = [
        "/srv/minecraft/server:/data"
      ];
      ports = [
        "25565:25565"
        "25656:25656"
      ];
      environment = {
        TYPE = "PAPER";
        EULA = "TRUE";
        MEMORY = "12G";
      };
      backend = "docker";
    };

    runner-1 = {
      image = "gitlab/gitlab-runner:latest";
      volumes = [
        "/srv/git/runner-1/config:/etc/gitlab-runner"
        "/var/run/docker.sock:/var/run/docker.sock"
      ];
      backend = "docker";
    };

    runner-2 = {
      image = "gitlab/gitlab-runner:latest";
      volumes = [
        "/srv/git/runner-2/config:/etc/gitlab-runner"
        "/var/run/docker.sock:/var/run/docker.sock"
      ];
      backend = "docker";
    };
  };
}
