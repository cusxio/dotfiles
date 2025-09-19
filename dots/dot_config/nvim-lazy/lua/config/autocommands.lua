local gr = vim.api.nvim_create_augroup("Autocommands", {})

local opt = vim.opt

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
