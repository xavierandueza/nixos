{ ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = ''
      -- Scaling xwayland apps
      hl.env("GDK_SCALE", "2")
      hl.env("XCURSOR_SIZE", "32")

      -- Monitors
      hl.monitor({
        output = "edp-1",
        mode = "preferred",
        scale = "auto"
      })

      hl.monitor({
        output = "DP-4",
        mode = "preferred",
        scale = "1.25"
      })
    '';
  };
}
