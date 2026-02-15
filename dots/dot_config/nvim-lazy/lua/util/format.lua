---@class Formatter
---@field name string
---@field primary? boolean
---@field priority number
---@field format fun(bufnr: number)
---@field sources fun(bufnr: number): string[]

local M = {}

M.formatters = {} ---@type Formatter[]

---@param formatter Formatter
function M.register(formatter)
  M.formatters[#M.formatters + 1] = formatter
  table.sort(M.formatters, function(a, b)
    return a.priority > b.priority
  end)
end

---@param name string LSP client name
---@param priority number
function M.register_lsp(name, priority)
  M.register({
    name = name,
    primary = false,
    priority = priority,
    format = function(buf)
      vim.lsp.buf.format({ bufnr = buf, async = false, filter = function(c) return c.name == name end })
    end,
    sources = function(buf)
      return #vim.lsp.get_clients({ bufnr = buf, name = name }) > 0 and { name } or {}
    end,
  })
end

---@param name string LSP client name
---@param priority number
---@param command string workspace/executeCommand command name
---@param args_fn fun(buf: number): any[] function returning command arguments
function M.register_lsp_command(name, priority, command, args_fn)
  M.register({
    name = name,
    primary = false,
    priority = priority,
    format = function(buf)
      vim.lsp.buf_request_sync(buf, "workspace/executeCommand", {
        command = command,
        arguments = args_fn(buf),
      }, 5000)
    end,
    sources = function(buf)
      return #vim.lsp.get_clients({ bufnr = buf, name = name }) > 0 and { name } or {}
    end,
  })
end

---@param buf? number
---@return (Formatter|{active:boolean, resolved:string[]})[]
function M.resolve(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  local have_primary = false

  return vim.tbl_map(function(formatter)
    local sources = formatter.sources(buf)
    local active = #sources > 0 and (not formatter.primary or not have_primary)
    have_primary = have_primary or (active and formatter.primary) or false

    return setmetatable({
      active = active,
      resolved = sources,
    }, { __index = formatter })
  end, M.formatters)
end

---@param buf? number
function M.enabled(buf)
  buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
  local gaf = vim.g.autoformat
  local baf = vim.b[buf].autoformat

  if baf ~= nil then
    return baf
  end

  return gaf == nil or gaf
end

---@param buf? boolean
function M.toggle(buf)
  if buf then
    vim.b.autoformat = not M.enabled()
  else
    vim.g.autoformat = not M.enabled()
    vim.b.autoformat = nil
  end
  vim.notify(string.format("Autoformat %s", M.enabled() and "enabled" or "disabled"), vim.log.levels.INFO)
end

---@param opts? {force?: boolean, buf?: number}
function M.format(opts)
  opts = opts or {}
  local buf = opts.buf or vim.api.nvim_get_current_buf()

  if not (opts.force or M.enabled(buf)) then
    return
  end

  for _, formatter in ipairs(M.resolve(buf)) do
    if formatter.active then
      local ok, err = pcall(formatter.format, buf)
      if not ok then
        vim.notify(string.format("Formatter `%s` failed: %s", formatter.name, err), vim.log.levels.WARN)
      end
    end
  end
end

function M.info()
  local buf = vim.api.nvim_get_current_buf()
  local lines = {
    "# Formatters",
    string.format("Autoformat: %s", M.enabled(buf) and "enabled" or "disabled"),
    "",
  }

  for _, formatter in ipairs(M.resolve(buf)) do
    if #formatter.resolved > 0 then
      local status = formatter.active and "(active)" or "(inactive)"
      table.insert(lines, string.format("**%s** %s [priority: %d]", formatter.name, status, formatter.priority))
      for _, source in ipairs(formatter.resolved) do
        table.insert(lines, string.format("  - %s", source))
      end
    end
  end

  vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO)
end

function M.setup()
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("Formatting", { clear = true }),
    callback = function(event)
      M.format({ buf = event.buf })
    end,
  })

  vim.api.nvim_create_user_command("FormatInfo", M.info, { desc = "Show formatter info" })
  vim.api.nvim_create_user_command("FormatToggle", function()
    M.toggle(false)
  end, { desc = "Toggle autoformat (global)" })
  vim.api.nvim_create_user_command("FormatToggleBuf", function()
    M.toggle(true)
  end, { desc = "Toggle autoformat (buffer)" })
end

return M
