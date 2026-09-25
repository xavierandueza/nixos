{ pkgs, ... }: {
  home.username = "xavier";
  home.homeDirectory = "/home/xavier";
  home.stateVersion = "26.05";
  home.packages = [ pkgs.hello ];

  programs = {
    ghostty = {
      enable = true;
    };
    
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
    };
  };
 
  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = ''
      hl.bind("SUPER + M", hl.dsp.exit());
      hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("ghostty"));
    '';

    settings.config = {
      input = {
        kb_layout = "us";
        kb_variant = "colemak";
      };
    };
  };
}
