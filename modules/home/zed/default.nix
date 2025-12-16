{
  lib,
  pkgs,
  config,
  ...
}: let
  extensions = [
    "assembly"
    "deno"
    "env"
    "glsl"
    "haskell"
    "html"
    "ini"
    "just"
    "latex"
    "lua"
    "make"
    "material-icon-theme"
    "neocmake"
    "nginx"
    "nix"
    "nu"
    "pkl"
    "ruby"
    "slint"
    "sql"
    "swift"
    "toml"
    "typst"
    "vercel-theme"
    "wgsl"
    "xml"
    "zig"
  ];

  settings = {
    auto_update = false;

    disable_ai = true;

    telemetry = {
      metrics = false;
      diagnostics = false;
    };

    show_edit_predictions = false;

    node = {
      path = lib.getExe pkgs.nodejs;
      npm_path = lib.getExe' pkgs.nodejs "npm";
    };

    languages = {
      Markdown = {
        format_on_save = "on";
        use_on_type_format = true;
        remove_trailing_whitespace_on_save = true;
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
          "typescript-language-server"
          "deno"
          "!vtsls"
          "!eslint"
        ];
        formatter = "language_server";
      };

      TSX = {
        language_servers = [
          "typescript-language-server"
          "deno"
          "!eslint"
          "!vtsls"
        ];
        formatter = "language_server";
      };
    };

    lsp = {
      nixd = {
        binary = {
          ignore_system_version = false;
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
          ignore_system_version = false;
        };
        initialization_options = {
          check = {
            command = "clippy";
          };
        };
      };

      deno = {
        binary = {
          ignore_system_version = false;
        };
      };

      solargraph = {
        binary = {
          ignore_system_version = false;
        };
        initialization_options = {
          diagnostics = true;
          formatting = true;
        };
      };
    };

    load_direnv = "shell_hook";

    theme = {
      mode = "system";
      light = "Vercel Light";
      dark = "Vercel Dark";
    };
    icon_theme = "Material Icon Theme";

    tab_size = 2;
    preferred_line_length = 100;

    autosave = "off";
    format_on_save = "language_server";
    enable_language_server = true;

    soft_wrap = "editor_width";

    buffer_font_size = 16;
    buffer_font_family = "Liga SFMono Nerd Font";

    ui_font_size = 16;
    ui_font_family = ".SystemUIFont";

    confirm_quit = false;
    use_autoclose = false;

    inlay_hints = {
      enabled = true;
      # show_background = true;
    };

    title_bar = {
      show_branch_icon = true;
    };

    collaboration_panel = {
      button = false;
    };

    chat_panel = {
      button = "never";
    };

    agent = {
      enabled = false;
    };
  };
in {
  config = {
    programs.zed-editor = {
      enable = true;
      inherit extensions;
      userSettings = settings;
      installRemoteServer = true;
      package = pkgs.unstable.zed-editor;
      extraPackages = config.programs.helix.extraPackages;
    };
  };
}
