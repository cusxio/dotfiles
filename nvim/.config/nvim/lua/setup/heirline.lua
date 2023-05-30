local get_icon = require("utils").get_icon
local conditions = require("heirline.conditions")
-- local utils = require("heirline.utils")

local Align = { provider = "%=" }
local Space = { provider = " " }

local ViMode = {
  static = {
    mode_names = {
      n = "NORMAL",
      no = "O-PENDING",
      nov = "O-PENDING",
      noV = "O-PENDING",
      ["no\22"] = "O-PENDING",
      niI = "NORMAL",
      niR = "NORMAL",
      niV = "NORMAL",
      nt = "NORMAL",
      v = "VISUAL",
      vs = "VISUAL",
      V = "V-LINE",
      Vs = "V-LINE",
      ["\22"] = "V-BLOCK",
      ["\22s"] = "V-BLOCK",
      s = "SELECT",
      S = "S-LINE",
      ["\19"] = "S-BLOCK",
      i = "INSERT",
      ic = "INSERT",
      ix = "INSERT",
      R = "REPLACE",
      Rc = "REPLACE",
      Rx = "REPLACE",
      Rv = "V-REPLACE",
      Rvc = "V-REPLACE",
      Rvx = "V-REPLACE",
      c = "COMMAND",
      cv = "EX",
      ce = "EX",
      r = "REPLACE",
      rm = "MORE",
      ["r?"] = "CONFIRM",
      ["!"] = "SHELL",
      t = "TERMINAL",
      ["V-M"] = "V-MULTI",
    },
  },
  init = function(self)
    self.mode = vim.fn.mode(1)
  end,
  update = {
    "ModeChanged",
    pattern = "*:*",
    callback = vim.schedule_wrap(function()
      vim.cmd.redrawstatus()
    end),
  },
  Space,
  {
    provider = function(self)
      return self.mode_names[self.mode]
    end,
  },
  Space,
}

local GitBranch = {
  condition = conditions.is_git_repo,
  Space,
  {
    provider = function()
      return get_icon("Git") .. " " .. vim.b.gitsigns_status_dict.head
    end,
  },
  Space,
}

local GitStatus = {
  condition = conditions.is_git_repo,
  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.added = self.status_dict.added and self.status_dict.added ~= 0
    self.removed = self.status_dict.removed and self.status_dict.removed ~= 0
    self.changed = self.status_dict.changed and self.status_dict.changed ~= 0
    self.has_changes = self.added or self.removed or self.changed
  end,
  Space,
  {
    condition = function(self)
      return self.added
    end,
    provider = function(self)
      return get_icon("GitAdd") .. " " .. self.status_dict.added
    end,
  },
  {
    condition = function(self)
      return self.removed
    end,
    provider = function(self)
      return string.rep(" ", self.added and 1 or 0)
        .. get_icon("GitDelete")
        .. " "
        .. self.status_dict.removed
    end,
  },
  {
    condition = function(self)
      return self.changed
    end,
    provider = function(self)
      return string.rep(" ", (self.added or self.removed) and 1 or 0)
        .. get_icon("GitChange")
        .. " "
        .. self.status_dict.changed
    end,
  },
  Space,
}

local LspProgress = {
  condition = conditions.lsp_attached,
  update = {
    "User",
    pattern = { "LspProgressStatusUpdated", "LspProgressUpdate", "LspRequest" },
    callback = vim.schedule_wrap(function()
      vim.cmd.redrawstatus()
    end),
  },
  Space,
  {
    provider = function()
      return require("lsp-progress").progress({
        format = function(messages)
          return #messages > 0 and table.concat(messages, " ") or ""
        end,
      })
    end,
  },
  Space,
}

local LspAttached = {
  condition = conditions.lsp_attached,
  update = { "LspAttach", "LspDetach" },
  Space,
  {
    provider = function()
      local clients = vim.lsp.get_active_clients()
      local client_names = {}

      for _, client in pairs(clients) do
        if client.name ~= "null-ls" then
          table.insert(client_names, client.name)
        end
      end

      if #client_names > 0 then
        return table.concat(client_names, ", ")
      end

      return nil
    end,
  },
  Space,
}

local Diagnostics = {
  condition = conditions.has_diagnostics,
  static = {
    error = vim.fn.sign_getdefined("DiagnosticSignError")[1],
    warn = vim.fn.sign_getdefined("DiagnosticSignWarn")[1],
    hint = vim.fn.sign_getdefined("DiagnosticSignHint")[1],
    info = vim.fn.sign_getdefined("DiagnosticSignInfo")[1],
  },
  init = function(self)
    self.errors =
      #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings =
      #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints =
      #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.infos =
      #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,
  update = { "DiagnosticChanged" },
  Space,
  {
    condition = function(self)
      return self.errors > 0
    end,
    provider = function(self)
      return self.error.text .. self.errors
    end,
  },
  {
    condition = function(self)
      return self.warnings > 0
    end,
    provider = function(self)
      return string.rep(" ", (self.errors > 0) and 1 or 0)
        .. self.warn.text
        .. self.warnings
    end,
  },
  {
    condition = function(self)
      return self.hints > 0
    end,
    provider = function(self)
      return string.rep(" ", (self.errors > 0 or self.warnings > 0) and 1 or 0)
        .. self.hint.text
        .. self.hints
    end,
  },
  {
    condition = function(self)
      return self.infos > 0
    end,
    provider = function(self)
      return string.rep(
        " ",
        (self.errors > 0 or self.warnings > 0 or self.hints > 0) and 1 or 0
      ) .. self.info.text .. self.infos
    end,
  },
  Space,
}

local CursorLineStatus = {
  Space,
  {
    provider = function()
      local current_line = vim.fn.line(".")
      local total_line = vim.fn.line("$")
      local text = math.modf((current_line / total_line) * 100)
        .. tostring("%%")
      text = string.format("%4s", text)
      return " " .. text
    end,
  },
  Space,
}

local DefaultStatusline = {
  ViMode,

  GitBranch,
  GitStatus,

  Align,
  LspProgress,
  Align,

  LspAttached,
  Diagnostics,
  CursorLineStatus,
}

local Statusline = {
  hl = function()
    if conditions.is_active() then
      return "StatusLine"
    else
      return "StatusLineNC"
    end
  end,
  DefaultStatusline,
}

require("heirline").setup({
  statusline = Statusline,
})
