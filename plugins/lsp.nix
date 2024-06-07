{ ... }:
{
  opts = {
    enable = true;
    servers.nixd = {
      enable = true;
      autostart = true;
    };
    # Servers for golang and rust will be provided by dev envs, don't install packages.
    servers.rust-analyzer = {
      installCargo = false;
      enable = true;
      autostart = true;
      package = null;
      cmd = [ "rust-analyzer" "--config-path" "$HOME/.config/lsp/rust.json" ];
    };
    servers.gopls = {
      enable = true;
      autostart = true;
      package = null;
    };
  };
}
