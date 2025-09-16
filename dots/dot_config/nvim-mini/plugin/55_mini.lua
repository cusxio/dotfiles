now(function()
  require("mini.icons").setup()
end)

later(function()
  require("mini.extra").setup()
end)

later(function()
  local ai = require("mini.ai")
  ai.setup({
    custom_textobjects = {
      B = MiniExtra.gen_ai_spec.buffer(),
      F = ai.gen_spec.treesitter({
        a = "@function.outer",
        i = "@function.inner",
      }),
    },
  })
end)

later(function()
  require("mini.bracketed").setup()
end)

later(function()
  require("mini.bufremove").setup()
end)

later(function()
  require("mini.comment").setup()
end)

later(function()
  require("mini.pairs").setup({
    modes = { insert = true },
  })
end)

later(function()
  require("mini.surround").setup()
  -- Disable `s` shortcut (use `cl` instead) for safer usage of 'mini.surround'
  vim.keymap.set({ "n", "x" }, "s", "<Nop>")
end)

later(function()
  require("mini.move").setup({ options = { reindent_linewise = false } })
end)

later(function()
  require("mini.cursorword").setup()
end)
