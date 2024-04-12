---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    options = {
      opt = {
        colorcolumn = { "80" },
        scrolloff = 15,
      },
    },
    diagnostics = {
      update_in_insert = false,
      virtual_text = false,
    },
  },
}
