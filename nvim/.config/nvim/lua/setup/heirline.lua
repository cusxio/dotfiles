local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local monokai = require("monokai-pro.colorscheme")
local c = monokai.setup("spectrum")

local magenta = c.base.magenta
local cyan = c.base.cyan
local blue = c.base.blue
local yellow = c.base.yellow
local red = c.base.red
local green = c.base.green

local LeftSlantStart = {
  provider = "",
  hl = { bg = c.base.dimmed5, fg = "bg" },
}
local LeftSlantEnd = {
  provider = "",
  hl = { bg = "bg", fg = c.base.dimmed5 },
}
local RightSlantStart = {
  provider = "",
  hl = { fg = c.base.dimmed5, bg = "bg" },
}
local RightSlantEnd = {
  provider = "",
  hl = { fg = "bg", bg = c.base.dimmed5 },
}

local align = { provider = "%=" }
-- local spacer = { provider = " " }

local statusline = {}

--

statusline.VimMode = {
  init = function(self)
    self.mode = vim.fn.mode(1)
    self.mode_color = self.mode_colors[self.mode:sub(1, 1)]
  end,
  update = {
    "ModeChanged",
    pattern = "*:*",
    callback = vim.schedule_wrap(function()
      vim.cmd("redrawstatus")
    end),
  },
  static = {
    mode_names = {
      n = "NORMAL",
      no = "NORMAL",
      nov = "NORMAL",
      noV = "NORMAL",
      ["no\22"] = "NORMAL",
      niI = "NORMAL",
      niR = "NORMAL",
      niV = "NORMAL",
      nt = "NORMAL",
      v = "VISUAL",
      vs = "VISUAL",
      V = "VISUAL",
      Vs = "VISUAL",
      ["\22"] = "VISUAL",
      ["\22s"] = "VISUAL",
      s = "SELECT",
      S = "SELECT",
      ["\19"] = "SELECT",
      i = "INSERT",
      ic = "INSERT",
      ix = "INSERT",
      R = "REPLACE",
      Rc = "REPLACE",
      Rx = "REPLACE",
      Rv = "REPLACE",
      Rvc = "REPLACE",
      Rvx = "REPLACE",
      c = "COMMAND",
      cv = "Ex",
      r = "...",
      rm = "M",
      ["r?"] = "?",
      ["!"] = "!",
      t = "TERM",
    },
    mode_colors = {
      n = red,
      i = green,
      v = cyan,
      V = cyan,
      ["\22"] = cyan, -- this is an actual ^V, type <C-v><C-v> in insert mode
      c = yellow,
      s = magenta,
      S = magenta,
      ["\19"] = magenta, -- this is an actual ^S, type <C-v><C-s> in insert mode
      R = yellow,
      r = yellow,
      ["!"] = red,
      t = green,
    },
  },
  {
    provider = function(self)
      return " %2(" .. self.mode_names[self.mode] .. "%) "
    end,
    hl = function(self)
      return { fg = "bg", bg = self.mode_color }
    end,
  },
  {
    provider = "",
    hl = function(self)
      return { fg = self.mode_color, bg = "bg" }
    end,
  },
}

--

local FileBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  condition = function(self)
    return not conditions.buffer_matches({
      filetype = self.filetypes,
    })
  end,
}

local FileName = {
  provider = function(self)
    local filename = vim.fn.fnamemodify(self.filename, ":t")
    if filename == "" then
      return "[No Name]"
    end
    return " " .. filename .. " "
  end,
  hl = { fg = c.base.dimmed3, bg = c.base.dimmed5 },
}

statusline.FileNameBlock =
  utils.insert(FileBlock, LeftSlantStart, FileName, LeftSlantEnd)

--

statusline.LspAttached = {
  condition = conditions.lsp_attached,
  static = {
    lsp_attached = false,
    show_lsps = {
      ["null-ls"] = false,
    },
  },
  init = function(self)
    for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      if self.show_lsps[server.name] ~= false then
        self.lsp_attached = true
        return
      end
    end
  end,
  update = { "LspAttach", "LspDetach" },
  {
    condition = function(self)
      return self.lsp_attached
    end,
    LeftSlantStart,
    {
      provider = "  ",
      hl = { fg = c.base.dimmed3, bg = c.base.dimmed5 },
    },
    LeftSlantEnd,
  },
}

--

statusline.LspDiagnostics = {
  condition = conditions.has_diagnostics,
  init = function(self)
    self.errors =
      #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings =
      #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints =
      #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info =
      #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,
  update = { "DiagnosticChanged", "BufEnter" },
  -- Errors
  {
    condition = function(self)
      return self.errors > 0
    end,
    hl = { fg = "bg", bg = red },
    {
      {
        provider = "",
      },
      {
        provider = function(self)
          return ("  " .. self.errors .. " ")
        end,
      },
      {
        provider = "",
        hl = { bg = "bg", fg = red },
      },
    },
  },
  -- Warnings
  {
    condition = function(self)
      return self.warnings > 0
    end,
    hl = { fg = "bg", bg = yellow },
    {
      {
        provider = "",
      },
      {
        provider = function(self)
          return ("  " .. self.warnings .. " ")
        end,
      },
      {
        provider = "",
        hl = { bg = "bg", fg = yellow },
      },
    },
  },
  -- Hints
  {
    condition = function(self)
      return self.hints > 0
    end,
    hl = { fg = "bg", bg = blue },
    {
      {
        provider = "",
      },
      {
        provider = function(self)
          return (" 󰌵 " .. self.hints .. " ")
        end,
      },
      {
        provider = "",
        hl = { bg = "bg", fg = blue },
      },
    },
  },
  -- Info
  {
    condition = function(self)
      return self.info > 0
    end,
    hl = { fg = "bg", bg = blue },
    {
      {
        provider = "",
      },
      {
        provider = function(self)
          return (" 󰋼 " .. self.info .. " ")
        end,
      },
      {
        provider = "",
        hl = { bg = "bg", fg = blue },
      },
    },
  },
}

--

local FileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(
      filename,
      extension,
      { default = true }
    )
  end,
  provider = function(self)
    return self.icon and (" " .. self.icon .. " ")
  end,
  hl = { fg = c.base.dimmed3, bg = c.base.dimmed5 },
}

local FileType = {
  provider = function()
    return string.lower(vim.bo.filetype) .. " "
  end,
  hl = { fg = c.base.dimmed3, bg = c.base.dimmed5 },
}

statusline.FileType =
  utils.insert(FileBlock, RightSlantStart, FileIcon, FileType, RightSlantEnd)

--

statusline.SearchResults = {
  condition = function()
    return vim.v.hlsearch ~= 0
  end,
  init = function(self)
    local ok, search = pcall(vim.fn.searchcount)
    if ok and search.total then
      self.search = search
    end
  end,
  {
    provider = "",
    hl = { bg = "bg", fg = yellow },
  },
  {
    provider = function(self)
      local search = self.search

      return string.format(
        " %d/%d ",
        search.current,
        math.min(search.total, search.maxcount)
      )
    end,
    hl = { bg = yellow, fg = "bg" },
  },
  {
    provider = "",
    hl = { bg = yellow, fg = "bg" },
  },
}

--
-- statusline.LspProgress = {
--   condition = conditions.lsp_attached,
-- update = {
--   "User",
--   pattern = "LspProgressUpdate, LspRequest",
--   callback = vim.schedule_wrap(function()
--     vim.cmd.redrawstatus()
--   end),
-- },
--   update = {
--     "LspAttach",
--     "LspDetach",
--     "User LspProgressUpdate"
--     "User LspRequest",
--   },
--   provider = function()
--     if not rawget(vim, "lsp") then
--       return ""
--     end
--
--     local Lsp = vim.lsp.util.get_progress_messages()[1]
--
--     local msg = Lsp.message or ""
--     local percentage = Lsp.percentage or 0
--     local title = Lsp.title or ""
--     local spinners =
--       { "", "󰪞", "󰪟", "󰪠", "󰪢", "󰪣", "󰪤", "󰪥" }
--     local ms = vim.loop.hrtime() / 1000000
--     local frame = math.floor(ms / 120) % #spinners
--     local content = string.format(
--       " %%<%s %s %s (%s%%%%) ",
--       spinners[frame + 1],
--       title,
--       msg,
--       percentage
--     )
--
--     return content
--   end,
--   hl = { bg = yellow, fg = "bg" },
-- }
--

statusline.Ruler = {
  condition = function(self)
    return not conditions.buffer_matches({
      filetype = self.filetypes,
    })
  end,
  {
    provider = "",
    hl = { fg = c.base.dimmed3, bg = "bg" },
  },
  {
    -- %L = number of lines in the buffer
    -- %P = percentage through file of displayed window
    provider = " %P% /%2L ",
    hl = { fg = "bg", bg = c.base.dimmed3 },
  },
}

require("heirline").setup({
  statusline = {
    -- static = {
    --   filetypes = filetypes,
    --   buftypes = buftypes,
    --   force_inactive_filetypes = force_inactive_filetypes,
    -- },
    -- condition = function(self)
    --   return not conditions.buffer_matches({
    --     filetype = self.force_inactive_filetypes,
    --   })
    -- end,
    statusline.VimMode,
    statusline.FileNameBlock,
    statusline.LspAttached,
    statusline.LspDiagnostics,
    -- statusline.LspProgress,
    align,
    statusline.FileType,
    statusline.SearchResults,
    statusline.Ruler,
  },
})
