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
    ];

    settings.mapping = {
      "<CR>" = "cmp.mapping.confirm({ select = true  })";
      "<Tab>" = ''
          function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end
      '';
    };

    cmdline.":" = {
      mapping.__raw = "cmp.mapping.preset.cmdline()";
      sources = [
        { name = "path"; }
        {
          name = "cmdline";
          option.ignore_cmds = [
            "Man"
            "!"
          ];
        }
      ];
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
