later(function()
  local function build_blink(params)
    vim.notify("Building blink.cmp", vim.log.levels.INFO)
    local obj = vim
      .system({ "cargo", "build", "--release" }, { cwd = params.path })
      :wait()
    if obj.code == 0 then
      vim.notify("Building blink.cmp done", vim.log.levels.INFO)
    else
      vim.notify("Building blink.cmp failed", vim.log.levels.ERROR)
    end
  end

  add({
    source = "saghen/blink.cmp",
    checkout = "v1.7.0",
    depends = { "rafamadriz/friendly-snippets" },
    hooks = {
      post_install = build_blink,
      post_checkout = build_blink,
    },
  })
end)

lz({
  "blink.cmp",
  event = "InsertEnter",
  after = function()
    require("blink.cmp").setup({
      keymap = { preset = "enter" },
      sources = {
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
        per_filetype = {
          lua = { inherit_defaults = true, "lazydev" },
        },
      },
    })
  end,
})

lz({
  "noice.nvim",
  event = "DeferredUIEnter",
  before = function()
    add({
      source = "folke/noice.nvim",
      depends = {
        "MunifTanjim/nui.nvim",
      },
    })
  end,
  after = function()
    require("noice").setup({
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
      messages = {
        view_search = "mini",
      },
      lsp = {
        hover = {
          silent = true,
        },
        overrides = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
    })
  end,
})

--

lz({
  "lualine.nvim",
  event = "DeferredUIEnter",
  before = function()
    add("nvim-lualine/lualine.nvim")
  end,
  after = function()
    local kirby_default = "(>*-*)>"
    local mode_kirby = {
      n = "<(•ᴗ•)>",
      i = "<(•o•)>",
      v = "(v•-•)v",
      [""] = "(v•-•)>",
      V = "(>•-•)>",
      c = kirby_default,
      no = "<(•ᴗ•)>",
      s = kirby_default,
      S = kirby_default,
      [""] = kirby_default,
      ic = kirby_default,
      R = kirby_default,
      Rv = kirby_default,
      cv = "<(•ᴗ•)>",
      ce = "<(•ᴗ•)>",
      r = kirby_default,
      rm = kirby_default,
      ["r?"] = kirby_default,
      ["!"] = "<(•ᴗ•)>",
      t = "<(•ᴗ•)>",
    }

    local theme = require("lualine.themes.tokyonight-night")
    local modes =
      { "normal", "insert", "command", "visual", "replace", "terminal" }

    for _, mode in ipairs(modes) do
      theme[mode].b.bg = colors.bg
      theme[mode].b.fg = colors.dark5
    end

    theme.normal.c.bg = colors.bg

    local sections = {
      lualine_a = {
        {
          "mode",
          fmt = function()
            return mode_kirby[vim.fn.mode()] or vim.api.nvim_get_mode().mode
          end,
          separator = { right = "" },
        },
      },
      lualine_b = { { "branch" }, { "diagnostics" } },
      lualine_c = {},
      lualine_x = {},
      lualine_y = { { "filename", path = 0 }, { "location" } },
      lualine_z = {
        { "progress", separator = { left = "" } },
      },
    }
    require("lualine").setup({
      options = {
        theme = theme,
        section_separators = "",
        component_separators = "",
      },
      sections = sections,
    })
  end,
})

-- lz({
--   "tiny-glimmer.nvim",
--   event = "DeferredUIEnter",
--   before = function()
--     add("rachartier/tiny-glimmer.nvim")
--   end,
--   after = function()
--     require("tiny-glimmer").setup()
--   end,
-- })
