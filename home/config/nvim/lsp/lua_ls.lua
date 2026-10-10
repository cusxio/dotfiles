-- https://github.com/echasnovski/nvim/blob/5d0a752aad40b08f88aee45fdcd25dc970aeb0a3/after/lsp/lua_ls.lua#L11-L26
---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
      workspace = {
        checkThirdParty = false,
      },
      codeLens = {
        enable = true,
      },
      hint = {
        enable = true,
      },
    },
  },
}
