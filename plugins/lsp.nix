{ ... }:
{
  opts = {
    enable = true;
    servers.nixd = {
      enable = true;
      autostart = true;
    };

    servers.eslint = {
      enable = true;
      autostart = true;
    };

    servers.tsserver = {
      enable = true;
      autostart = true;
    };

    servers.html = {
      enable = true;
      autostart = true;
    };

    servers.clangd = {
      enable = true;
      autostart = true;
    };

    servers.csharp-ls = {
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
            local hdle = io.open(conf[1], "r")
            local contents = hdle:read("*all")
            hdle:close()
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

    keymaps.lspBuf = {
      K = "hover";
      gd = "definition";
      gr = "references";
      "<leader>la" = "code_action";
      "<leader>lr" = "rename";
      "<leader>lf" = "format";
    };
  };
}
