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
  };

  rootOpts = {
    keymaps = [
      {
        key = "<leader>la";
        options.desc = "LSP Code actions";
        action.__raw = ''
          function()
            vim.lsp.buf.code_action()
          end
        '';
      }
      {
        key = "K";
        options.desc = "Show hover";
        action = "<cmd>lua vim.lsp.buf.hover()<CR>";
      }
      {
        key = "gd";
        options.desc = "Goto definition";
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
      }
      {
        key = "gr";
        options.desc = "Goto references";
        action = "<cmd>lua vim.lsp.buf.references()<CR>";
      }
      {
        key = "gl";
        options.desc = "LSP Line Diagnostics";
        action.__raw = ''
          function()
            local float = vim.diagnostic.config().float

            if float then
              local config = type(float) == "table" and float or {}
              config.scope = "line"
              vim.diagnostic.open_float(config)
            end
          end
        '';
      }
      {
        key = "<leader>lf";
        options.desc = "Format buffer";
        action.__raw = ''
          function()
            vim.lsp.format()
          end
        '';
      }
    ];
  };
}
