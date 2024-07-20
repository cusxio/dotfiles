---@type LazySpec
return {
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   ---@type CatppuccinOptions
  --   opts = {
  --     flavour = "macchiato",
  --     default_integrations = false,
  --     integrations = {
  --       cmp = true,
  --       gitsigns = true,
  --       illuminate = { enabled = true, lsp = true },
  --       indent_blankline = true,
  --       mason = true,
  --       mini = true,
  --       -- native_lsp = {
  --       --   enabled = true,
  --       -- },
  --       neotree = true,
  --       -- noice = true,
  --       notify = true,
  --       semantic_tokens = true,
  --       symbols_outline = true,
  --       telescope = { enabled = true, style = "classic" },
  --       treesitter = true,
  --       which_key = true,
  --       window_picker = true,
  --     },
  --   },
  -- },
  -- {
  --   "cdmill/neomodern.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("neomodern").setup({
  --       style = "roseprime",
  --     })
  --     require("neomodern").load()
  --   end,
  -- },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    ---@class tokyonight.Config
    opts = {
      style = "night",
      on_highlights = function(hl, c)
        hl.NeoTreeGitUnstaged = {
          fg = c.red,
        }
        hl.NeoTreeTabActive = { fg = c.blue, bg = c.bg_dark }
      end,
    },
    -- opts = {},
  },
  -- {
  --   "marko-cerovac/material.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     contrast = {
  --       lsp_virtual_text = true,
  --     },
  --     high_visibility = {
  --       darker = true,
  --     },
  --     plugins = {
  --       "flash",
  --       "gitsigns",
  --       "illuminate",
  --       "indent-blankline",
  --       "mini",
  --       "neo-tree",
  --       "noice",
  --       "nvim-cmp",
  --       "nvim-web-devicons",
  --       "telescope",
  --       "trouble",
  --       "which-key",
  --       "nvim-notify",
  --     },
  --     custom_highlights = {
  --       NeoTreeTabActive = { bold = false },
  --     },
  --   },
  --   config = function(_, opts)
  --     require("material").setup(opts)
  --     vim.g.material_style = "deep ocean"
  --   end,
  -- },
  -- {
  --   "loctvl842/monokai-pro.nvim",
  --   config = function()
  --     require("monokai-pro").setup({
  --       devicons = true,
  --       filter = "spectrum",
  --       ---@param c Colorscheme
  --       override = function(c)
  --         return {
  --           IblIndent = { fg = c.base.dimmed5 },
  --           MiniStarterHeader = { fg = c.base.dimmed2 },
  --           -- StatusLine = { fg = c.base.dimmed3 },
  --         }
  --       end,
  --     })
  --   end,
  -- },
}
