---@type vim.lsp.Config
return {
  settings = {
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
    },
    typescript = {
      format = { enable = false },
    },
    javascript = {
      format = {
        enable = false,
      },
    },
  },
}
