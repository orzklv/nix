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
      git = {
        image = "gitlab/gitlab-ee:latest";
        hostname = "git.kolyma.uz";
        volumes = [
          "/srv/git/config:/etc/gitlab"
          "/srv/git/logs:/var/log/gitlab"
          "/srv/git/data:/var/opt/gitlab"
        ];
        ports = [
          "8450:80"
          "22:22"
        ];
        environmentFiles = ["/srv/git/.env"];
        extraOptions = [
          "--shm-size=268435456"
        ];
      };

      remote-hbbr = {
        image = "rustdesk/rustdesk-server:latest";
        volumes = [
          "/srv/remote/data:/root"
        ];
        cmd = ["hbbr"];
        extraOptions = [
          "--network=host"
        ];
      };

      remote-hbbs = {
        image = "rustdesk/rustdesk-server:latest";
        volumes = [
          "/srv/remote/data:/root"
        ];
        cmd = ["hbbs"];
        dependsOn = [
          "remote-hbbr"
        ];
        extraOptions = [
          "--network=host"
        ];
      };
    };

    # Necessary firewall rules for docker containers
    networking.firewall.allowedUDPPorts = [
      22 # Git SSH
      21116 # RustDesk HBBS
    ];
    networking.firewall.allowedTCPPorts = [
      22 # Git SSH
      21115 # RustDesk HBBR
      21116 # RustDesk HBBS
      21117 # RustDesk HBBS
    ];
  };
}
