---@type vim.lsp.Config
return {
  settings = {
    yaml = {
      schemas = require("schemastore").yaml.schemas(),
      validate = true,
      schemaStore = {
        enable = false,
        url = "",
      },
    },
  },
}
