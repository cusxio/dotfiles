local is_available = require("utils").is_available
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

if is_available("neo-tree.nvim") then
  autocmd("BufEnter", {
    desc = "Open Neo-Tree on startup with directory",
    group = augroup("neotree_start", { clear = true }),
    callback = function()
      if package.loaded["neo-tree"] then
        vim.api.nvim_del_augroup_by_name("neotree_start")
      else
        local stats = vim.loop.fs_stat(vim.api.nvim_buf_get_name(0))
        if stats and stats.type == "directory" then
          vim.api.nvim_del_augroup_by_name("neotree_start")
          require("neo-tree")
        end
      end
    end,
  })
end

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

-- https://github.com/neovim/neovim/wiki/FAQ#cursor-style-isnt-restored-after-exiting-or-suspending-and-resuming-nvim
autocmd({ "VimLeave", "VimSuspend" }, {
  pattern = "*",
  callback = function()
    vim.cmd([[set guicursor=a:ver100]])
  end,
})
