{
  pkgs,
  lib,
  ...
}: let
  extensions = [
    "assembly"
    "caddyfile"
    "catppuccin-blur"
    "deno"
    "docker-compose"
    "dockerfile"
    "env"
    "glsl"
    "haskell"
    "html"
    "ini"
    "java"
    "just"
    "latex"
    "lua"
    "make"
    "neocmake"
    "nginx"
    "nix"
    "nu"
    "php"
    "pkl"
    "ruby"
    "slint"
    "sql"
    "swift"
    "the-dark-side"
    "toml"
    "typst"
    "vercel-theme"
    "vue"
    "wgsl"
    "xml"
    "zig"
  ];

  settings = {
    auto_update = false;

    features = {
      copilot = false;
    };

    telemetry = {
      metrics = false;
    };

    show_inline_completions = false;

    node = {
      path = lib.getExe pkgs.nodejs;
      npm_path = lib.getExe' pkgs.nodejs "npm";
    };

    assistant = {
      version = "2";
      default_model = {
        provider = "copilot_chat";
        model = "gpt-4o";
      };
    };

    languages = {
      Markdown = {
        format_on_save = "on";
        use_on_type_format = true;
        remove_trailing_whitespace_on_save = true;
      };

      Ruby = {
        language_servers = [
          "solargraph"
          "!ruby-lsp"
          "!rubocop"
          "..."
        ];
      };

      Nix = {
        formatter = "language_server";
        language_servers = [
          "nixd"
          "!nil"
        ];
      };

      TypeScript = {
        language_servers = [
          "deno"
          "!typescript-language-server"
          "!vtsls"
          "!eslint"
        ];
        formatter = "language_server";
      };

      TSX = {
        language_servers = [
          "deno"
          "!typescript-language-server"
          "!vtsls"
          "!eslint"
        ];
        formatter = "language_server";
      };
    };

    inline_completions = {
      disabled_globs = [
        ".env"
        ".zone"
      ];
    };

    lsp = {
      nixd = {
        binary = {
          path_lookup = true;
        };
        settings = {
          formatting = {
            command = [
              "alejandra"
            ];
          };
          diagnostic = {
            suppress = [
              "sema-extra-with"
              "sema-extra-rec"
            ];
          };
        };
      };

      rust-analyzer = {
        binary = {
          path_lookup = true;
        };
        initialization_options = {
          check = {
            command = "clippy";
          };
        };
      };

      deno = {
        binary = {
          path_lookup = true;
        };
      };

      solargraph = {
        binary = {
          path_lookup = true;
        };
        initialization_options = {
          diagnostics = true;
          formatting = true;
        };
      };

      discord_presence = {
        initialization_options = {
          # Application ID for the rich presence (don't touch it unless you know what you're doing)
          application_id = "1263505205522337886";
          # Base URL for all language icons
          base_icons_url = "https://raw.githubusercontent.com/xhyrom/zed-discord-presence/main/assets/icons/";
          state = "Working on {filename}";
          details = "In {workspace}";
          # URL for the large image
          large_image = "{base_icons_url}/{language}.png";
          large_text = "{language:u}"; # :u capitalizes the first letter
          # URL for the small image
          small_image = "{base_icons_url}/zed.png";
          small_text = "Zed";
          # Idle settings - when you're inactive
          idle = {
            timeout = 300; # Idle timeout in seconds (300 seconds = 5 minutes)
            # Action to take when idle
            # `change_activity` - changes the activity to idle with the following details
            # `clear_activity` - clears the activity (hides it)
            action = "change_activity";
            state = "Idling";
            details = "In Zed";
            large_image = "{base_icons_url}/zed.png";
            large_text = "Zed";
            small_image = "{base_icons_url}/idle.png";
            small_text = "Idle";
          };
          # Rules to disable presence in specific workspaces
          rules = {
            mode = "blacklist"; # Can also be "whitelist"
            paths = [
              "absolute path"
            ];
          };
          git_integration = true;
        };
      };
    };

    load_direnv = "shell_hook";

    terminal = {
      detect_venv = {
        on = {
          directories = [".env" "env"];
          activate_script = "default";
        };
      };
    };

    theme = "Vercel Dark";
    tab_size = 2;
    autosave = "off";
    format_on_save = "language_server";
    preferred_line_length = 100;
    soft_wrap = "editor_width";
    buffer_font_size = 16;
    ui_font_size = 16;
    enable_language_server = true;
    confirm_quit = false;
    use_autoclose = false;
  };
in {
  config = {
    programs.zed-editor = {
      enable = true;
      inherit extensions;
      userSettings = settings;
      package = pkgs.unstable.zed-editor;
    };
  };
}
