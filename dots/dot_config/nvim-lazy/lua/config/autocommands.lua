local o, opt = vim.o, vim.opt

local gr = vim.api.nvim_create_augroup("Autocommands", {})
local au = function(event, pattern, callback, desc)
  vim.api.nvim_create_autocmd(event, { group = gr, pattern = pattern, callback = callback, desc = desc })
end

-- https://github.com/nvim-mini/mini.nvim/blob/cf515dd765665d51086e418e587a4f7ebc650ba1/lua/mini/basics.lua#L721-L735
au("ModeChanged", "*:[iV\x16]*", function()
  vim.wo.relativenumber = vim.wo.number
end, "Show relative line numbers")

au("ModeChanged", "[iV\x16]*:*", function()
  vim.wo.relativenumber = string.find(vim.fn.mode(), "^[iV\22]") ~= nil
end, "Hide relative line numbers")

-- https://neovim.io/doc/user/faq.html#faq
au({ "VimLeave", "VimSuspend" }, "*", function()
  -- vim.cmd([[set guicursor=a:ver100-blinkwait1-blinkoff500-blinkon500]])

  --https://github.com/microsoft/terminal/issues/13420#issuecomment-1501102143
  opt.guicursor = ""
  vim.fn.chansend(vim.v.stderr, "\x1b[ q")
end, "Restore terminal cursor")

-- https://github.com/AstroNvim/AstroNvim/blob/8379e70578bb2f4b2227d55ccc1ae4fd2ab8bb51/lua/astronvim/plugins/_astrocore_autocmds.lua#L269-L280
local search_keys = {
  ["<CR>"] = true,
  ["n"] = true,
  ["N"] = true,
  ["*"] = true,
  ["#"] = true,
  ["?"] = true,
  ["/"] = true,
}
local mid_mapping = false
opt.hlsearch = false

vim.on_key(function(char)
  if vim.fn.mode() ~= "n" or mid_mapping then
    return
  end

  local key = vim.fn.keytrans(char)

  local new_hlsearch_state = search_keys[key] or false

  if o.hlsearch ~= new_hlsearch_state then
    opt.hlsearch = new_hlsearch_state
  end

  mid_mapping = true
  vim.schedule(function()
    mid_mapping = false
  end)
end, vim.api.nvim_create_namespace("auto_hlsearch"))
