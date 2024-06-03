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
      #    _______ __  __          __
      #   / ____(_) /_/ /   ____ _/ /_
      #  / / __/ / __/ /   / __ `/ __ \
      # / /_/ / / /_/ /___/ /_/ / /_/ /
      # \____/_/\__/_____/\__,_/_.___/
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
        extraOptions = [
          "--shm-size=268435456"
        ];
      };

      #     ____             __  ____            __
      #    / __ \__  _______/ /_/ __ \___  _____/ /__
      #   / /_/ / / / / ___/ __/ / / / _ \/ ___/ //_/
      #  / _, _/ /_/ (__  ) /_/ /_/ /  __(__  ) ,<
      # /_/ |_|\__,_/____/\__/_____/\___/____/_/|_|
      remote-hbbr = {
        image = "rustdesk/rustdesk-server:latest";
        volumes = [
          "/srv/remote:/root"
        ];
        cmd = ["hbbr"];
        extraOptions = [
          "--network=host"
        ];
      };

      remote-hbbs = {
        image = "rustdesk/rustdesk-server:latest";
        volumes = [
          "/srv/remote:/root"
        ];
        cmd = ["hbbs"];
        dependsOn = [
          "remote-hbbr"
        ];
        extraOptions = [
          "--network=host"
        ];
      };

      #    _____ __        __                    __
      #   / ___// /_____ _/ /      ______ ______/ /_
      #   \__ \/ __/ __ `/ / | /| / / __ `/ ___/ __/
      #  ___/ / /_/ /_/ / /| |/ |/ / /_/ / /  / /_
      # /____/\__/\__,_/_/ |__/|__/\__,_/_/   \__/
      mail = {
        image = "stalwartlabs/mail-server:latest";
        volumes = [
          "/srv/mail:/opt/stalwart-mail"
        ];
        ports = [
          ""
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
