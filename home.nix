{ pkgs, ... }: {
  home.username = "xavier";
  home.homeDirectory = "/home/xavier";
  home.stateVersion = "26.05";
  home.packages = [ pkgs.hello ];

  # Need kitty for default hyprland config apparently
  programs.kitty.enable = true;

 
  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = ''
      hl.bind("SUPER + M", hl.dsp.exit());
    '';

    settings.config = {
      input = {
        kb_layout = "us";
        kb_variant = "colemak";
      };
    };
  };
}
