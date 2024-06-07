{ ... }:
{
  opts = {
    enable = true;
    autoEnableSources = true;
    settings.snippet.expand = "luasnip";
    settings.sources = [
      { name = "nvim_lsp"; }
      { name = "path"; }
      { name = "buffer"; }
      { name = "cmdline"; }
    ];


    settings.mapping = {
      "<CR>" = "cmp.mapping.confirm({ select = true  })";
      "<Tab>" = {
        action = ''
          function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end
        '';
      };
    };
  };
  rootOpts = {
    keymaps = [
      {
        action = "<cmd>Telescope live_grep<CR>";
        key = "<leader>g";
      }
    ];
  };
}
