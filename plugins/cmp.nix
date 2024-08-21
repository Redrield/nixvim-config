{ ... }:
{
  opts = {
    enable = true;
    autoEnableSources = true;
    settings.snippet.expand = ''
      function(args)
        require('luasnip').lsp_expand(args.body)
      end
    '';
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
}
