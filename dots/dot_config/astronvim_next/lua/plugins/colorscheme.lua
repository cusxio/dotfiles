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
  {
    "marko-cerovac/material.nvim",
    config = function()
      vim.g.material_style = "darker"
    end,
    opts = {
      contrast = {
        lsp_virtual_text = true,
      },
      high_visibility = {
        darker = true,
      },
      plugins = {
        -- "coc"
        -- "dap",
        -- "dashboard",
        -- "eyeliner",
        -- "fidget",
        -- "flash",
        "gitsigns",
        -- "harpoon",
        -- "hop",
        "illuminate",
        "indent-blankline",
        -- "lspsaga",
        "mini",
        -- "neogit",
        -- "neotest",
        "neo-tree",
        -- "neorg",
        "noice",
        "nvim-cmp",
        -- "nvim-navic",
        -- "nvim-tree",
        "nvim-web-devicons",
        -- "rainbow-delimiters",
        -- "sneak",
        "telescope",
        -- "trouble",
        "which-key",
        "nvim-notify",
      },
    },
  },
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
