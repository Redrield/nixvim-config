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
      enable = true;
      autostart = true;
      package = null;
      extraOptions = builtins.fromJSON (builtins.readFile "$HOME/.config/lsp/rust.json")
    };
    servers.gopls = {
      enable = true;
      autostart = true;
      package = null;
    };
  };
}
