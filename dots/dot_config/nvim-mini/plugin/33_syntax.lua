local now_if_args = vim.fn.argc(-1) > 0 and now or later

now_if_args(function()
  add({
    source = "nvim-treesitter/nvim-treesitter",
    checkout = "main",
    hooks = {
      post_checkout = function()
        vim.cmd("TSUpdate")
      end,
    },
  })
  add({
    source = "nvim-treesitter/nvim-treesitter-textobjects",
    checkout = "main",
  })
end)

lz({
  "nvim-treesitter",
  event = table.insert(_G.lazy_file_events, "DeferredUIEnter"),
  lazy = vim.fn.argc(-1) == 0,
  after = function()
    local ensure_installed = {
      "typescript",
      "tsx",
      "lua",
      "comment",
      "astro",
      "html",
      "javascript",
      "json",
      "jsonc",
      "html",
      "yaml",
      "toml",
      "diff",
      "markdown",
      "regex",
      "vim",
    }
    -- https://github.com/echasnovski/nvim/blob/5d0a752aad40b08f88aee45fdcd25dc970aeb0a3/plugin/21_plugins.lua#L23-L31
    local isnt_installed = function(lang)
      return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false)
        == 0
    end
    local to_install = vim.tbl_filter(isnt_installed, ensure_installed)
    if #to_install > 0 then
      require("nvim-treesitter").install(to_install)
    end

    -- Ensure enabled
    local filetypes = vim
      .iter(ensure_installed)
      :map(vim.treesitter.language.get_filetypes)
      :flatten()
      :totable()

    local ts_start = function(ev)
      vim.treesitter.start(ev.buf)
    end
    vim.api.nvim_create_autocmd(
      "FileType",
      { pattern = filetypes, callback = ts_start }
    )
  end,
})

lz({
  "nvim-treesitter-textobjects",
  lazy = vim.fn.argc(-1) == 0,
  event = "DeferredUIEnter",
  before = function()
    require("lz.n").trigger_load("nvim-treesitter")
  end,
})
