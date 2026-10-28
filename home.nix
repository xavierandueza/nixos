{ pkgs, inputs, ... }:

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
    ./programs/claude-code.nix
    ./programs/mcp.nix
    ./programs/zen-browser.nix
    ./programs/screenshot.nix
    ./programs/hypr
  ];

  # Shared global instructions across coding agents.
  home.file.".claude/CLAUDE.md".source = inputs.agents + "/AGENTS.md";
  home.file.".codex/AGENTS.md".source = inputs.agents + "/AGENTS.md";
  home.file.".config/opencode/AGENTS.md".source = inputs.agents + "/AGENTS.md";
  home.file.".pi/agent/AGENTS.md".source = inputs.agents + "/AGENTS.md";

  fonts.fontconfig.enable = true;
}
