{ pkgs, ... }: {
  home.username = "xavier";
  home.homeDirectory = "/home/xavier";
  home.stateVersion = "26.05";
  home.packages = [ pkgs.hello ];

  programs = {
    ghostty = {
      enable = true;
      clearDefaultKeybinds = true; # Never use them

      settings = {
        font-size = 11;
	theme = "TokyoNight Moon";
      };
    };
    
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
    };

    waybar = {
      enable = true;
      systemd.enable = true;

      settings = {
        mainbar = {
	  layer = "top";
	  position = "top";
	  height = 30;
	  output = [
	    "eDP-1"
	  ];
	  # modules-left = [ ];
	  # modules-center = [ "clock" ];
	  # modules-right = ["battery"];
	};
      };
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
  };
 
  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = ''
      -- TODO: update to hyprshutdown at some point
      hl.bind("SUPER + SHIFT + M", hl.dsp.exit());

      -- Application binds
      hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("ghostty"));

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
	active_opacity = 0.975;
	inactive_opacity = 0.95;
      };

      cursor = {
        hide_on_key_press = true;
	inactive_timeout = 60;
      };
    };
  };
}
