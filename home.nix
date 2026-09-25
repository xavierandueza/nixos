{ pkgs, ... }: {
  home.username = "xavier";
  home.homeDirectory = "/home/xavier";
  home.stateVersion = "26.05";
  home.packages = [ pkgs.hello ];
  
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      input = {
        kb_layout = "us";
        kb_variant = "colemak";
      };
      bind = [
        "SUPER, M, exit,"
      ];
    };
  };
}
