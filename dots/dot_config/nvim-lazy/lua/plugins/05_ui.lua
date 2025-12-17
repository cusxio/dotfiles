---@type LazySpec
return {
  -- colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    ---@module "tokyonight"
    ---@type tokyonight.Config
    opts = {
      style = "night",
      on_highlights = function(highlights, colors)
        highlights["LualineFilename"] = { fg = colors.fg, bg = colors.bg }
        highlights["LualineFilenameModified"] = { fg = colors.orange, bg = colors.bg }
        highlights["WinSeparator"] = { fg = "#262626" }
      end,
      on_colors = function(colors)
        colors.git.add = "#a6e22e"
        colors.git.change = "#ffd700"
        colors.git.delete = "#f92672"
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.g.tokyo_colors = require("tokyonight.colors").setup(opts)

      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    "nvim-mini/mini.icons",
    opts = {},
  },
  {
    "nvim-mini/mini.cursorword",
    event = vim.g.lazy_file_events,
    opts = {},
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
      messages = {
        view_error = "notify",
        view_warn = "notify",
        view = "mini",
        view_search = "mini",
      },
      redirect = {
        view = "mini",
        filter = { event = "msg_show" },
      },
      routes = {
        { filter = { find = "E486: Pattern not found:" }, view = "mini" },
        { filter = { find = "No information available" }, opts = { stop = true } },
        -- https://github.com/ilan-schemoul/nvim-config/blob/a846d7ad0209cf1bae05f2d5aae3662215420ee1/nvim/lua/config/noice-routes.lua
        { filter = { event = "msg_show", kind = "", find = '"[%w%p]+" %d+L, %d+B' }, opts = { skip = true } },
      },
      lsp = {
        hover = {
          silent = true,
          opts = {
            border = {
              padding = { 1, 2 },
            },
          },
        },
        overrides = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
    },
  },
  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
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
      local modes = { "normal", "insert", "command", "visual", "replace", "terminal" }

      local colors = vim.g.tokyo_colors
      for _, mode in ipairs(modes) do
        theme[mode].b.bg = colors.bg
        theme[mode].b.fg = colors.dark5
      end

      theme.normal.c.bg = colors.bg

      local function pretty_path()
        local path = vim.fn.expand("%:p")

        if path == "" then
          return ""
        end

        local cwd = vim.fn.getcwd()
        local home = vim.env.HOME

        if cwd ~= "/" and path:find(cwd, 1, true) then
          path = path:sub(#cwd + 2)
        end

        path = path:gsub(home, "~")

        local parts = {}
        for part in path:gmatch("[^/]+") do
          table.insert(parts, part)
        end

        local filename = table.remove(parts) or ""

        local final_path = ""
        if #parts > 2 then
          final_path = parts[1] .. "/…/" .. parts[#parts] .. "/"
        else
          final_path = table.concat(parts, "/") .. (#parts > 0 and "/" or "")
        end

        local hl = "%#LualineFilename#"
        if vim.bo.modified then
          hl = "%#LualineFilenameModified#"
        end

        return final_path .. hl .. filename
      end

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
        lualine_b = { { "branch" }, { "diff" }, { "diagnostics" } },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {
          {
            pretty_path,
            cond = function()
              return vim.fn.expand("%:p") ~= ""
            end,
          },
        },
        lualine_z = {
          { "progress", separator = { left = "" } },
          { "location" },
        },
      }

      local inactive_sections = {
        lualine_a = { { "mode" } },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { { "progress", "location" } },
      }

      return {
        options = {
          globalstatus = true,
          theme = theme,
          section_separators = "",
          component_separators = "",
        },
        sections = sections,
        inactive_sections = inactive_sections,
        extensions = {
          "lazy",
          "mason",
          "oil",
        },
      }
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>c", group = "code" },
          { "<leader>f", group = "file/find" },
          { "<leader>l", group = "lsp" },
          { "[", group = "prev" },
          { "]", group = "next" },
          {
            "<leader>b",
            group = "buffer",
            expand = function()
              return require("which-key.extras").expand.buf()
            end,
          },
        },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Keymaps (which-key)",
      },
    },
  },
}
