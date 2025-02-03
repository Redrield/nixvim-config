
{ icons, pkgs, ... }:

{
  opts = {
    enable = true;

    # Set keymaps when LSP is attached
    keymaps = {
      extra = [
        {
          mode = "n";
          key = "<leader>li";
          action = "<cmd>LspInfo<cr>";
          options.desc = "Show LSP info";
        }
        {
          mode = "n";
          key = "<leader>ll";
          action.__raw = "function() vim.lsp.codelens.refresh() end";
          options.desc = "LSP CodeLens refresh";
        }
        {
          mode = "n";
          key = "<leader>lL";
          action.__raw = "function() vim.lsp.codelens.run() end";
          options.desc = "LSP CodeLens run";
        }
      ];

      lspBuf = {
        "<leader>la" = {
          action = "code_action";
          desc = "LSP code action";
        };

        "<leader>lr" = {
          action = "rename";
          desc = "LSP rename";
        };

        "<leader>lf" = {
          action = "format";
          desc = "LSP format";
        };

        gd = {
          action = "definition";
          desc = "Go to definition";
        };

        gI = {
          action = "implementation";
          desc = "Go to implementation";
        };

        gy = {
          action = "type_definition";
          desc = "Go to type definition";
        };

        K = {
          action = "hover";
          desc = "LSP hover";
        };
      };
    };

    postConfig = ''
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = true,
        severity_sort = false,
      })

      local signs = {
        Error = "${icons.DiagnosticError}",
        Warn = "${icons.DiagnosticWarn}",
        Info = "${icons.DiagnosticInfo}",
        Hint = "${icons.DiagnosticHint}",
      }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    '';

    # Load all servers definitions
    servers = {
      arduino_language_server.enable = true;
      ansiblels.enable = true;
      bashls.enable = true;
      ccls.enable = true;
      csharp_ls.enable = true;
      docker_compose_language_service.enable = true;
      dockerls.enable = true;
      eslint.enable = true;
      gopls = {
        enable = true;
        autostart = true;
      };
      helm_ls.enable = true;
      html.enable = true;
      java_language_server.enable = true;
      jsonls.enable = true;
      lua_ls.enable = true;
      nginx_language_server.enable = true;
      nixd.enable = true;
      pylsp = {
        enable = true;
        settings.plugins = {
          yapf.enabled = true;
          pylint.enabled = true;
          jedi_completion.enabled = true;
          jedi_definition.enabled = true;
          jedi_hover.enabled = true;
          jedi_references.enabled = true;
          jedi_signature_help.enabled = true;
          jedi_symbols.enabled = true;
          flake8.enabled = true;
        };
      };
      phpactor.enable = true;
      sqls.enable = true;
      terraformls.enable = true;
      ts_ls.enable = true;

      #TODO: Dynamically put together the server configs from subfiles
      rust_analyzer = {
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
    };
  };

  rootOpts = {
    colorschemes.catppuccin.settings.integrations.native_lsp.enabled = true;
    extraPackages = [ pkgs.go ];
  };
}
