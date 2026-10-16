# NixOS config

Flake-based NixOS + Home Manager setup. Currently for a Framework 16 (`framework16`) BUT long-term will be on multiple different applications
This repo is symlinked to `/etc/nixos`.

## Philosophy

- **Hyprland** desktop (Wayland), configured via Home Manager.
- **TUI over GUI** wherever a reasonable terminal tool exists
  (e.g. `impala` for wifi, `bluetui` for bluetooth, `lazygit`, `lazydocker`).
- One program per file in `./programs`; larger categories get a sub-folder.

## Layout

```
flake.nix                    # inputs + nixosConfigurations.framework16
configuration.nix            # system-level NixOS config
hardware-configuration.nix   # generated, don't hand-edit
secrets.nix                  # sops-nix secrets (secrets/secrets.yaml)
home.nix                     # Home Manager entry: user, misc GUI apps, imports
programs/
  <program>.nix              # programs go here
  hypr/                      # everything Hyprland desktop related
    default.nix              # imports the files in folder
    ...
assets/                      # wallpapers etc.
```

## Conventions

- New program → new file in `programs/` (or the right sub-folder) and add it to `imports` in `home.nix` (or the sub-folder's `default.nix`).
- Terminal-environment things (shell, prompt, terminal emulator, CLI/TUI tools) go in `programs/terminal.nix`.
- Flake inputs are available in modules via `inputs` (passed through `extraSpecialArgs`).
- New files must be tracked by git (`git add -N <file>` at minimum) or the flake won't see them.
- Format with `nixfmt`.

## Applying changes

```sh
sudo nixos-rebuild test     # try it out (not persisted to boot menu)
sudo nixos-rebuild switch   # only after `test` succeeds
```

Quick eval check without building:

```sh
nix eval .#nixosConfigurations.framework16.config.system.build.toplevel.drvPath
```
