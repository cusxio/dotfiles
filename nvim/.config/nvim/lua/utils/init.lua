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
}

function M.get_icon(kind)
  return icons[kind] or ""
end

function M.is_available(plugin)
  local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
  return lazy_config_avail and lazy_config.plugins[plugin] ~= nil
end

return M
