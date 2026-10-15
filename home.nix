{ pkgs, inputs, ... }:

{
  home.username = "xavier";
  home.homeDirectory = "/home/xavier";
  home.stateVersion = "26.05";
  home.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.hyprshutdown
    pkgs.freecad
    pkgs.bluetui
    pkgs.slack
    pkgs.discord
  ];

  imports = [
    ./programs/nvim.nix
    ./programs/herdr.nix
    ./programs/pi.nix
    ./programs/hyprland.nix
    inputs.zen-browser.homeModules.beta
  ];

  fonts.fontconfig.enable = true;

  programs = {
    impala.enable = true;

    ghostty = {
      enable = true;
      clearDefaultKeybinds = true; # Never use them

      settings = {
        font-size = 10;
        theme = "TokyoNight Moon";
        clipboard-read = "allow";
      };
    };

    bash = {
      enable = true;
      enableCompletion = true;
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      options = [
        "--cmd"
        "cd"
      ];
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
        add_newline = false;
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

    zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;
      profiles = {
        default = {
          mods = [
            "c01d3e22-1cee-45c1-a25e-53c0f180eea8" # Ghost Tabs
            "e122b5d9-d385-4bf8-9971-e137809097d0" # No top sites
            "4ab93b88-151c-451b-a1b7-a1e0e28fa7f8" # No Sidebar Scroll
          ];
          search = {
            force = true; # Enforce declared search engines on each rebuild
            default = "ddg";
            engines = {
              mynixos = {
                name = "My NixOS";
                urls = [
                  {
                    template = "https://mynixos.com/search?q={searchTerms}";
                    params = [
                      {
                        name = "query";
                        value = "searchTerms";
                      }
                    ];
                  }
                ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@nx" ];
              };
              github = {
                name = "GitHub Search";
                urls = [
                  {
                    template = "https://github.com/search?q={searchTerms}";
                  }
                ];
                definedAliases = [ "@gh" ];
              };
            };
          };
          containersForce = true;
          containers = {
            personal = {
              id = 1;
              color = "blue";
              icon = "fingerprint";

            };
            work = {
              id = 2;
              color = "purple";
              icon = "briefcase";
            };
          };
          spacesForce = true;
          spaces = {
            "Personal" = {
              id = "c6de089c-410d-4206-961d-ab11f988d40a";
              position = 1000;
              icon = "🟦";
              theme = {
                type = "gradient";

                colors = [
                  {
                    red = 42;
                    green = 100;
                    blue = 155;
                    algorithm = "floating";
                    type = "explicit-lightness";
                    lightness = 50;
                  }
                  {
                    red = 87;
                    green = 154;
                    blue = 199;
                    algorithm = "floating";
                    type = "explicit-lightness";
                    lightness = 50;
                  }
                  {
                    red = 79;
                    green = 176;
                    blue = 213;
                    algorithm = "floating";
                    type = "explicit-lightness";
                    lightness = 50;
                  }
                ];
              };
              pins = {
                "ChatGPT" = {
                  id = "58793b4f-2970-4387-8142-10e4b136936d";
                  url = "https://chatgpt.com/";
                  position = 100;
                  isEssential = true;
                };
                "Email" = {
                  id = "5e8db6a4-92c7-4f31-8a60-1b9f3ce47d28";
                  url = "https://mail.google.com";
                  position = 200;
                  isEssential = true;
                };
                "Calendar" = {
                  id = "faef6165-f4e8-41cc-b64b-0af980504d77";
                  url = "https://calendar.notion.so/";
                  position = 300;
                  isEssential = true;
                };
              };
            };
            "Work" = {
              id = "cdd10fab-4fc5-494b-9041-325e5759195b";
              position = 2000;
              icon = "🟪";
              theme = {
                type = "gradient";

                colors = [
                  {
                    red = 100;
                    green = 42;
                    blue = 155;
                    algorithm = "floating";
                    type = "explicit-lightness";
                    lightness = 50;
                  }
                  {
                    red = 126;
                    green = 87;
                    blue = 199;
                    algorithm = "floating";
                    type = "explicit-lightness";
                    lightness = 50;
                  }
                  {
                    red = 114;
                    green = 83;
                    blue = 237;
                    algorithm = "floating";
                    type = "explicit-lightness";
                    lightness = 50;
                  }
                ];
              };

            };
          };
        };
      };
      policies =
        let
          mkExtensionSettings = builtins.mapAttrs (
            _: pluginId: {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
              installation_mode = "force_installed";
            }
          );
        in
        {
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
            "nordpassStandalone@nordsecurity.com" = "nordpass-password-management";
            "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = "vimium-ff";
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
          modules-right = [ "battery" ];

          battery = {
            format = "{capacity}% {icon}";
            format-icons = {
              default = [
                "󰂎"
                "󰁺"
                "󰁻"
                "󰁼"
                "󰁽"
                "󰁾"
                "󰁿"
                "󰂀"
                "󰂁"
                "󰂂"
                "󰁹"
              ];
              charging = [
                "󰢟"
                "󰢜"
                "󰂆"
                "󰂇"
                "󰂈"
                "󰢝"
                "󰂉"
                "󰢞"
                "󰂊"
                "󰂋"
                "󰂄"
              ];
            };
          };

          "hyprland/workspaces" = {
            update-active-window = true;
            persistent-workspaces."*" = [
              1
              2
              3
              4
              5
            ];
            format = "{icon}";
            format-icons = {
              active = "";
            };
          };
        };
      };
      style = ''

                * {
        	  border: none;
        	  border-radius: 0;
        	  font-size: 12px;
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
        	  color: #c8d3f5;
        	}

                #workspaces button.empty {
                  color: alpha(#c8d3f5, 0.35);
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
      settings = {
        splash = false;
        wallpaper = [
          {
            fit_mode = "cover";
            monitor = "";
            path = "${./assets/wallpapers/desktop.png}";
          }
        ];
      };
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

}
