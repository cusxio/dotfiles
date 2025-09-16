-- https://github.com/echasnovski/nvim/blob/5d0a752aad40b08f88aee45fdcd25dc970aeb0a3/after/lsp/lua_ls.lua#L11-L26
---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
      diagnostics = {
        -- Don't analyze whole workspace, as it consumes too much CPU and RAM
        workspaceDelay = -1,
      },
      workspace = {
        -- Don't analyze code from submodules
        ignoreSubmodules = true,
        -- Add Neovim's methods for easier code writing
        library = {
          vim.env.VIMRUNTIME,
          -- [vim.fn.stdpath("data") .. "/site/pack/deps"] = true,
        },
      },
      telemetry = { enable = false },
    },
  },
}
