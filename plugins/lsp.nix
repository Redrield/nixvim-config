{ ... }:
{
  opts = {
    enable = true;
    servers.nixd = {
      enable = true;
      autostart = true;
    };
    #TODO: Dynamically put together the server configs from subfiles
    # Servers for golang and rust will be provided by dev envs, don't install packages.
    servers.rust-analyzer = {
      installCargo = false;
      installRustc = false;
      enable = true;
      autostart = true;
      package = null;
    };
    servers.gopls = {
      enable = true;
      autostart = true;
      package = null;
    };
  };
}
