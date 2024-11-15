---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    options = {
      opt = {
        cmdheight = 1,
        colorcolumn = { "80" },
        foldcolumn = "0",
        scrolloff = 15,
        wrap = true,
      },
    },
    diagnostics = {
      update_in_insert = false,
      virtual_text = { severity = { min = vim.diagnostic.severity.WARN } },
    },
  },
}
