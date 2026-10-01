{ pkgs, inputs, lib, ... }: 
{
  home.username = "xavier";
  home.homeDirectory = "/home/xavier";
  home.stateVersion = "26.05";
  home.packages = [ 
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.hyprshutdown
    pkgs.blesh
  ];

  imports = [ 
    inputs.zen-browser.homeModules.beta
  ];

  fonts.fontconfig.enable = true;

  programs = {
    ghostty = {
      enable = true;
      clearDefaultKeybinds = true; # Never use them

      settings = {
        font-size = 10;
	theme = "TokyoNight Moon";
      };
    };

    bash = {
      enable = true;
      enableCompletion = true;
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      options = [ "--cmd" "cd" ];
    };

    ripgrep.enable = true;
    bottom.enable = true;

    atuin = {
      enable = true;
      enableBashIntegration = true;
      daemon.enable = true;
      settings = {
        enter_accept = true;
      };
    };

    starship = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        add_newline = true;
	command_timeout = 200;
        format = "[$directory$git_branch$git_status]($style)\n$character";
        character = {
          success_symbol = "[❯](bold purple)";
	  error_symbol = "[✗](bold purple)";
        };
	directory = {
	  truncation_length = 2;
	  truncation_symbol = "../";
	  read_only = " 󰍁";
	  read_only_style = "cyan";
	  repo_root_style = "bold cyan";
	  repo_root_format = "[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) ";
	};
	git_branch = {
	  format = "[$branch]($style) ";
	  style = "italic cyan";
	};
	git_status = {
	  format = "[$all_status]($style)";
	  style = "cyan";
	  ahead = "\${count} ";
	  diverged = "󰹹\${count} \${behind_count} ";
	  behind = "\${count}";
	  conflicted = " ";
	  up_to_date = " ";
	  modified = " ";
	  stashed = "";
	  staged = "";
	  renamed = "";
	  deleted = "";
	};
      };
    };

    gh.enable = true;
    lazygit = {
      enable = true;
      enableBashIntegration = true;
    };
    docker-cli.enable = true;
    lazydocker.enable = true;
    
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
    };

    zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;
      policies = let
        mkExtensionSettings = builtins.mapAttrs (_: pluginId: {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
          installation_mode = "force_installed";
        });
      in {
        AutofillAddressEnabled = true;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        ExtensionSettings = mkExtensionSettings {
	  "uBlock0@raymondhill.net" = "ublock-origin";
        };
      };
    };

    waybar = {
      enable = true;
      systemd.enable = true;

      settings = {
        mainbar = {
	  layer = "top";
	  position = "top";
	  height = 27;
	  output = [
	    "eDP-1"
	  ];
	  modules-left = [ "hyprland/workspaces" ];
	  modules-center = [ "clock" ];
	  modules-right = ["battery"];

          battery = {
            format = "{capacity}% {icon}";
            format-icons = {
              default = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
              charging = [ "󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂄" ];
	    };
          };

	  "hyprland/workspaces" = {
	    update-active-window = true;
	    persistent-workspaces."*" = [ 1 2 3 4 5 ];
	  };
	};
      };
      style = ''

        * {
	  border: none;
	  border-radius: 0;
	  font-size: 12px;
	  font-weight: 400;
	  font-family: "JetBrainsMono Nerd Font";
	}

	window#waybar {
	  background: #1b1b2b;
	  color: #c8d3f5;
	}

	#workspaces {
	  margin-left: 8px;
	}

	#battery {
	  margin-right: 12px;
	}

	#workspaces button {
	  padding: 0 6px;
	  margin: 0;
	  min-width: 0;
	}

	#workspaces button.active {
	  color: #c8d3f5;
	}
      '';
    };

    hyprlock = { 
      enable = true;
    };
  };
  
  services = {
    mako = {
      enable = true;

      extraConfig = ''
        max-history=10
      '';
    };

    hyprpolkitagent.enable = true;

    hyprpaper = {
      enable = true;
      settings.wallpaper = [
        {
	  fit_mode = "cover";
	  monitor = "";
	  path = "${./wallpapers/artsy.jpg}";
	}
      ];
    };

    hyprlauncher = {
      enable = true;
    };

    hypridle = {
      enable = true;
      settings = {
        general = {
	  lock_cmd = "hyprlock";
	  after_sleep_cmd = "hyprctl dispatch dpms on";

	};
        listener = [
	  {
	    on-timeout = "hyprlock";
	    timeout = 600;
	  }
	  {
	    on-resume = "hyprctl dispatch dpms on";
	    on-timeout = "hyprctl dispatch dpms off";
	    timout = 1500;
	  }
	];
      };
    };
  };
 
  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = ''
      -- TODO: update to hyprshutdown at some point
      hl.bind("SUPER + SHIFT + M", hl.dsp.exit());

      -- Application binds
      hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("ghostty"));
      hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd("zen-beta"));
      hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("hyprlauncher"));

      -- General Window Binds
      hl.bind("SUPER + Q", hl.dsp.window.close());
      hl.bind("SUPER + F", hl.dsp.window.fullscreen({ action = "toggle" }));
      hl.bind("SUPER + MINUS", hl.dsp.window.resize({ x = -50, y=0, relative = true }));
      hl.bind("SUPER + EQUAL", hl.dsp.window.resize({ x = 50, y=0, relative = true }));

      -- Window Focus and Movement
      for _, item in ipairs({
        { key = "H", direction = "l" },
        { key = "J", direction = "d" },
        { key = "K", direction = "u" },
        { key = "L", direction = "r" },
      }) do
	-- Focus
        hl.bind(
	  "SUPER + " .. item.key,
	  hl.dsp.focus({ direction = item.direction })
	);

	-- Movement
	hl.bind(
	  "SUPER + SHIFT + " .. item.key,
	  hl.dsp.window.move({ direction = item.direction })
	);
      end

      -- Workspaces
      for i = 0, 9 do
	local key = tostring(i);
	local ws = i == 0 and 10 or i;

	-- Focus workspace
	hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = ws }));
	
        -- Move window to workspace
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = ws, follow = true }));
      end

      -- Move Workspace to Monitor
      for i = 1, 2 do
        local key = tostring(i);
	hl.bind("SUPER + ALT + " .. key, hl.dsp.workspace.move({ monitor = i }));
      end;

      -- Styles
      hl.curve( "myBezier", { type = "bezier", points = { {0, 0.25}, {0.5, 1} } });
      hl.animation({ leaf = "windows", enabled = true, speed = 1.5, bezier = "myBezier", style = "popin" })
      hl.animation({ leaf = "fade", enabled = true, speed = 1.8, bezier = "myBezier" });
      hl.animation({ leaf = "workspaces", enabled = false });
    '';

    settings.config = {
      input = {
        kb_layout = "us";
        kb_variant = "colemak";
      };

      general = {
        border_size = 2;
	gaps_in = 5;
	gaps_out = 10;
        col = { 
          active_border = "0xff86e1fc";
	  inactive_border = "0xbb444a73";
	};
      };

      decoration = { 
        rounding = 10;
	active_opacity = 0.99;
	inactive_opacity = 0.95;
      };

      cursor = {
        hide_on_key_press = true;
	inactive_timeout = 60;
      };
    };
  };
}
