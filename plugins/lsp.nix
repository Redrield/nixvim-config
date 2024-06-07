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
      extraOptions.before_init.__raw = ''
        function(params, cconf)
          local path = cconf.workspace_folders[1].name
          local conf = vim.fs.find("rust_analyzer.json", { path = path })
          if #conf == 1 then
            local contents = vim.secure.read(conf[1])
            if contents ~= nil then
              params.initializationOptions = vim.tbl_deep_extend('force', params.initializationOptions, vim.json.decode(contents))
            end
          end
        end
      '';
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
