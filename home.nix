{ pkgs, ... }:

{
  home.username = "xavier";
  home.homeDirectory = "/home/xavier";
  home.stateVersion = "26.05";
  home.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.freecad
    pkgs.slack
    pkgs.discord
    pkgs.wl-clipboard
  ];

  imports = [
    ./programs/terminal.nix
    ./programs/nvim.nix
    ./programs/herdr.nix
    ./programs/pi.nix
    ./programs/zen-browser.nix
    ./programs/screenshot.nix
    ./programs/hypr
  ];

  fonts.fontconfig.enable = true;
}
