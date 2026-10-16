{ ... }:

{
  services = {
    mako = {
      enable = true;

      extraConfig = ''
        max-history=10
      '';
    };
  };
}
