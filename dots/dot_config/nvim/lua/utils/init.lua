local M = {}

local icons = {
  DiagnosticError = " ",
  DiagnosticWarn = " ",
  DiagnosticInfo = "󰋼 ",
  DiagnosticHint = "󰌵 ",
  --
  FileModified = "",
  --
  Git = "󰊢",
  GitAdd = "",
  GitBranch = "",
  GitChange = "",
  GitConflict = "",
  GitDelete = "",
  GitIgnored = "◌",
  GitRenamed = "➜",
  GitStaged = "✓",
  GitUnstaged = "✗",
  GitUntracked = "★",
  --
  LSPLoaded = "",
  LSPLoading1 = "",
  LSPLoading2 = "󰀚",
  LSPLoading3 = "",
}

function M.get_icon(kind, padding)
  local icon = icons[kind]
  return icon and icon .. string.rep(" ", padding or 0) or ""
end

function M.is_available(plugin)
  local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
  return lazy_config_avail and lazy_config.plugins[plugin] ~= nil
end

return M
