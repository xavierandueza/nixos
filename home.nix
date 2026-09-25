{ pkgs, ... }: {
  home.username = "xavier";
  home.homeDirectory = "/home/xavier";
  home.stateVersion = "26.05";
  home.pkgs = [ pkgs.hello ];
}
