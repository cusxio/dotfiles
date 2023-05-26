local get_icon = require("utils").get_icon
-- local monokai = require("monokai-pro.colorscheme")
-- local c = monokai.setup("spectrum")

local active_clients = function()
  local clients = vim.lsp.buf_get_clients()
  local client_names = {}

  for _, client in pairs(clients) do
    if client.name ~= "null-ls" then
      table.insert(client_names, client.name)
    end
  end

  if #client_names > 0 then
    return table.concat(client_names, ", ")
  end

  return ""
end

-- local colors = {
--   -- bg = c.editor.bg,
--   bg = "#2b2b2b",
--   fg = c.base.dimmed3,
-- }

-- local theme = {
--   normal = {
--     a = { fg = colors.fg, bg = colors.bg },
--     b = { fg = colors.fg, bg = colors.bg },
--     c = { fg = colors.fg, bg = colors.bg },
--   },
--   insert = { a = { fg = colors.fg, bg = colors.bg } },
--   visual = { a = { fg = colors.fg, bg = colors.bg } },
--   command = { a = { fg = colors.fg, bg = colors.bg } },
--   replace = { a = { fg = colors.fg, bg = colors.bg } },
--   inactive = {
--     a = { fg = colors.fg, bg = colors.bg },
--     b = { fg = colors.fg, bg = colors.bg },
--     c = { fg = colors.fg, bg = colors.bg },
--   },
-- }

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { statusline = { "lazy", "alpha" } },
    ignore_focus = {
      "help",
      "TelescopePrompt",
    },
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = { { "mode" } },
    lualine_b = {
      {
        "b:gitsigns_head",
        icon = get_icon("Git"),
        disabled_buftypes = { "neo-tree" },
      },
      {
        "diff",
        symbols = {
          added = get_icon("GitAdd") .. " ",
          modified = get_icon("GitChange") .. " ",
          removed = get_icon("GitDelete") .. " ",
        },
        -- diff_color = {
        --   added = "DiffAdd",
        --   modified = "DiffChange",
        --   removed = "DiffDelete",
        -- },
        colored = false,
        disabled_buftypes = { "neo-tree" },
      },
    },
    lualine_c = {},
    lualine_x = {
      {
        "lsp_progress",
        display_components = {
          "lsp_client_name",
          { "title", "percentage", "message" },
        },
        timer = { progress_enddelay = 500, lsp_client_name_enddelay = 500 },
        hide = { "null-ls" },
        only_show_attached = true,
      },
      {
        active_clients,
        disabled_buftypes = { "neo-tree" },
      },
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn", "info", "hint" },
        symbols = {
          error = get_icon("DiagnosticError") .. " ",
          warn = get_icon("DiagnosticWarn") .. " ",
          info = get_icon("DiagnosticInfo" .. " "),
          hint = get_icon("DiagnosticHint") .. " ",
        },
        -- color = {
        --   bg = c.inputValidation.errorForeground,
        -- },
        -- diagnostics_color = {
        -- error = { bg = colors.bg, fg = c.inputValidation.errorForeground },
        -- warn = { bg = colors.bg, fg = c.inputValidation.warningForeground },
        -- info = { bg = colors.bg, fg = c.inputValidation.infoForeground },
        -- hint = { bg = colors.bg, fg = c.inputValidation.infoForeground },
        -- error = "DiagnosticError",
        -- warn = "DiagnosticWarn",
        -- info = "DiagnosticInfo",
        -- hint = "DiagnosticHint",
        -- },
        -- colored = false,
        disabled_buftypes = { "neo-tree" },
        -- always_visible = true,
      },
      { "searchcount" },
    },
    lualine_y = {
      {
        "filetype",
        colored = false,
        icon_only = true,
      },
    },
    lualine_z = { { "location" }, { "progress" } },
  },
  inactive_sections = {
    lualine_a = { { "mode" } },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { { "location" }, { "progress" } },
  },
})
