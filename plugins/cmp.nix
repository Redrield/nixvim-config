{ ... }:
{
  opts = {
    enable = true;
    sources = [
      { name = "nvim_lsp"; }
      { name = "path"; }
      { name = "buffer"; }
      { name = "cmdline"; }
    ];

    mapping = {
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
    plugins.cmp-buffer.enable = true;
    plugins.cmp-nvim-lsp.enable = true;
    plugins.cmp-path.enable = true;
    plugins.cmp-cmdline.enable = true;

    keymaps = [
      {
        action = "<cmd>Telescope live_grep<CR>";
        key = "<leader>g";
      }
    ];
  };
}
