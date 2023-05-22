local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("BufWinEnter", {
  desc = "Make q close help, man, quickfix, dap floats",
  group = augroup("q_close_windows", { clear = true }),
  callback = function(event)
    local filetype =
      vim.api.nvim_get_option_value("filetype", { buf = event.buf })
    local buftype =
      vim.api.nvim_get_option_value("buftype", { buf = event.buf })
    if buftype == "nofile" or filetype == "help" then
      vim.keymap.set(
        "n",
        "q",
        "<cmd>close<cr>",
        { buffer = event.buf, silent = true, nowait = true }
      )
    end
  end,
})

autocmd("QuitPre", {
  desc = "Quit NvChad if more than one window is open and only sidebar windows are list",
  group = augroup("auto_quit", { clear = true }),
  callback = function()
    local invalid_win = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match("NvimTree_") ~= nil then
        table.insert(invalid_win, w)
      end
    end
    if #invalid_win == #wins - 1 then
      -- Should quit, so we close all invalid windows.
      for _, w in ipairs(invalid_win) do
        vim.api.nvim_win_close(w, true)
      end
    end
  end,
})
